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
#import "OCCalendarView.h"

@interface RMViewController ()

@end

@implementation RMViewController {
    OCCalendarView *calView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    RMWeekView *view = [[RMWeekView alloc] initWithFrame:CGRectMake(0, 50, 320, 65)];
    view.userInteractionEnabled = YES;
    [self.view addSubview:view];
    
    view.currentWeekStart = [[[NSDate date] dateAtStartOfDay] dateBySubtractingDays:4];
    
    CGPoint point = CGPointMake(0, 0);
    int width = 390;
    int height = 300;
    
//    calView = [[OCCalendarView alloc] initAtPoint:CGPointMake(0, 0) withFrame:CGRectMake(-41,0, width, height)];
//    calView.selectionMode = OCSelectionSingleDate;
//    calView.delegate = self;
//    [self.view addSubview:calView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) dateSelected:(NSDate*)date {
    NSLog(@"%@", date);
}
@end
