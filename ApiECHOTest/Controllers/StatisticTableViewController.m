//
//  StatisticTableViewController.m
//  ApiECHOTest
//
//  Created by Pavel on 06.03.2018.
//  Copyright © 2018 Pavel Maiboroda. All rights reserved.
//

#import "StatisticTableViewController.h"

@interface StatisticTableViewController ()

@property (strong, nonatomic) NSDictionary *symbols;

@end

@implementation StatisticTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self countSymbols];
}

- (void) countSymbols {
    
    NSMutableDictionary *symbols = [NSMutableDictionary dictionary];
    
    NSMutableArray *symbolsArray = [NSMutableArray array];
    [self.text enumerateSubstringsInRange:NSMakeRange(0, [self.text length])
                                options:(NSStringEnumerationByComposedCharacterSequences)
                             usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                                 [symbolsArray addObject:substring];
                             }];
    
    
    
    [symbolsArray sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [obj1 compare: obj2 options:NSCaseInsensitiveSearch];
    }];
    
    NSLog(@"%@", symbolsArray);
    
    for (NSString *symbol in symbolsArray) {
        
        static int i = 0;
        
        if (![symbols objectForKey: symbol]) {
            i = 1;
            [symbols setObject: @(i) forKey: symbol];
        } else {
            i++;
            [symbols removeObjectForKey: symbol];
            [symbols setObject: @(i) forKey: symbol];
        }
    }
    
    self.symbols = symbols;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [[self.symbols allKeys] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"Symbol Cell" forIndexPath: indexPath];
    
    NSArray *sortedKeys = [[self.symbols allKeys] sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [obj1 compare: obj2 options:NSCaseInsensitiveSearch];
    }];
    
    NSString *key = [sortedKeys objectAtIndex: indexPath.row];
    
    cell.textLabel.text = key;
    cell.detailTextLabel.text = [NSString stringWithFormat: @"%@", [self.symbols objectForKey: key]];
    
    return cell;
}

@end
