//
//  ServerManager.m
//  ApiECHOTest
//
//  Created by Pavel on 05.03.2018.
//  Copyright © 2018 Pavel Maiboroda. All rights reserved.
//

#import "ServerManager.h"
#import "AFNetworking.h"

#import "UNIRest.h"

#import "PMSignUp.h"
#import "PMLogin.h"

#define API_URL @"https://apiecho.cf"

@implementation ServerManager

+ (instancetype) sharedManager {
    
    static ServerManager *manager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[ServerManager alloc] init];
    });
    
    return manager;
}

- (NSString *) login: (PMLogin *) login {
    
    NSString *token = nil;
    
//    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
//    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
//
//
//    NSString *urlString = [API_URL stringByAppendingPathComponent: @"/api/login/"];
//    NSDictionary *parameters = @{@"email": login.email,
//                                 @"password": login.password};
//
//    NSMutableURLRequest *request = [[AFJSONRequestSerializer serializer] requestWithMethod: @"POST"
//                                                                          URLString: urlString
//                                                                         parameters: parameters
//                                                                              error: nil];
//
//    NSLog(@"%@", request.HTTPMethod);
//
//    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest: request
//                                                   uploadProgress: nil
//                                                 downloadProgress: nil
//                                                completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
//
//                                                    if (error) {
//                                                        NSLog(@"Error: %@", error);
//                                                    } else {
//                                                        NSLog(@"%@ %@", response, responseObject);
//                                                    }
//                                                }];
//
//    [dataTask resume];

    NSString *urlString = [API_URL stringByAppendingPathComponent: @"/api/login/"];
    NSDictionary* headers = @{@"accept": @"application/json"};
    NSDictionary *parameters = @{@"email": login.email,
                              @"password": login.password};
    
    UNIHTTPJsonResponse *response = [[UNIRest postEntity:^(UNIBodyRequest *request) {
        [request setUrl: urlString];
        [request setHeaders:headers];
        [request setBody:[NSJSONSerialization dataWithJSONObject:parameters options:0 error:nil]];
    }] asJson];
    
    NSLog(@"%@", response);
    
    return token;
}

- (NSString *) signUp: (PMSignUp *) signUp {
    
    NSString *token = nil;
        
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    NSString *urlString = [API_URL stringByAppendingPathComponent: @"/api/signup/"];

    NSDictionary *parameters = @{@"name": signUp.name,
                                 @"email": signUp.email,
                                 @"password": signUp.password};


    NSMutableURLRequest *request = [[AFJSONRequestSerializer serializer] requestWithMethod: @"POST"
                                                                          URLString: urlString
                                                                         parameters: parameters
                                                                              error: nil];
    
    NSLog(@"%@", request.HTTPMethod);
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest: request
                                                   uploadProgress: nil
                                                 downloadProgress: nil
                                                completionHandler: ^(NSURLResponse *response, id responseObject, NSError *error) {
                                                    if (error) {
                                                        NSLog(@"Error: %@", error);
                                                    } else {
                                                        NSLog(@"%@ %@", response, responseObject);
                                                    }
                                                }];

    [dataTask resume];
    
    return token;
}

@end
