//
//  FRPCell.swift
//  FRP-Swift
//
//  Created by green on 15/9/3.
//  Copyright (c) 2015年 green. All rights reserved.
//

import UIKit

class FRPCell: UICollectionViewCell {
    
    private var imageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }

    required init(coder aDecoder: NSCoder) {
        
        super.init(coder:aDecoder)
        
        setup()
    }
    
    private func setup() {
        
        imageView = UIImageView()
        
        // add
        self.contentView.addSubview(imageView)
        
        // background color
        self.backgroundColor = UIColor.darkGrayColor()
        
        // constrains
        imageView.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[imageView]-0-|", options: NSLayoutFormatOptions(0), metrics: nil, views: ["imageView":imageView]))
        self.contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[imageView]-0-|", options: NSLayoutFormatOptions(0), metrics: nil, views: ["imageView":imageView]))
    }
}
