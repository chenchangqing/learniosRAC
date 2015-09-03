//
//  FRPFullSizePhotoViewModel.swift
//  FRP-Swift
//
//  Created by green on 15/9/4.
//  Copyright (c) 2015年 green. All rights reserved.
//

import ReactiveViewModel

class FRPFullSizePhotoViewModel: RVMViewModel {
   
    var photoModelList: [FRPPhotoModel]!
    var photoIndex: Int! 
    
    init(photoModelList:[FRPPhotoModel],photoIndex:Int) {
        
        super.init(model: nil)
        
        self.photoModelList = photoModelList
        self.photoIndex = photoIndex
    }
    
    /**
     * 指定位置图片Model
     */
    var photoModel: FRPPhotoModel! {
        
        get {
            
            return photoModelList[photoIndex]
        }
    }
    
}
