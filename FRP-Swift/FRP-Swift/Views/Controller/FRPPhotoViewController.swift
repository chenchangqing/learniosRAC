//
//  FRPPhotoViewController.swift
//  FRP-Swift
//
//  Created by green on 15/9/4.
//  Copyright (c) 2015年 green. All rights reserved.
//

import UIKit
import ReactiveCocoa
import SVProgressHUD

class FRPPhotoViewController: UIViewController {

    // 初始化Controller后应该马上设置viewModel
    var photoViewModel : FRPPhotoViewModel!
    
    var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configure self's view
        view.backgroundColor = UIColor.blackColor()

        // 初始化imageView
        imageView = UIImageView(frame: view.bounds)
        imageView.contentMode = UIViewContentMode.ScaleAspectFit
        view.addSubview(imageView)
        
        // Observe
        RACObserve(photoViewModel, "image") ~> RAC(imageView,"image")
        
        // 提示
        photoViewModel.searchFullsizedURLCommand.executing.subscribeNextAs { (isExecuting:Bool) -> () in
            
            if isExecuting {
                
                SVProgressHUD.show()
            } else {
                
                if !self.photoViewModel.errorMsg.isEmpty {
                    
                    SVProgressHUD.showErrorWithStatus(self.photoViewModel.errorMsg)
                } else {
                    
                    SVProgressHUD.dismiss()
                }
            }
        }
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        photoViewModel.active = true
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        photoViewModel.active = false
    }

}
