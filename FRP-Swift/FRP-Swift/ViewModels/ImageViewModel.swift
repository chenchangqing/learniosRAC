//
//  ImageViewModel.swift
//  travelMapMvvm
//
//  Created by green on 15/8/31.
//  Copyright (c) 2015年 travelMapMvvm. All rights reserved.
//

import ReactiveCocoa
import ReactiveViewModel

class ImageViewModel: RVMViewModel {
   
    var urlString : String?         // 图片路径
    {
        didSet {
            
            let result = isValidPic()
            
            self.setValue(result.url, forKey: "url")
            self.setValue(result.request, forKey: "request")
        }
    }
    var url  : NSURL?
    var request: NSURLRequest?
    
    // 被观察的图片，一旦变更及时更新视图
    dynamic var image:UIImage = UIImage()
    var isNeedCompress = true
    
    private var imageDataSourceProtocol = ImageDataSource.shareInstance()
    var downloadImageCommand : RACCommand!

    /**
     * 初始化 
     */
    init(urlString:String?,model:AnyObject? = nil,defaultImage:UIImage = UIImage(),isNeedCompress:Bool = true) {
        
        super.init(model: model)
        
        self.urlString  = urlString
        self.image      = defaultImage
        self.isNeedCompress = isNeedCompress
        
        // 初始化下载命令
        setupCommand()
        
    }
    
    // MARK: - COMMAND
    
    private func setupCommand() {
        
        // 是否可以执行下载图片的命令
        let commandEnabledSignal = RACObserve(self, "url").map { (any:AnyObject!) -> AnyObject! in
            
            if any != nil {
                return true
            } else {
                return false
            }
        }.distinctUntilChanged()
        
        // 初始化下载图片命令
        downloadImageCommand = RACCommand(enabled: commandEnabledSignal, signalBlock: { (any:AnyObject!) -> RACSignal! in
            
            if self.isCached() {
                
                return RACSignal.empty()
            }
            return self.imageDataSourceProtocol.downloadImageWithUrl(self.url!, isNeedCompress: self.isNeedCompress)
        })
        
        // 获得图片
        downloadImageCommand.executionSignals.switchToLatest().subscribeNextAs { (image:UIImage) -> () in
           
            self.setValue(image, forKey: "image")
        }
        
        // 下载图片错误处理
        downloadImageCommand.errors.subscribeNextAs { (error:NSError!) -> () in
            
            println(error.localizedDescription)
        }
    }
    
    /**
     * 图片是否有效
     */
    private func isValidPic() -> (url:NSURL?,request:NSURLRequest?) {
        
        if let picUrl=urlString {
            
            if let url=NSURL(string: picUrl) {
                
                return (url,NSURLRequest(URL: url))
            }
        }
        return (nil,nil)
    }
    
    // MARK: - load image
    
    /**
     * 是否已经缓存
     */
    private func isCached() -> Bool {
        
        if let request=request {
            
            if let image=UIImageView.sharedImageCache().cachedImageForRequest(request) {
                
                self.setValue(image, forKey: "image")
                return true
            }
        }
        return false
    }
}
