//
//  HTTPClient.h
//  untitled
//
//  Created by Benjamin Yi on 10/28/16.
//  Copyright © 2016 team21. All rights reserved.
//

#import <AFNetworking/AFHTTPSessionManager.h>

@protocol  HTTPClientDelegate;

@interface HTTPClient : AFHTTPSessionManager
@property (nonatomic, weak) id<HTTPClientDelegate>delegate;

+ (HTTPClient *)sharedHTTPClient;
- (instancetype)initWithRoot:(NSURL *)root;

@end
