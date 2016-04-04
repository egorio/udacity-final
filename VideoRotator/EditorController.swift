//
//  EditorController.swift
//  VideoRotator
//
//  Created by Egorio on 3/31/16.
//  Copyright © 2016 Egorio. All rights reserved.
//

import UIKit
import AVKit
import Photos

class EditorController: UIViewController {

    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var rotateButton: UIBarButtonItem!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var playerButton: UIButton!

    var storage: VideoStorage!
    var video: Video!

    var playerLayer = AVPlayerLayer()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.layer.addSublayer(playerLayer)

        configurePlayerSize()
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)

        storage.getVideoAsset(video) { (asset, error) in
            self.runInMainQueue({
                guard error == nil else {
                    return // ...
                }

                guard asset != nil else {
                    return // ...
                }

                self.playerLayer.player = AVPlayer(playerItem: AVPlayerItem(asset: asset!))
            })
        }
    }

    /*
     * Recaltulates player layer size on rotating
     */
    override func willAnimateRotationToInterfaceOrientation(toInterfaceOrientation: UIInterfaceOrientation, duration: NSTimeInterval) {
        configurePlayerSize()
    }

    /*
     * Configures cells and spaces sizes thru collection view flow layout
     */
    func configurePlayerSize() {
        UIView.performWithoutAnimation({
            self.playerLayer.frame = self.view.bounds
        })
    }

    @IBAction func play(sender: AnyObject) {
        if playerLayer.player!.rate == 0.0 {
            playerLayer.player!.play()
            playerButton.layer.opacity = 0.1
        }
        else {
            playerLayer.player!.pause()
            playerButton.layer.opacity = 1
        }
    }

    @IBAction func goBack(sender: AnyObject) {
        navigationController?.popViewControllerAnimated(true)
    }

    @IBAction func rotate(sender: AnyObject) {
        let radians: CGFloat = atan2(playerLayer.affineTransform().b, playerLayer.affineTransform().a)
        let degrees: CGFloat = radians * CGFloat(180 / M_PI)
        let transform: CGAffineTransform = CGAffineTransformMakeRotation((90 + degrees) * CGFloat(M_PI / 180))

        playerLayer.setAffineTransform(transform)
        playerLayer.frame = self.view.bounds
    }

    @IBAction func save(sender: AnyObject) {
        saveButton.enabled = false

        playerLayer.player!.currentItem!.asset

        storage.getVideoAsset(video) { (asset, error) in
            guard asset != nil else {
                return // ... Could not get the video file
            }
        }
    }
}
