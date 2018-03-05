//
//  LoginViewController.m
//  ApiECHOTest
//
//  Created by Pavel on 05.03.2018.
//  Copyright © 2018 Pavel Maiboroda. All rights reserved.
//

#import "LoginViewController.h"
#import "ViewController.h"
#import "PMLogin.h"

@interface LoginViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@end

@implementation LoginViewController

- (void) viewDidLoad {
    
    [super viewDidLoad];
    
    [self.emailTextField becomeFirstResponder];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString: @"login"]) {
        if ([segue.destinationViewController isKindOfClass: [ViewController class]]) {
            
            PMLogin *login = [[PMLogin alloc] init];
            login.email = self.emailTextField.text;
            login.password = self.passwordTextField.text;
            
            ViewController *vc = (ViewController *) segue.destinationViewController;
            vc.login = login;
        }
    }
}

#pragma mark - UITextFieldDelegate

- (void) textFieldDidEndEditing:(UITextField *)textField {
    
    [textField resignFirstResponder];
}


@end
