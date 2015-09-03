//
//  FRPPhotoModelDataSource.swift
//  FRP-Swift
//
//  Created by green on 15/9/3.
//  Copyright (c) 2015年 green. All rights reserved.
//

import ReactiveCocoa
import _500px_iOS_api
import AFNetworking

class FRPPhotoModelDataSource: FRPPhotoModelDataSourceProtocol {
    
    private lazy var apiHelper :PXAPIHelper = {
        
        let consumerKey = "DC2To2BS0ic1ChKDK15d44M42YHf9gbUJgdFoF0m"
        let consumerSecret = "i8WL4chWoZ4kw9fh3jzHK7XzTer1y5tUNvsTFNnB"
        PXRequest.setConsumerKey(consumerKey, consumerSecret: consumerSecret)
       
        let apiHelper = PXRequest.apiHelper()
        return apiHelper
    }()
    
    class func shareInstance()->FRPPhotoModelDataSourceProtocol{
        struct YRSingleton{
            static var predicate:dispatch_once_t = 0
            static var instance:FRPPhotoModelDataSource? = nil
        }
        dispatch_once(&YRSingleton.predicate,{
            YRSingleton.instance=FRPPhotoModelDataSource()
        })
        return YRSingleton.instance!
    }
    
    func searchFRPPhotoModelList() -> RACSignal {
        
        return RACSignal.createSignal({ (subscriber:RACSubscriber!) -> RACDisposable! in
            
            // 查询缩略图片列表请求
            let searchFRPPhotoModelListRequest = self.apiHelper.urlRequestForPhotoFeature( PXAPIHelperPhotoFeature.Popular, resultsPerPage: 100, page: 0, photoSizes: PXPhotoModelSize.Thumbnail, sortOrder: PXAPIHelperSortOrder.Rating, except: PXPhotoModelCategory.PXPhotoModelCategoryNude)
            
            // 使用AF获取数据
            let operation = AFHTTPRequestOperation(request: searchFRPPhotoModelListRequest)
            operation.setCompletionBlockWithSuccess({ (operation:AFHTTPRequestOperation!, any:AnyObject!) -> Void in
                
                let result: AnyObject? = NSJSONSerialization.JSONObjectWithData(any as! NSData, options: NSJSONReadingOptions(0), error:nil)
                
                subscriber.sendNext(result)
                subscriber.sendCompleted()
    
            }, failure: { (operation:AFHTTPRequestOperation!, error:NSError!) -> Void in
                
                subscriber.sendError(error)
            })
            let queue = NSOperationQueue()
            queue.addOperation(operation)
            
            return nil
        }).map({ (any:AnyObject!) -> AnyObject! in
            
            var result = [FRPPhotoModel]()
            
            result <-- any["photos"]
            
            for m in result {
                
                self.searchFullsizedURL(m.identifier!).subscribeNextAs{(thumbnailURL:String) in
                    
                    m.thumbnailURL = thumbnailURL
                }
            }
            
            return result
        })
    }
    
    func searchFullsizedURL(identifier: NSNumber) -> RACSignal {
        
        return RACSignal.createSignal({ (subscriber:RACSubscriber!) -> RACDisposable! in
            
            // 查询大图请求
            let searchFullsizedURLRequest = self.apiHelper.urlRequestForPhotoID(identifier.integerValue)
            
            // 使用AF获取数据
            let operation = AFHTTPRequestOperation(request: searchFullsizedURLRequest)
            operation.setCompletionBlockWithSuccess({ (operation:AFHTTPRequestOperation!, any:AnyObject!) -> Void in
                
                let result: AnyObject? = NSJSONSerialization.JSONObjectWithData(any as! NSData, options: NSJSONReadingOptions(0), error:nil)!["photo"]
                
                subscriber.sendNext(result)
                subscriber.sendCompleted()
                
            }, failure: { (operation:AFHTTPRequestOperation!, error:NSError!) -> Void in
                
                subscriber.sendError(error)
            })
            let queue = NSOperationQueue()
            queue.addOperation(operation)
            
            return nil
        }).map({ (any:AnyObject!) -> AnyObject! in
            
            return (any["images"] as? NSArray)?.rac_sequence.filter({ (any:AnyObject!) -> Bool in
                
                return (any["size"] as? Int) == 3
            }).map({ (any:AnyObject!) -> AnyObject! in
                
                return any["url"]
            }).array.first
        })
    }
}
