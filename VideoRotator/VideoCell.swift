//
//  VideoCell.swift
//  VideoRotator
//
//  Created by Egorio on 3/31/16.
//  Copyright © 2016 Egorio. All rights reserved.
//

import UIKit

class VideoCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!

    override func awakeFromNib() {
        layer.borderWidth = 1
        layer.borderColor = UIColor(white: 0.1, alpha: 1).CGColor
    }

    func configure(image: UIImage?) {
        imageView.image = image
    }
}
