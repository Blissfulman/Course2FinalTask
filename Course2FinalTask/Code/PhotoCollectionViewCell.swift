//
//  PhotoCollectionViewCell.swift
//  Course2FinalTask
//
//  Created by User on 07.08.2020.
//  Copyright © 2020 e-Legion. All rights reserved.
//

import Foundation
import UIKit
import DataProvider

class PhotoCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var photoImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()

//        photoNameLabel.backgroundColor = UIColor.white.withAlphaComponent(Const.photoLabelBackgroundAlpha)
//        photoImageView.contentMode = .scaleAspectFill
    }

    override func layoutSubviews() {
        super.layoutSubviews()

//        photoImageView.frame = bounds
//        photoNameLabel.frame = CGRect(x: 0,
//                                      y: frame.height - Const.photoLabelHeight,
//                                      width: frame.width,
//                                      height: Const.photoLabelHeight)
    }
    
    func configure(_ photo: UIImage) {
        photoImage.image = photo
    }
}
