//
//  RACTestTests.swift
//  RACTestTests
//
//  Created by green on 15/9/2.
//  Copyright (c) 2015年 RACTest. All rights reserved.
//

import UIKit
import XCTest

class RACTestTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        XCTAssert(true, "Pass")
    }
    
    func testTakeUtil() {
        
//        __block BOOL shouldBeGettingItems = YES;
//        RACSubject *subject = [RACSubject subject];
//        RACSubject *cutOffSubject = [RACSubject subject];
//        [[subject takeUntil:cutOffSubject] subscribeNext:^(id x) {
//            expect(shouldBeGettingItems).to.beTruthy();
//            }];
//        
//        shouldBeGettingItems = YES;
//        [subject sendNext:@"test 1"];
//        [subject sendNext:@"test 2"];
//        
//        [cutOffSubject sendNext:[RACUnit defaultUnit]];
//        
//        shouldBeGettingItems = NO;
//        [subject sendNext:@"test 3"];
        
        var shouldBeGettingItems = true
    }
    
}
