//
//  DetailViewController.m
//  MAT292
//
//  Created by Morris Chen on 2017-09-07.
//  Copyright © 2017 Morris Chen. All rights reserved.
//

#import "DetailViewController.h"
#import "MTMathUILabel.h"
#import "CorePlot.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

- (void) configureView {
    // Update the user interface for the detail item.
    if(!self.contents || [self.contents count] == 0) {
        self.detailDescriptionLabel.text = @"Coming Soon!";
        return;
    }
    
    NSObject *obj;
    for(obj in self.contents) if([obj isKindOfClass:[NSDictionary class]]) {
        NSDictionary *doc = (NSDictionary*) obj;
        NSString *type = doc[@"type"];
        
        if([type isEqualToString:@"label"]) {
            UILabel *label = [[UILabel alloc] init];
            label.numberOfLines = 0;
            label.adjustsFontSizeToFitWidth = NO;
            label.lineBreakMode = NSLineBreakByWordWrapping;
            
            if((obj = doc[@"text"]) && [obj isKindOfClass:[NSString class]])
                label.text = (NSString*) obj;
            
            [self.detailStackView addArrangedSubview:label];
        } else if([type isEqualToString:@"math_label"]) {
            MTMathUILabel *label = [[MTMathUILabel alloc] init];
            label.textAlignment = NSTextAlignmentCenter;
            
            if((obj = doc[@"latex"]) && [obj isKindOfClass:[NSString class]])
                label.latex = (NSString*) obj;
            
            if((obj = doc[@"labelMode"]) && [obj isKindOfClass:[NSString class]])
                label.labelMode = [((NSString*)obj) isEqualToString:@"text"] ? kMTMathUILabelModeText : kMTMathUILabelModeDisplay;
            
            [self.detailStackView addArrangedSubview:label];
        } else if([type isEqualToString:@"textview"]) {
            UITextView *textView = [[UITextView alloc] init];
            textView.scrollEnabled = NO;
            textView.editable = NO;
            
            if((obj = doc[@"text"]) && [obj isKindOfClass:[NSString class]])
                textView.text = (NSString*) obj;
            
            [self.detailStackView addArrangedSubview:textView];
        }
    }
    
//    CPTGraphHostingView *graphView = [[CPTGraphHostingView alloc] init];
//    [graphView.heightAnchor constraintEqualToConstant:300].active = YES;
//    [graphView.widthAnchor constraintEqualToConstant:300].active = YES;
//    [self.detailStackView addArrangedSubview:graphView];
}


- (void) viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}


- (void) didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Managing the detail item

- (void) setContents:(NSArray *)contents {
    if(_contents != contents) {
        _contents = contents;
    }
}


@end
