//
//  MasterViewController.m
//  MAT292
//
//  Created by Morris Chen on 2017-09-07.
//  Copyright © 2017 Morris Chen. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"

@interface MasterViewController ()

@property NSMutableArray *sections;
@property NSMutableArray *objects;
@property NSMutableArray *items;

@end

@implementation MasterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(backSegue:)];
//    self.navigationItem.leftBarButtonItem = backButton;

    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(searchObject:)];
    self.navigationItem.rightBarButtonItem = addButton;
    
    self.detailViewController = (DetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
    
    [self loadData];
}


- (void)viewWillAppear:(BOOL)animated {
    self.clearsSelectionOnViewWillAppear = self.splitViewController.isCollapsed;
    [super viewWillAppear:animated];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)backSegue:(id)sender {
    
}

- (void)searchObject:(id)sender {
    
}

- (void) loadData {
    self.sections = [[NSMutableArray alloc] init];
    self.items = [[NSMutableArray alloc] init];
    self.objects = [[NSMutableArray alloc] init];
    
    if(self.document) {
        NSLog(@"%@", self.document);
        NSObject *obj;
        
        if((obj = self.document[@"title"]) && [obj isKindOfClass:[NSString class]])
            self.navigationItem.title = (NSString*) obj;
        
        if((obj = self.document[@"sections"]) && [obj isKindOfClass:[NSArray class]]) {
            NSArray *arr = (NSArray*) obj;
            for(obj in arr) if([obj isKindOfClass:[NSDictionary class]]) {
                NSDictionary *section = (NSDictionary*) obj;
                
                if((obj = section[@"heading"]) && [obj isKindOfClass:[NSString class]]) {
                    [self.sections addObject:(NSString*) obj];
                    
                    NSMutableArray *itemArr = [[NSMutableArray alloc] init];
                    NSMutableArray *contentsArr = [[NSMutableArray alloc] init];
                    if((obj = section[@"items"]) && [obj isKindOfClass:[NSArray class]]) {
                        NSArray *items = (NSArray*) obj;
                        for(obj in items) if([obj isKindOfClass:[NSDictionary class]]) {
                            NSDictionary *item = (NSDictionary*) obj;
                            
                            NSString *itemName = item[@"name"];
                            if(!itemName) itemName = @"";
                            [itemArr addObject:itemName];
                            
                            NSArray *contents = item[@"contents"];
                            if(!contents) contents = [[NSArray alloc] init];
                            [contentsArr addObject:contents];
                        }
                    }
                    
                    [self.items addObject:itemArr];
                    [self.objects addObject:contentsArr];
                }
            }
        }
    }
    
    NSLog(@"%@", self.items);
    NSLog(@"%@", self.objects);
    
//    [self.sections addObject:@"Lectures"];
//    [self.items addObject:@[@"Lecture 1", @"Lecture 2"]];
//    
//    [self.sections addObject:@"Concepts"];
//    [self.items addObject:@[@"First Order", @"Second Order"]];
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSString *title = self.items[indexPath.section][indexPath.row];
        NSArray *object = self.objects[indexPath.section][indexPath.row];
        DetailViewController *controller = (DetailViewController *)[[segue destinationViewController] topViewController];
        [controller setContents:object];
        controller.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
        controller.navigationItem.leftItemsSupplementBackButton = YES;
        controller.navigationItem.title = title;
    }
}


#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sections.count;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return ((NSArray*) self.items[section]).count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    NSDate *object = self.items[indexPath.section][indexPath.row];
    cell.textLabel.text = [object description];
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return self.sections[section];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.items removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}


@end
