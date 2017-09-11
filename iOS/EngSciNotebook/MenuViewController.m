//
//  MenuViewController.m
//  EngSciNotebook
//
//  Created by Morris Chen on 2017-09-10.
//  Copyright © 2017 Morris Chen. All rights reserved.
//

#import "MenuViewController.h"
#import "EngSciNotebook-Swift.h"

@interface MenuViewController ()

@property (strong, nonatomic) GridLayout *gridLayout;
@property (strong, nonatomic) NSArray *courseCodes;

@end

@implementation MenuViewController

- (void) viewDidLoad {
    [super viewDidLoad];
    
    self.courseCodes = @[@"MAT292", @"AER210", @"ESC203", @"PHY293", @"ECE253", @"CHE260"];
    
    self.gridLayout = [[GridLayout alloc] initWithNumberOfColumns:2];
    self.courseCollection.collectionViewLayout = self.gridLayout;
    [self.courseCollection reloadData];
}


#pragma mark - UICollectionView
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.courseCodes.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CourseCell *cell = (CourseCell*) [collectionView dequeueReusableCellWithReuseIdentifier:@"courseCell" forIndexPath:indexPath];
    
    cell.imageView.image = [UIImage imageNamed:@"EngSciNotebook.png"];
    cell.courseCode.text = self.courseCodes[indexPath.item];
    
    return cell;
}

- (void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if(self.delegate && [self.delegate respondsToSelector:@selector(courseMenuSelected:)])
        [self.delegate courseMenuSelected:self.courseCodes[indexPath.item]];
}

@end
