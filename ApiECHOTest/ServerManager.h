//
//  ServerManager.h
//  ApiECHOTest
//
//  Created by Pavel on 05.03.2018.
//  Copyright © 2018 Pavel Maiboroda. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PMLogin, PMSignUp;

@interface ServerManager : NSObject

+ (instancetype) sharedManager;
+ (NSString *) randomLocale;

- (void) login: (PMLogin *) login
     onSuccess: (void(^)(void)) success
     onFailure: (void(^)(NSError* error)) failure;

- (void) signUp: (PMSignUp *) signUp
      onSuccess: (void(^)(void)) success
      onFailure: (void(^)(NSError* error)) failure;

- (void) textForLocale: (NSString *) locale
             onSuccess: (void(^)(NSString *text)) success
             onFailure: (void(^)(NSError* error)) failure;

@end
