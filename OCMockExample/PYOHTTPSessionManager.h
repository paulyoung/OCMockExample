//
//  PYOHTTPSessionManager.h
//  OCMockExample
//
//  Created by Paul Young on 1/19/14.
//  Copyright (c) 2014 Paul Young. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PYOHTTPSessionManager : NSObject

+ (instancetype)manager;

- (NSURLSessionDataTask *)GET:(NSString *)URLString
                   parameters:(NSDictionary *)parameters
                        block:(void (^)(id responseObject, NSError *error))block;

- (NSURLSessionDataTask *)GET:(NSString *)URLString
                   parameters:(NSDictionary *)parameters
                      success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                      failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;
@end
