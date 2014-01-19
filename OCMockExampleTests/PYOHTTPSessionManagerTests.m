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

- (void)testWithBlockVariables
{
    id sessionManagerPartialMock = [OCMockObject partialMockForObject:[PYOHTTPSessionManager manager]];
    
    NSString *URLstring = @"test";
    NSDictionary *parameters = nil;
    
    void (^block)(id, NSError *) = ^(id responseObject, NSError *error) {};
    
    void (^successBlock)(NSURLSessionDataTask *, id) = ^(NSURLSessionDataTask * __unused task, id responseObject) {
        block(responseObject, nil);
    };
    
    void (^failureBlock)(NSURLSessionDataTask *, NSError *) = ^(NSURLSessionDataTask * __unused task, NSError *error) {
        block(nil, error);
    };
    
    [[sessionManagerPartialMock expect] GET:URLstring parameters:parameters success:successBlock failure:failureBlock];
    
    [sessionManagerPartialMock GET:URLstring parameters:parameters block:block];
    
    [sessionManagerPartialMock verify];
    [sessionManagerPartialMock stopMocking];
}

- (void)testWithOCArgIsNotNil
{
    id sessionManagerPartialMock = [OCMockObject partialMockForObject:[PYOHTTPSessionManager manager]];
    
    NSString *URLstring = @"test";
    NSDictionary *parameters = nil;
    
    void (^block)(id, NSError *) = ^(id responseObject, NSError *error) {};
    
    [[sessionManagerPartialMock expect] GET:URLstring parameters:parameters success:[OCMArg isNotNil] failure:[OCMArg isNotNil]];
    
    [sessionManagerPartialMock GET:URLstring parameters:parameters block:block];
    
    [sessionManagerPartialMock verify];
    [sessionManagerPartialMock stopMocking];
}

@end
