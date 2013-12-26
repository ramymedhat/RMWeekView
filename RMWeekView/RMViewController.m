//
//  RMViewController.m
//  RMWeekView
//
//  Created by Ramy Medhat on 12/26/2013.
//  Copyright (c) 2013 ITWorx. All rights reserved.
//

#import "RMViewController.h"
#import "RMWeekView.h"
#import "NSDate-Utilities.h"

@interface RMViewController ()

@end

@implementation RMViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    RMWeekView *view = [[RMWeekView alloc] initWithFrame:CGRectMake(0, 50, 320, 65)];
    view.userInteractionEnabled = YES;
    [self.view addSubview:view];
    
    view.currentWeekStart = [[[NSDate date] dateAtStartOfDay] dateBySubtractingDays:4];
    
    self.scrollView.contentSize = CGSizeMake(1000.0, 1000.0);
    self.scrollView.scrollEnabled = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
