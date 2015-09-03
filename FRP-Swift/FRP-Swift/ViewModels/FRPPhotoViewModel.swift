//
//  FRPPhotoViewModel.swift
//  FRP-Swift
//
//  Created by green on 15/9/4.
//  Copyright (c) 2015年 green. All rights reserved.
//

import UIKit
import ReactiveViewModel
import ReactiveCocoa

class FRPPhotoViewModel: ImageViewModel {
    
    let photoModelDataSourceProtocol = FRPPhotoModelDataSource.shareInstance()
    var searchFullsizedURLCommand :RACCommand!
    var errorMsg : String = ""
   
    init(photoModel:FRPPhotoModel) {
        
        super.init(urlString: nil,model:photoModel,isNeedCompress:false)
        
        // 初始化command
        searchFullsizedURLCommand = RACCommand(signalBlock: { (any:AnyObject!) -> RACSignal! in
            
            if let identifier=(self.model as! FRPPhotoModel).identifier {
                
                return self.photoModelDataSourceProtocol.searchFullsizedURL(identifier)
            } else {
                
                return RACSignal.empty()
            }
            
        })
        
        // 错误处理
        searchFullsizedURLCommand.errors.subscribeNextAs { (error:NSError) -> () in
            
            self.setValue(error.localizedDescription, forKey: "errorMsg")
        }
        
        // 更新大图URLString
        searchFullsizedURLCommand.executionSignals.switchToLatest().subscribeNextAs { (fullsizedURL:String) -> () in
            
            // 更新图片
            self.urlString = fullsizedURL
            self.downloadImageCommand.execute(nil)
        }
        
        // 激活后开始查询
        didBecomeActiveSignal.subscribeNext { (any:AnyObject!) -> Void in
            
            searchFullsizedURLCommand.execute(nil)
        }
        
        // Observe
        RACObserve(self, "model").subscribeNext { (any:AnyObject!) -> Void in
            
            searchFullsizedURLCommand.execute(nil)
        }
    }
}
