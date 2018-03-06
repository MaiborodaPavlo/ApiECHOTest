//
//  TextTableViewController.m
//  ApiECHOTest
//
//  Created by Pavel on 06.03.2018.
//  Copyright © 2018 Pavel Maiboroda. All rights reserved.
//

#import "TextViewController.h"
#import "StatisticTableViewController.h"

#import "ServerManager.h"

@interface TextViewController ()

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation TextViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadText];
}

- (void) loadText {
    
    [self.spinner startAnimating];
    
    [[ServerManager sharedManager] textForLocale: [ServerManager randomLocale]
                                       onSuccess:^(NSString *text) {
                                           self.textView.text = text;
                                           [self.spinner stopAnimating];
                                       }
                                       onFailure:^(NSError *error) {
                                           NSLog(@"ERROR: %@", [error localizedDescription]);
                                       }];
}

#pragma mark - Actions

- (IBAction)newTextAction:(UIBarButtonItem *)sender {
    
    [self loadText];
}

#pragma mark - Segues

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.destinationViewController isKindOfClass:[StatisticTableViewController class]]) {

        StatisticTableViewController *vc = (StatisticTableViewController *)segue.destinationViewController;
        
        vc.text = self.textView.text;
    }
}

@end
