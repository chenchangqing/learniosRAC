//
//  FRPPhotoModel.swift
//  FRP-Swift
//
//  Created by green on 15/9/3.
//  Copyright (c) 2015年 green. All rights reserved.
//

import Foundation
import ReactiveCocoa

class FRPPhotoModel: NSObject,Deserializable {
    
    var photoName           : String?
    var identifier          : NSNumber?
    var photographerName    : String?
    var rating              : NSNumber?
    var thumbnailURL        : String?
    var fullsizedURL        : String?
    
    override init() { }
    
    required init(data : [String:AnyObject]) {
        
        photoName           <-- data["name"]
        identifier          <-- data["id"]
        photographerName    <-- data["user"]!["username"]
        rating              <-- data["rating"]
        thumbnailURL        <-- (data["images"] as? NSArray)?.rac_sequence.filter({ (any:AnyObject!) -> Bool in
            
            return (any["size"] as? Int) == 3
        }).map({ (any:AnyObject!) -> AnyObject! in
            
            return any["url"]
        }).array.first
        
        fullsizedURL        <-- data["fullsizedURL"]
    }
}