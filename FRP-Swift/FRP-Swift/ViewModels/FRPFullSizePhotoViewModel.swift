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
            
            if photoIndex < 0 {
            
                return photoModelList[photoModelList.count - 1]
            } else if photoIndex >= photoModelList.count {
                
                return photoModelList[0]
            } else {
                
                return photoModelList[photoIndex]
            }
        }
    }
    
}
