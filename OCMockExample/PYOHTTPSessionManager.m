//
//  PYOHTTPSessionManager.m
//  OCMockExample
//
//  Created by Paul Young on 1/19/14.
//  Copyright (c) 2014 Paul Young. All rights reserved.
//

#import "PYOHTTPSessionManager.h"

@implementation PYOHTTPSessionManager

+ (instancetype)manager {
    return [[[self class] alloc] init];
}

- (NSURLSessionDataTask *)GET:(NSString *)URLString
                   parameters:(NSDictionary *)parameters
                        block:(void (^)(id responseObject, NSError *error))block
{
    return [self GET:URLString parameters:parameters success:^(NSURLSessionDataTask * __unused task, id responseObject) {
        block(responseObject, nil);
    } failure:^(NSURLSessionDataTask * __unused task, NSError *error) {
        block(nil, error);
    }];
}

- (NSURLSessionDataTask *)GET:(NSString *)URLString
                   parameters:(NSDictionary *)parameters
                      success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                      failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    return [[NSURLSessionDataTask alloc] init];
}

@end
