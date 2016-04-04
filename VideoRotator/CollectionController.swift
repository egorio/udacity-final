//
//  ViewController.swift
//  VideoRotator
//
//  Created by Egorio on 3/30/16.
//  Copyright © 2016 Egorio. All rights reserved.
//

import UIKit

class CollectionController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!

    var storage: VideoStorage = LocalVideoStorage()
    var videos: [Video] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.delegate = self
        collectionView.dataSource = self
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        configureCellSize()

        // Load videos from storage
        storage.getVideos({ (videos, pages, error) in
            self.runInMainQueue({
                guard error == nil else {
                    return self.showErrorAlert("Videos not found", message: "Please ...")
                }

                self.videos = videos
                self.collectionView.reloadData()
            })
        })
    }

    /*
     * Recaltulates cell sizes on rotating
     */
    override func willAnimateRotationToInterfaceOrientation(toInterfaceOrientation: UIInterfaceOrientation, duration: NSTimeInterval) {
        configureCellSize()
    }

    /*
     * Configures cells and spaces sizes thru collection view flow layout
     */
    func configureCellSize() {
        let screen = UIScreen.mainScreen()
        let cellsSpacing: CGFloat = Constants.collectionCellsSpacing
        let cellsPerLine: CGFloat = screen.bounds.width < screen.bounds.height
            ? Constants.collectionCellsPerRowPortrait
            : Constants.collectionCellsPerRowLandscape
        let cellSize = (screen.bounds.width - ((cellsPerLine + 1) * cellsSpacing)) / cellsPerLine

        UIView.performWithoutAnimation({
            let flowLayout = self.collectionView.collectionViewLayout as! UICollectionViewFlowLayout
            flowLayout.itemSize = CGSize(width: cellSize, height: cellSize)
            flowLayout.minimumLineSpacing = cellsSpacing;
            flowLayout.minimumInteritemSpacing = cellsSpacing;
            flowLayout.sectionInset = UIEdgeInsetsMake(10, cellsSpacing, 50, cellsSpacing)
            flowLayout.invalidateLayout()
        })
    }
}

extension CollectionController: UICollectionViewDelegate, UICollectionViewDataSource {

    /*
     * Returns the number of items in the specified section
     */
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videos.count
    }

    /*
     * Returns the cell that corresponds to the specified item in the collection view
     */
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let video = videos[indexPath.item]
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("VideoCell", forIndexPath: indexPath) as! VideoCell

        storage.getPreviewImage(video, size: Constants.videoThumbnailSize) { (image, error) in
            self.runInMainQueue({
                cell.configure(image)
            })
        }

        return cell
    }

    /*
     * Handles cell selection
     */
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let video = videos[indexPath.item]
        let controller = storyboard!.instantiateViewControllerWithIdentifier("EditorController") as! EditorController

        controller.storage = storage
        controller.video = video

        navigationController?.pushViewController(controller, animated: true)
    }
}
