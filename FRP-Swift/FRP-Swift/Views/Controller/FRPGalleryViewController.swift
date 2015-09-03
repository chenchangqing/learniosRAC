//
//  FRPGalleryViewController.swift
//  FRP-Swift
//
//  Created by green on 15/9/3.
//  Copyright (c) 2015年 green. All rights reserved.
//

import UIKit
import SVProgressHUD

let reuseIdentifier = "Cell"

class FRPGalleryViewController: UICollectionViewController {

    private var viewModel = FRPGalleryViewModel()

    required init(coder aDecoder: NSCoder) {

        super.init(collectionViewLayout: FRPGalleryFlowLayout())
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView!.registerClass(FRPCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        // Binding to view model
        RACObserve(viewModel, "model").subscribeNextAs { (photoModelList:[FRPPhotoModel]) -> () in
            
            self.collectionView!.reloadData()
        }
        
        // 激活model
        viewModel.active = true
        
        // 提示
        viewModel.searchFRPPhotoModelListCommand.executing.subscribeNextAs { (isExecuting:Bool) -> () in
            
            if isExecuting {
                
                SVProgressHUD.show()
            } else {
                
                if !self.viewModel.errorMsg.isEmpty {
                    
                    SVProgressHUD.showErrorWithStatus(self.viewModel.errorMsg)
                } else {
                    
                    SVProgressHUD.dismiss()
                }
            }
        }
        
        self.edgesForExtendedLayout = UIRectEdge.None
        
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        (viewModel.model as! NSArray).rac_sequence.signal().subscribeNext { (any:AnyObject!) -> Void in
            
            println((any as! FRPPhotoModel).fullsizedURL)
        }
    }

    // MARK: UICollectionViewDataSource


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return (viewModel.model as! [FRPPhotoModel]).count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    
        // Configure the cell
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! FRPCell
    
        cell.bindViewModel((viewModel.model as! [FRPPhotoModel])[indexPath.row])
        return cell
    }

}
