//
//  ServerManager.m
//  ApiECHOTest
//
//  Created by Pavel on 05.03.2018.
//  Copyright © 2018 Pavel Maiboroda. All rights reserved.
//

#import "ServerManager.h"
#import "AFNetworking.h"

#import "PMSignUp.h"
#import "PMLogin.h"

#define API_URL @"http://apiecho.cf"

@interface ServerManager ()

@property (strong, nonatomic) NSString *accessToken;

@end

@implementation ServerManager

+ (instancetype) sharedManager {
    
    static ServerManager *manager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[ServerManager alloc] init];
    });
    
    return manager;
}

+ (NSString *) randomLocale {
    
    static NSString *validLocale[] = {@"bg_BG", @"da_DK", @"el_GR", @"en_NG", @"en_ZA", @"fi_FI", @"he_IL", @"ka_GE", @"me_ME", @"nl_NL", @"pt_PT", @"sr_Cyrl_RS", @"tr_TR", @"zh_TW", @"ar_JO", @"en_AU", @"en_NZ", @"es_AR", @"hr_HR", @"kk_KZ", @"ro_MD", @"sr_Latn_RS", @"uk_UA", @"ar_SA", @"bn_BD", @"de_AT", @"en_CA", @"en_PH", @"es_ES", @"fr_BE", @"is_IS", @"ko_KR", @"mn_MN", @"ro_RO", @"sr_RS", @"at_AT", @"de_CH", @"en_GB", @"en_SG", @"es_PE", @"fr_CA", @"hu_HU", @"it_CH", @"nb_NO", @"ru_RU", @"sv_SE", @"de_DE", @"en_HK", @"en_UG", @"es_VE", @"fr_CH", @"hy_AM", @"it_IT", @"lt_LT", @"ne_NP", @"pl_PL", @"sk_SK", @"vi_VN", @"cs_CZ", @"el_CY", @"en_IN", @"en_US", @"fa_IR", @"fr_FR", @"id_ID", @"ja_JP", @"lv_LV", @"nl_BE", @"pt_BR", @"sl_SI", @"th_TH", @"zh_CN"};
    
    static const int localeCount = 72;
    
    return validLocale[arc4random() % localeCount];
}

- (void) login: (PMLogin *) login
     onSuccess: (void(^)(void)) success
     onFailure: (void(^)(NSError* error)) failure {

    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];


    NSString *urlString = [API_URL stringByAppendingPathComponent: @"/api/login/"];
    urlString = [urlString stringByAppendingString:@"/"];

    NSDictionary *parameters = @{@"email": login.email,
                                 @"password": login.password};

    NSMutableURLRequest *request = [[AFJSONRequestSerializer serializer] requestWithMethod: @"POST"
                                                                          URLString: urlString
                                                                         parameters: parameters
                                                                              error: nil];

    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest: request
                                                   uploadProgress: nil
                                                 downloadProgress: nil
                                                completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {

                                                    if (error) {
                                                        if (failure) {
                                                            failure(error);
                                                        }
                                                    } else {
                                                        if (responseObject) {
                                                            self.accessToken = [responseObject valueForKeyPath: @"data.access_token"];
                                                            if (success) {
                                                                success();
                                                            }
                                                        }
                                                    }
                                                }];

    [dataTask resume];
}

- (void) signUp: (PMSignUp *) signUp
      onSuccess: (void(^)(void)) success
      onFailure: (void(^)(NSError* error)) failure {

    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    NSString *urlString = [API_URL stringByAppendingPathComponent: @"/api/signup/"];
    urlString = [urlString stringByAppendingString:@"/"];
    

    NSDictionary *parameters = @{@"name": signUp.name,
                                 @"email": signUp.email,
                                 @"password": signUp.password};


    NSMutableURLRequest *request = [[AFJSONRequestSerializer serializer] requestWithMethod: @"POST"
                                                                          URLString: urlString
                                                                         parameters: parameters
                                                                              error: nil];
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest: request
                                                   uploadProgress: nil
                                                 downloadProgress: nil
                                                completionHandler: ^(NSURLResponse *response, id responseObject, NSError *error) {
                                                    if (error) {
                                                        if (failure) {
                                                            failure(error);
                                                        }
                                                    } else {
                                                        if (responseObject) {
                                                            self.accessToken = [responseObject valueForKeyPath: @"data.access_token"];
                                                            if (success) {
                                                                success();
                                                            }
                                                        }                                                   }
                                                }];

    [dataTask resume];
}

- (void) textForLocale: (NSString *) locale
             onSuccess: (void(^)(NSString *text)) success
             onFailure: (void(^)(NSError* error)) failure {

    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    NSString *urlString = [API_URL stringByAppendingPathComponent: @"/api/get/text/"];
    urlString = [urlString stringByAppendingString:@"/"];
    
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] requestWithMethod: @"GET"
                                                                                 URLString: urlString
                                                                                parameters: nil
                                                                                     error: nil];
    
    [request addValue: [NSString stringWithFormat: @"Bearer %@", self.accessToken]  forHTTPHeaderField: @"Authorization"];
    [request addValue: locale  forHTTPHeaderField: @"Locale"];
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest: request
                                                   uploadProgress: nil
                                                 downloadProgress: nil
                                                completionHandler: ^(NSURLResponse *response, id responseObject, NSError *error) {
                                                    if (error) {
                                                        if (failure) {
                                                            failure(error);
                                                        }
                                                    } else {
                                                        if (responseObject) {
                                                            if (success) {
                                                                success([responseObject valueForKeyPath: @"data"]);
                                                            }
                                                        }
                                                    }
                                                }];
    
    [dataTask resume];
}

@end
