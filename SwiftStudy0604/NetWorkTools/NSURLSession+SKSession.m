//
//  NSURLSession+SKSession.m
//  MKMJPlatform
//
//  Created by wanglishuai on 2019/7/8.
//  Copyright © 2019 乔进升. All rights reserved.
//

#import "NSURLSession+SKSession.h"
#import <objc/runtime.h>

void swizzing(Class class, SEL originalSelector, SEL swizzledSelector)
{
    Method originalMethod = class_getClassMethod(class, originalSelector);
    Method swizzledMethod = class_getClassMethod(class, swizzledSelector);
    method_exchangeImplementations(originalMethod, swizzledMethod);
}

@implementation NSURLSession (SKSession)

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [NSURLSession class];
        swizzing(class, @selector(sessionWithConfiguration:), @selector(qy_sessionWithConfiguration:));
        
        swizzing(class, @selector(sessionWithConfiguration:delegate:delegateQueue:),
                 @selector(qy_sessionWithConfiguration:delegate:delegateQueue:));
    });
}
    
+ (NSURLSession *)qy_sessionWithConfiguration:(NSURLSessionConfiguration *)configuration
                                     delegate:(nullable id<NSURLSessionDelegate>)delegate
                                delegateQueue:(nullable NSOperationQueue *)queue
{
    if (!configuration)
    {
        configuration = [[NSURLSessionConfiguration alloc] init];
    }
    configuration.connectionProxyDictionary = @{};
    return [self qy_sessionWithConfiguration:configuration delegate:delegate delegateQueue:queue];
}
    
+ (NSURLSession *)qy_sessionWithConfiguration:(NSURLSessionConfiguration *)configuration
{
    if (configuration)
    {
        configuration.connectionProxyDictionary = @{};
    }
    return [self qy_sessionWithConfiguration:configuration];
}

@end
