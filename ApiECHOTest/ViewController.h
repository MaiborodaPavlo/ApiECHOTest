//
//  ViewController.h
//  ApiECHOTest
//
//  Created by Pavel on 05.03.2018.
//  Copyright © 2018 Pavel Maiboroda. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PMLogin, PMSignUp;

@interface ViewController : UIViewController

// in
@property (strong, nonatomic) PMLogin *login;
@property (strong, nonatomic) PMSignUp *signUp;

@end

