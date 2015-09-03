//
//  FRPGalleryViewModel.swift
//  FRP-Swift
//
//  Created by green on 15/9/3.
//  Copyright (c) 2015年 green. All rights reserved.
//

import Foundation
import ReactiveViewModel
import ReactiveCocoa

class FRPGalleryViewModel: RVMViewModel {
    
    let photoModelDataSourceProtocol = FRPPhotoModelDataSource.shareInstance()
    
    var searchFRPPhotoModelListCommand:RACCommand!
    
    var errorMsg : String = ""
    
    override init() {
        
        super.init(model: [FRPPhotoModel]())
        
        // 初始化查询命令
        searchFRPPhotoModelListCommand = RACCommand(signalBlock: { (any:AnyObject!) -> RACSignal! in
            return self.photoModelDataSourceProtocol.searchFRPPhotoModelList()
        })
        
        // 错误处理
        searchFRPPhotoModelListCommand.errors.subscribeNextAs { (error:NSError!) -> () in
            
            self.setValue(error.localizedDescription, forKey: "errorMsg")
        }
        
        // 更新model
        searchFRPPhotoModelListCommand.executionSignals.switchToLatest().subscribeNextAs { (photoModelList:[FRPPhotoModel]) -> () in
            
            self.setValue(photoModelList, forKey: "model")
        }
        
        // 激活后开始查询
        didBecomeActiveSignal.subscribeNext { (any:AnyObject!) -> Void in
            
            searchFRPPhotoModelListCommand.execute(nil)
        }
    }
    
    
}