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

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.delegate = self
        collectionView.dataSource = self
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)

        configureCellSize()
    }

    /*
     * Recaltulate cell sizes on rotating
     */
    override func willAnimateRotationToInterfaceOrientation(toInterfaceOrientation: UIInterfaceOrientation, duration: NSTimeInterval) {
        configureCellSize()
    }

    func configureCellSize() {
        let cellsSpacing: CGFloat = 4
        let cellsPerLine: CGFloat = UIDevice.currentDevice().orientation.isLandscape ? 5 : 3
        let cellSize = (collectionView.bounds.width - ((cellsPerLine - 1) * cellsSpacing)) / cellsPerLine
        
        let flowLayout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        flowLayout.itemSize = CGSize(width: cellSize, height: cellSize)
        flowLayout.minimumInteritemSpacing = cellsSpacing;
        flowLayout.minimumLineSpacing = cellsSpacing;
        flowLayout.invalidateLayout()
    }
}

extension CollectionController: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }

    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let controller = storyboard!.instantiateViewControllerWithIdentifier("EditorController")

        navigationController?.pushViewController(controller, animated: true)
    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("VideoCell", forIndexPath: indexPath)

        return cell
    }

    /*
     func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {

     let cellsPerLine: CGFloat = UIDevice.currentDevice().orientation.isLandscape ? 5 : 3

     print(cellsPerLine)

     let size = (collectionView.bounds.width - ((cellsPerLine - 1) * 10)) / cellsPerLine
     return CGSize(width: size, height: size)
     }
     */
}
