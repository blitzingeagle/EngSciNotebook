//
//  MasterViewController.h
//  MAT292
//
//  Created by Morris Chen on 2017-09-07.
//  Copyright © 2017 Morris Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DetailViewController;

@interface MasterViewController : UITableViewController

@property (strong, nonatomic) NSDictionary *document;
@property (strong, nonatomic) DetailViewController *detailViewController;

@end

