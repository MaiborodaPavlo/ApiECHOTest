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

- (NSString *) login: (PMLogin *) login;
- (NSString *) signUp: (PMSignUp *) signUp;

//- (void) textForLocale;

@end
