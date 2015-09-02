//
//  CarthageTestTests.swift
//  CarthageTestTests
//
//  Created by green on 15/9/2.
//  Copyright (c) 2015年 RACTest. All rights reserved.
//

import UIKit
import XCTest
import ReactiveCocoa

class CarthageTestTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    /** 
     * 模拟取消登录
     */
    func testCancelLoginWithTakeUntil() {
        
        var isLogined = false
        
        // 取消登录命令
        let cancelLoginCommand = RACCommand { (any:AnyObject!) -> RACSignal! in
            
            let signal = RACSignal.createSignal({ (subscriber:RACSubscriber!) -> RACDisposable! in
                
                subscriber.sendNext("取消登录")
                
                return nil
            })
            
            signal.subscribeNext({ (any:AnyObject!) -> Void in
                
                isLogined = false
            })
            return signal
        }
        
        cancelLoginCommand.execute(nil)
        
        // 登录命令
        let loginCommand = RACCommand { (any:AnyObject!) -> RACSignal! in
            
            let signal =  RACSignal.createSignal({ (subscriber:RACSubscriber!) -> RACDisposable! in
                
                while(!isLogined) {
                    
                    subscriber.sendNext("登录成功")
                }
                
                return nil
            }).takeUntil(cancelLoginCommand.executionSignals)
            
            signal.subscribeNext({ (any:AnyObject!) -> Void in
                
                isLogined = true
            })

            return signal
        }
        
        loginCommand.execute(nil)
        cancelLoginCommand.execute(nil)
        XCTAssert(isLogined, "登录成功")
        
        
//        var shouldBeGettingItems = true
//        
//        let subject = RACSubject()
//        let cutOffSubject = RACSubject()
//        
//        subject
//            .takeUntil(cutOffSubject)
//            .subscribeNext { (any:AnyObject!) -> Void in
//            
//                println(any)
//            XCTAssert(shouldBeGettingItems, "should support value as trigger")
//        }
//        
//        shouldBeGettingItems = true
//        subject.sendNext("test 1")
//        subject.sendNext("test 2")
//        
////        cutOffSubject.sendNext(RACUnit.defaultUnit())
////        cutOffSubject.sendCompleted()
//        
//        shouldBeGettingItems = false
//        subject.sendNext("test 3")
        
    }
    
}
