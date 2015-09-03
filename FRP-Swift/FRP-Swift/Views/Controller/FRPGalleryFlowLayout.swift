//
//  FRPGalleryFlowLayout.swift
//  FRP-Swift
//
//  Created by green on 15/9/3.
//  Copyright (c) 2015年 green. All rights reserved.
//

import UIKit

class FRPGalleryFlowLayout: UICollectionViewFlowLayout {
   
    override init() {
        
        super.init()
        
        setup()
    }

    required init(coder aDecoder: NSCoder) {

        super.init(coder: aDecoder)
        
        setup()
    }
    
    private func setup() {
        
        let screenWidth = UIScreen.mainScreen().bounds.size.width
        let itemWidth:CGFloat = (screenWidth - 30)/2
        self.itemSize = CGSizeMake(itemWidth, itemWidth)
        self.minimumInteritemSpacing = 10
        self.minimumLineSpacing = 10
        self.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10)
    }
}
