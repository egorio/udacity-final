//
//  PhotoStorage.swift
//  VideoRotator
//
//  Created by Egorio on 3/31/16.
//  Copyright © 2016 Egorio. All rights reserved.
//

import UIKit
import AVFoundation

protocol VideoStorage {

    /*
     * Returns found videos from specific storage (Local, Google Drive, DropBox etc.)
     */
    func getVideos(handler: (videos: [Video], pages: Int, error: String?) -> Void)

    /*
     * Returns preview image for specific video object
     */
    func getPreviewImage(video: Video, size: CGFloat, handler: (image: UIImage?, error: String?) -> Void)

    /*
     * Returns AVAsset for specific video object
     */
    func getVideoAsset(video: Video, handler: (asset: AVAsset?, error: String?) -> Void)
}