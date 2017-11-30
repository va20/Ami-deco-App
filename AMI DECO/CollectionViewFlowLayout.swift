//
//  CollectionViewFlowLayout.swift
//  AMIDECO
//
//  Created by saif on 30/11/2017.
//  Copyright © 2017 AS Technology. All rights reserved.
//

import UIKit

class CollectionViewFlowLayout: UICollectionViewFlowLayout {
    
    override init(){
        super.init()
        setupLayout()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupLayout()
        
    }
    
    override var itemSize: CGSize{
        set{}
        
        get{
            
            let numberOfColumns: CGFloat = 3
            let itemWidth = (self.collectionView!.frame.width - (numberOfColumns - 1))/numberOfColumns
            return CGSize(width: itemWidth, height: itemWidth)
        }
    }
    
    
    func setupLayout(){
        minimumInteritemSpacing = 1
        minimumLineSpacing = 1
        scrollDirection = .vertical
    }
}
