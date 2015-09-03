//
//  FRPCell.swift
//  FRP-Swift
//
//  Created by green on 15/9/3.
//  Copyright (c) 2015年 green. All rights reserved.
//

import UIKit
import ReactiveCocoa

class FRPCell: UICollectionViewCell {
    
    private var imageView: UIImageView!
    
    private var imageViewModel = ImageViewModel(urlString: nil)
    
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
        
        // Observe
        RACObserve(imageViewModel, "image").distinctUntilChanged().subscribeNextAs({ (image:UIImage!) -> () in
            
            self.imageView.image = image
        })
        
        self.rac_prepareForReuseSignal.subscribeNext { (any:AnyObject!) -> Void in
            
            self.imageView.image = nil
        }
    }
    
    func bindViewModel(viewModel: FRPPhotoModel) {
        
        imageViewModel.urlString = viewModel.thumbnailURL
        imageViewModel.downloadImageCommand.execute(nil)
    }
}
