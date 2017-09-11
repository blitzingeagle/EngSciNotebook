//
//  MenuViewController.h
//  EngSciNotebook
//
//  Created by Morris Chen on 2017-09-10.
//  Copyright © 2017 Morris Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MenuSelectionDelegate <NSObject>

- (void) courseMenuSelected:(NSString*)code;

@end


@interface MenuViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate>

@property (weak, nonatomic) id<MenuSelectionDelegate> delegate;
@property (weak, nonatomic) IBOutlet UICollectionView *courseCollection;

@end


