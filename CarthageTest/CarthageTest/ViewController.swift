//
//  ViewController.swift
//  CarthageTest
//
//  Created by green on 15/9/2.
//  Copyright (c) 2015年 RACTest. All rights reserved.
//

import UIKit
import ReactiveCocoa

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        testCancelLoginWithTakeUntil(isCancel:false)
        testCancelLoginWithTakeUntilBlock(isCancel: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /**
     * 模拟取消登录
     */
    func testCancelLoginWithTakeUntil(#isCancel:Bool) {
        
        var isLogined = false
        
        // 取消登录命令
        let cancelLoginCommand = RACCommand { (any:AnyObject!) -> RACSignal! in
            
            let signal = RACSignal.createSignal({ (subscriber:RACSubscriber!) -> RACDisposable! in
                
                subscriber.sendNext(nil)
                
                return nil
            })
            return signal
        }
        
        // 登录命令
        let loginCommand = RACCommand { (any:AnyObject!) -> RACSignal! in
            
            let signal =  RACSignal.createSignal({ (subscriber:RACSubscriber!) -> RACDisposable! in
                
                let duration:UInt64 = isCancel ? 4 : 2
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (Int64)(NSEC_PER_SEC * duration)), dispatch_get_main_queue()) { () -> Void in
                    
                    subscriber.sendNext(nil)
                }
                
                return nil
            }).takeUntil(cancelLoginCommand.executionSignals)
            
            signal.subscribeNext({ (any:AnyObject!) -> Void in
                
                isLogined = true
            })
            
            signal.subscribeCompleted({ () -> Void in
                
                if isLogined {
                    
                    println("登录成功")
                } else {
                    
                    println("取消登录")
                }
            })
            
            return signal
        }
        
        loginCommand.execute(nil)
    }
    
    /**
    * 模拟取消登录
    */
    func testCancelLoginWithTakeUntilBlock(#isCancel:Bool) {
        
        var isLogined = false
        
        // 登录命令
        let loginCommand = RACCommand { (any:AnyObject!) -> RACSignal! in
            
            let signal =  RACSignal.createSignal({ (subscriber:RACSubscriber!) -> RACDisposable! in
                
                let duration:UInt64 = isCancel ? 4 : 2
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (Int64)(NSEC_PER_SEC * duration)), dispatch_get_main_queue()) { () -> Void in
                    
                    subscriber.sendNext("fsdf")
                    subscriber.sendCompleted()
                }
                
                return nil
            }).takeUntilBlock({ (any:AnyObject!) -> Bool in
                
                return true
            })
            
            signal.subscribeNext({ (any:AnyObject!) -> Void in
                
                isLogined = true
            })
            
            signal.subscribeCompleted({ () -> Void in
                
                if isLogined {
                    
                    println("登录成功")
                } else {
                    
                    println("取消登录")
                }
            })
            
            return signal
        }
        
        loginCommand.execute(nil)
    }

}

