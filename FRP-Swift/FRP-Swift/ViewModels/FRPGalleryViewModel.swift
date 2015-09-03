//
//  FRPGalleryViewModel.swift
//  FRP-Swift
//
//  Created by green on 15/9/3.
//  Copyright (c) 2015年 green. All rights reserved.
//

import Foundation
import ReactiveViewModel

class FRPGalleryViewModel: RVMViewModel {
    
    let photoModelDataSourceProtocol = FRPPhotoModelDataSource.shareInstance()
    
    init!(photoModelList: [FRPPhotoModel]) {
        
        super.init(model: photoModelList)
        
        // bind
        photoModelDataSourceProtocol.searchFRPPhotoModelList() ~> RAC(self,"model")
    }
    
    
}