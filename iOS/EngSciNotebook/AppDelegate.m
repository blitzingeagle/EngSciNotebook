//
//  AppDelegate.m
//  MAT292
//
//  Created by Morris Chen on 2017-09-07.
//  Copyright © 2017 Morris Chen. All rights reserved.
//

#import "AppDelegate.h"
#import "DetailViewController.h"
#import "MasterViewController.h"
#import "MenuViewController.h"

@interface AppDelegate () <MenuSelectionDelegate, UISplitViewControllerDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    if([self.window.rootViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController *menuNavController = (UINavigationController*) self.window.rootViewController;
        MenuViewController *menuController = [menuNavController.viewControllers firstObject];
        menuController.delegate = self;
    }
    
//    UISplitViewController *splitViewController = (UISplitViewController*) self.window.rootViewController;
//    splitViewController.delegate = self;
//    
//    UINavigationController *masterNavController = [splitViewController.viewControllers firstObject];
//    MasterViewController *masterController = [masterNavController.viewControllers firstObject];
//    masterController.document = document;
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


#pragma mark - Split view

- (BOOL)splitViewController:(UISplitViewController *)splitViewController collapseSecondaryViewController:(UIViewController *)secondaryViewController ontoPrimaryViewController:(UIViewController *)primaryViewController {
    if ([secondaryViewController isKindOfClass:[UINavigationController class]] && [[(UINavigationController *)secondaryViewController topViewController] isKindOfClass:[DetailViewController class]] && ([(DetailViewController *)[(UINavigationController *)secondaryViewController topViewController] contents] == nil)) {
        // Return YES to indicate that we have handled the collapse by doing nothing; the secondary controller will be discarded.
        return YES;
    } else {
        return NO;
    }
}


#pragma mark - Menu selection

- (void) courseMenuSelected:(NSString*)code {
    NSLog(@"Selection");
    
    NSDictionary *document = [AppDelegate readJSON:code];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UISplitViewController *splitViewController = (UISplitViewController*) [storyboard instantiateInitialViewController];
    splitViewController.delegate = self;
    splitViewController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;

    UINavigationController *masterNavController = [splitViewController.viewControllers firstObject];
    MasterViewController *masterController = [masterNavController.viewControllers firstObject];
    masterController.document = document;
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"home"] style:UIBarButtonItemStylePlain target:self action:@selector(backToMenu)];
    masterController.navigationItem.leftBarButtonItem = backButton;
    
    [self.window.rootViewController presentViewController:splitViewController animated:YES completion:nil];
}


- (void) backToMenu {
    [self.window.rootViewController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - JSON input

+ (NSDictionary*) readJSON:(NSString*)jsonFile {
    NSString *filepath = [[NSBundle mainBundle] pathForResource:jsonFile ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:filepath];
    NSError *error;
    NSDictionary *document = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    
    if(error) NSLog(@"Error parsing JSON: %@", error);
    
    return document;
}

@end
