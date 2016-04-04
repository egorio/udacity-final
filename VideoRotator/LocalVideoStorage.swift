//
//  LocalPhotoStorage.swift
//  VideoRotator
//
//  Created by Egorio on 3/31/16.
//  Copyright © 2016 Egorio. All rights reserved.
//

import Photos

class LocalVideoStorage: VideoStorage {

    /*
     * Returns found videos from local files
     */
    func getVideos(handler: (videos: [Video], pages: Int, error: String?) -> Void) {
        let options = PHFetchOptions()
        options.sortDescriptors?.append(NSSortDescriptor(key: "creationDate", ascending: false))

        let results = PHAsset.fetchAssetsWithMediaType(.Video, options: options)
        var videos: [Video] = []

        if results.count > 0 {
            for i in 0 ... results.count - 1 {
                videos.append(Video(source: results[i]))
            }
        }

        handler(videos: videos, pages: 1, error: nil)
    }

    /*
     * Returns preview image for specific video object
     */
    func getPreviewImage(video: Video, size: CGFloat, handler: (image: UIImage?, error: String?) -> Void) {
        guard let asset = video.source as? PHAsset else {
            return handler(image: nil, error: "")
        }

        let imageOptions = PHImageRequestOptions()
        imageOptions.resizeMode = PHImageRequestOptionsResizeMode.Fast

        PHImageManager.defaultManager().requestImageForAsset(asset, targetSize: CGSizeMake(size, size), contentMode: .AspectFit, options: nil, resultHandler: { (result, info) in
            if let image = result {
                handler(image: image, error: nil)
            }
        })

        handler(image: nil, error: "")
    }

    /*
     * Returns AVAsset for specific video object
     */
    func getVideoAsset(video: Video, handler: (asset: AVAsset?, error: String?) -> Void) {
        guard let photoAsset = video.source as? PHAsset else {
            return handler(asset: nil, error: "Oops")
        }

        PHImageManager().requestAVAssetForVideo(photoAsset, options: nil) { (asset, audio, dict) in
            guard asset != nil else {
                return handler(asset: nil, error: "Oops")
            }

            handler(asset: asset!, error: nil)
        }
    }
}
