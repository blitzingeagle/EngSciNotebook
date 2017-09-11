//
//  DetailViewController.h
//  MAT292
//
//  Created by Morris Chen on 2017-09-07.
//  Copyright © 2017 Morris Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) NSArray *contents;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@property (strong, nonatomic) IBOutlet UIScrollView *detailScrollView;
@property (weak, nonatomic) IBOutlet UIStackView *detailStackView;

@end

