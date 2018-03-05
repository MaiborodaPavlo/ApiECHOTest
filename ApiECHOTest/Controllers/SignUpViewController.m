//
//  SignUpViewController.m
//  ApiECHOTest
//
//  Created by Pavel on 05.03.2018.
//  Copyright © 2018 Pavel Maiboroda. All rights reserved.
//

#import "SignUpViewController.h"
#import "ViewController.h"
#import "PMSignUp.h"

@interface SignUpViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@end

@implementation SignUpViewController

- (void) viewDidLoad {
    
    [super viewDidLoad];
    
    [self.nameTextField becomeFirstResponder];
}

#pragma mark - Navigation

 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 
     if ([segue.identifier isEqualToString: @"signUp"]) {
         if ([segue.destinationViewController isKindOfClass: [ViewController class]]) {
         
             PMSignUp *signUp = [[PMSignUp alloc] init];
             signUp.email = self.emailTextField.text;
             signUp.password = self.passwordTextField.text;
             signUp.name = self.nameTextField.text;
             
             ViewController *vc = (ViewController *) segue.destinationViewController;
             vc.signUp = signUp;
         }
     }
 }

#pragma mark - UITextFieldDelegate

- (void) textFieldDidEndEditing:(UITextField *)textField {
    
    [textField resignFirstResponder];
}

@end
