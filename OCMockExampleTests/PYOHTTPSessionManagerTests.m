//
//  PYOHTTPSessionManagerTests.m
//  OCMockExample
//
//  Created by Paul Young on 1/19/14.
//  Copyright (c) 2014 Paul Young. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>

#import "PYOHTTPSessionManager.h"

@interface PYOHTTPSessionManagerTests : XCTestCase

@end

@implementation PYOHTTPSessionManagerTests

- (void)setUp
{
    [super setUp];
    // Put setup code here; it will be run once, before the first test case.
}

- (void)tearDown
{
    // Put teardown code here; it will be run once, after the last test case.
    [super tearDown];
}

//- (void)testWithBlockVariables
//{
//    id sessionManagerPartialMock = [OCMockObject partialMockForObject:[PYOHTTPSessionManager manager]];
//    
//    NSString *URLString = @"test";
//    NSDictionary *parameters = nil;
//    
//    void (^block)(id, NSError *) = ^(id responseObject, NSError *error) {};
//    
//    void (^successBlock)(NSURLSessionDataTask *, id) = ^(NSURLSessionDataTask * __unused task, id responseObject) {
//        block(responseObject, nil);
//    };
//    
//    void (^failureBlock)(NSURLSessionDataTask *, NSError *) = ^(NSURLSessionDataTask * __unused task, NSError *error) {
//        block(nil, error);
//    };
//    
//    [[sessionManagerPartialMock expect] GET:URLString parameters:parameters success:successBlock failure:failureBlock];
//    
//    [sessionManagerPartialMock GET:URLString parameters:parameters block:block];
//    
//    [sessionManagerPartialMock verify];
//    [sessionManagerPartialMock stopMocking];
//}
//
//- (void)testWithOCArgIsNotNil
//{
//    id sessionManagerPartialMock = [OCMockObject partialMockForObject:[PYOHTTPSessionManager manager]];
//    
//    NSString *URLString = @"test";
//    NSDictionary *parameters = nil;
//    
//    void (^block)(id, NSError *) = ^(id responseObject, NSError *error) {};
//    
//    [[sessionManagerPartialMock expect] GET:URLString parameters:parameters success:[OCMArg isNotNil] failure:[OCMArg isNotNil]];
//    
//    [sessionManagerPartialMock GET:URLString parameters:parameters block:block];
//    
//    [sessionManagerPartialMock verify];
//    [sessionManagerPartialMock stopMocking];
//}

- (void)testSuccessWithBlockStub
{
    id sessionManagerPartialMock = [OCMockObject partialMockForObject:[PYOHTTPSessionManager manager]];
    
    NSString *URLString = @"test";
    NSDictionary *parameters = nil;
    
    NSString *responseStub = @"success";
    __block BOOL blockCalled = NO;
    
    void (^block)(id, NSError *) = ^(id responseObject, NSError *error) {
        XCTAssertNil(error, @"");
        XCTAssertEqualObjects(responseObject, responseStub, @"");
        blockCalled = YES;
    };
    
    [[[sessionManagerPartialMock expect] andDo:^(NSInvocation *invocation) {
        void (^successBlock)(NSURLSessionDataTask *, id);
        [invocation getArgument:&successBlock atIndex:4];
        successBlock(nil, responseStub);
    }] GET:URLString parameters:parameters success:[OCMArg isNotNil] failure:[OCMArg isNotNil]];
    
    [sessionManagerPartialMock GET:URLString parameters:parameters block:block];
    
    [sessionManagerPartialMock verify];
    [sessionManagerPartialMock stopMocking];
    
    XCTAssert(blockCalled, @"");
}

- (void)testFailureWithBlockStub
{
    id sessionManagerPartialMock = [OCMockObject partialMockForObject:[PYOHTTPSessionManager manager]];
    
    NSString *URLString = @"test";
    NSDictionary *parameters = nil;
    
    id errorMock = [OCMockObject mockForClass:[NSError class]];
    __block BOOL blockCalled = NO;
    
    void (^block)(id, NSError *) = ^(id responseObject, NSError *error) {
        XCTAssertNil(responseObject, @"");
        XCTAssertEqualObjects(error, errorMock, @"");
        blockCalled = YES;
    };
    
    [[[sessionManagerPartialMock expect] andDo:^(NSInvocation *invocation) {
        void (^failureBlock)(NSURLSessionDataTask *, NSError *);
        [invocation getArgument:&failureBlock atIndex:5];
        failureBlock(nil, errorMock);
    }] GET:URLString parameters:parameters success:[OCMArg isNotNil] failure:[OCMArg isNotNil]];
    
    [sessionManagerPartialMock GET:URLString parameters:parameters block:block];
    
    [sessionManagerPartialMock verify];
    [sessionManagerPartialMock stopMocking];
    
    XCTAssert(blockCalled, @"");
}

@end












































