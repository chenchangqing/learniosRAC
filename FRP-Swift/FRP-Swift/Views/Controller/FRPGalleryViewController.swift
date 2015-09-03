//
//  FRPGalleryViewController.swift
//  FRP-Swift
//
//  Created by green on 15/9/3.
//  Copyright (c) 2015年 green. All rights reserved.
//

import UIKit

let reuseIdentifier = "Cell"

class FRPGalleryViewController: UICollectionViewController {

    private var viewModel = FRPGalleryViewModel(photoModelList: [FRPPhotoModel]())

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
    }

    // MARK: UICollectionViewDataSource


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return (viewModel.model as! [FRPPhotoModel]).count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    
        // Configure the cell
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! FRPCell
    
        return cell
    }

}
