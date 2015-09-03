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
    var isLoading : Bool = false
   
    init(photoModel:FRPPhotoModel) {
        
        super.init(urlString: nil,model:photoModel,isNeedCompress:false)
        
        // 初始化command
        searchFullsizedURLCommand = RACCommand(signalBlock: { (any:AnyObject!) -> RACSignal! in
            
            self.setValue(true, forKey: "isLoading")
            if let identifier=(self.model as! FRPPhotoModel).identifier {
                
                return self.photoModelDataSourceProtocol.searchFullsizedURL(identifier)
            } else {
                
                return RACSignal.empty()
            }
            
        })
        
        // 错误处理
        searchFullsizedURLCommand.errors.subscribeNextAs { (error:NSError) -> () in
            
            self.setValue(false, forKey: "isLoading")
            self.setValue(error.localizedDescription, forKey: "errorMsg")
        }
        downloadImageCommand.errors.subscribeNextAs { (error:NSError) -> () in
            
            self.setValue(false, forKey: "isLoading")
            self.setValue(error.localizedDescription, forKey: "errorMsg")
        }
        
        // 更新大图URLString
        searchFullsizedURLCommand.executionSignals.switchToLatest()
//            .takeUntil(didBecomeInactiveSignal.skip(1))
            .subscribeNext({ (any:AnyObject!) -> Void in
            
            // 更新图片
            self.urlString = any as? String
            self.downloadImageCommand.execute(nil)
        }, completed: { () -> Void in
            
            println("searchFullsizedURLCommand completed")
        })
        
        downloadImageCommand.executionSignals.switchToLatest()
//            .takeUntil(didBecomeInactiveSignal.skip(1))
            .subscribeNext({ (any:AnyObject!) -> Void in
            
            self.setValue(false, forKey: "isLoading")
        }, completed: { () -> Void in
            
            self.setValue(false, forKey: "isLoading")
        })
        
        // 激活后开始查询
        didBecomeActiveSignal.subscribeNext { (any:AnyObject!) -> Void in
            
            searchFullsizedURLCommand.execute(nil)
        }
    }
}
