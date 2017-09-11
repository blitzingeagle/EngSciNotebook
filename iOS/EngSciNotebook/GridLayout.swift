//
//  GridLayout.swift
//  EngSciNotebook
//
//  Created by Morris Chen on 2017-09-10.
//  Copyright © 2017 Morris Chen. All rights reserved.
//

import UIKit

class GridLayout : UICollectionViewFlowLayout {
    
    var numberOfColumns: Int = 3
    
    init(numberOfColumns: Int) {
        super.init()
        self.numberOfColumns = numberOfColumns
        self.minimumInteritemSpacing = 1
        self.minimumLineSpacing = 1
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var itemSize: CGSize {
        get {
            if let collectionView = collectionView {
                let collectionViewWidth = collectionView.frame.width
                let itemWidth = (collectionViewWidth/CGFloat(self.numberOfColumns)) - self.minimumInteritemSpacing
                
                return CGSize(width: itemWidth, height: itemWidth)
            }
            
            return CGSize(width: 100, height: 100)
        }
        set {
            super.itemSize = newValue
        }
    }
    
}
