//
//  ImageCollectionViewCell.swift
//  AMIDECO
//
//  Created by saif on 29/11/2017.
//  Copyright © 2017 AS Technology. All rights reserved.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.imageView.image = nil
    }
}
