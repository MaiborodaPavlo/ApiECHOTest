//
//  SignUpViewController.m
//  ApiECHOTest
//
//  Created by Pavel on 05.03.2018.
//  Copyright © 2018 Pavel Maiboroda. All rights reserved.
//

#import "SignUpViewController.h"
#import "PMSignUp.h"

#import "ServerManager.h"

@interface SignUpViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;

@end

@implementation SignUpViewController

- (void) viewDidLoad {
    
    [super viewDidLoad];
    
    [self.nameTextField becomeFirstResponder];
}

- (IBAction)signUpAction:(UIButton *)sender {
    
    [self.spinner startAnimating];
    
    PMSignUp *signUp = [[PMSignUp alloc] init];
    signUp.name = self.nameTextField.text;
    signUp.email = self.emailTextField.text;
    signUp.password = self.passwordTextField.text;
    
    [[ServerManager sharedManager] signUp: signUp
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
