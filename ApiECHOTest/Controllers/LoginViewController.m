//
//  LoginViewController.m
//  ApiECHOTest
//
//  Created by Pavel on 05.03.2018.
//  Copyright © 2018 Pavel Maiboroda. All rights reserved.
//

#import "LoginViewController.h"
#import "TextViewController.h"
#import "SignUpViewController.h"

#import "PMLogin.h"

#import "ServerManager.h"

@interface LoginViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;

@end

@implementation LoginViewController

- (void) viewDidLoad {
    
    [super viewDidLoad];
    
    [self.emailTextField becomeFirstResponder];
    
}

#pragma mark - Actions

- (IBAction)loginAction:(UIButton *)sender {
    
    [self.spinner startAnimating];
    
    PMLogin *login = [[PMLogin alloc] init];
    login.email = self.emailTextField.text;
    login.password = self.passwordTextField.text;
    
    [[ServerManager sharedManager] login: login
                               onSuccess:^{
        [self.spinner stopAnimating];
                                   
        UINavigationController *nav = [self.storyboard instantiateViewControllerWithIdentifier: @"NavigationController"];
        [self presentViewController: nav animated: YES completion: nil];
    }
                               onFailure:^(NSError *error) {
        [self.spinner stopAnimating];
        NSLog(@"ERROR: %@", [error localizedDescription]);
    }];
}

#pragma mark - UITextFieldDelegate

- (void) textFieldDidEndEditing:(UITextField *)textField {
    
    [textField resignFirstResponder];
}


@end
