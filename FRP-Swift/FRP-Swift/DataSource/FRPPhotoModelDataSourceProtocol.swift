//
//  FRPPhotoModelDataSourceProtocol.swift
//  FRP-Swift
//
//  Created by green on 15/9/3.
//  Copyright (c) 2015年 green. All rights reserved.
//

import Foundation
import ReactiveCocoa

protocol FRPPhotoModelDataSourceProtocol {
    
    /**
     * 查询图片列表
     */
    func searchFRPPhotoModelList() -> RACSignal
    
    /**
     * 查询图片大图URL
     */
    func searchFullsizedURL(identifier:NSNumber) -> RACSignal
}