//
//  BNLocationTableViewController.h
//  Weather Demo
//
//  Created by bnicholas on 5/8/14.
//  Copyright (c) 2014 Brand Networks. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BNLocationTableViewController : UITableViewController

@property (nonatomic, strong) NSArray *locations;

- (IBAction)locationAdded:(UIStoryboardSegue *)segue;

@end
