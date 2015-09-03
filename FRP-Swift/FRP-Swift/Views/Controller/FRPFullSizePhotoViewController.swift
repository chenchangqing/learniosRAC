
//
//  FRPFullSizePhotoViewController.swift
//  FRP-Swift
//
//  Created by green on 15/9/4.
//  Copyright (c) 2015年 green. All rights reserved.
//

import UIKit

class FRPFullSizePhotoViewController: UIViewController,UIPageViewControllerDataSource, UIPageViewControllerDelegate {

    // 初始化Controller后应该马上设置viewModel
    var fullSizePhotoViewModel : FRPFullSizePhotoViewModel!
    
    private var pageViewController: UIPageViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 初始化pageViewController
        pageViewController = UIPageViewController(transitionStyle: UIPageViewControllerTransitionStyle.Scroll, navigationOrientation: UIPageViewControllerNavigationOrientation.Horizontal, options: [UIPageViewControllerOptionInterPageSpacingKey:30])
        pageViewController.dataSource = self
        pageViewController.delegate = self
        
        // setViewControllers
        pageViewController.setViewControllers([tempPhotoViewController()], direction: UIPageViewControllerNavigationDirection.Forward, animated: false, completion: nil)
        
        // add childViewController
        self.addChildViewController(pageViewController)
        
        // Configure subviews
        pageViewController.view.frame = self.view.bounds
        view.addSubview(pageViewController.view)
        
        // self'backgroundcolor
        view.backgroundColor = UIColor.blackColor()
    }
    
    /**
     * 生成指定的photoViewController
     */
    func tempPhotoViewController() -> UIViewController {
        
        let photoViewController = FRPPhotoViewController()
        photoViewController.photoViewModel = FRPPhotoViewModel(photoModel: fullSizePhotoViewModel.photoModel)
        
        // self'title
        self.title = fullSizePhotoViewModel.photoModel.photoName
        return photoViewController
    }
    
    // MARK: - UIPageViewControllerDelegate
    
    func pageViewController(pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [AnyObject], transitionCompleted completed: Bool) {
        
    }
    
    // MARK: - UIPageViewControllerDataSource

    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        
        let array = fullSizePhotoViewModel.photoModelList
        var photoIndex:Int = fullSizePhotoViewModel.photoIndex
        photoIndex--
        if photoIndex < 0 {
            
            photoIndex = array.count - 1
        } else if photoIndex >= array.count {
            
            photoIndex = 0
        }
        fullSizePhotoViewModel.photoIndex = photoIndex
        return tempPhotoViewController()
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        
        let array = fullSizePhotoViewModel.photoModelList
        var photoIndex:Int = fullSizePhotoViewModel.photoIndex
        photoIndex--
        if photoIndex < 0 {
            
            photoIndex = array.count - 1
        } else if photoIndex >= array.count {
            
            photoIndex = 0
        }
        
        fullSizePhotoViewModel.photoIndex = fullSizePhotoViewModel.photoIndex + 1
        return tempPhotoViewController()
    }

}
