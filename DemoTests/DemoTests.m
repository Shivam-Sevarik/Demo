//
//  DemoTests.m
//  DemoTests
//
//  Created by EcoMail on 17/03/16.
//  Copyright © 2016 6Degreesit. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "WritingTestsViewController.h"


@interface DemoTests : XCTestCase

@property(nonatomic) WritingTestsViewController *write;

@end

@interface WritingTestsViewController (Test)


@end

@implementation DemoTests

- (void)setUp {
    [super setUp];
    
    self.write = [[WritingTestsViewController alloc] init];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
