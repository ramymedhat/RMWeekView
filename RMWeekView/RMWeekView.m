//
//  RMWeekView.m
//  RMWeekView
//
//  Created by Ramy Medhat on 12/26/2013.
//  Copyright (c) 2013 ITWorx. All rights reserved.
//
@import QuartzCore;
#import "RMWeekView.h"
#import "NSDate-Utilities.h"

const double kCellWidth = (320.0f/7.0f);
const double kCellHeight = 45.0f;
const double kLabelHeight = 20.0f;

@implementation RMWeekView {
    UIScrollView *_scrollView;
    UILabel *_lblTitle;
    NSMutableArray *_cells;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _cells = [NSMutableArray array];
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, kCellHeight)];
        _scrollView.contentSize = CGSizeMake(kCellWidth*21, kCellHeight);
        _scrollView.pagingEnabled = YES;
        _scrollView.bounces = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.delegate = self;
        _scrollView.delaysContentTouches = YES;
        _scrollView.canCancelContentTouches = YES;
        [self addSubview:_scrollView];
        [self createCells];
        
        _lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, kCellHeight, frame.size.width, frame.size.height - kCellHeight)];
        _lblTitle.backgroundColor = [UIColor clearColor];
        _lblTitle.textAlignment = NSTextAlignmentCenter;
        _lblTitle.font = [UIFont systemFontOfSize:13.0];
        [self addSubview:_lblTitle];
    }
    return self;
}

- (void) createCells {
    double x = 0.0f;
    
    for (int i = 0; i < 21; i++) {
        UIView *cell = [[UIView alloc] initWithFrame:CGRectMake(x, 0, kCellWidth, kCellHeight)];
        cell.backgroundColor = [UIColor clearColor];
        cell.layer.borderColor = [UIColor whiteColor].CGColor;
        cell.layer.borderWidth = 0.3;
        cell.userInteractionEnabled = NO;
        
        UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kCellWidth, 20)];
        lbl.backgroundColor = [UIColor clearColor];
        lbl.userInteractionEnabled = NO;
        lbl.text = [NSString stringWithFormat:@"%@",[self dayLetterForIndex:i%7]];
        lbl.textColor = [UIColor blackColor];
        lbl.textAlignment = NSTextAlignmentCenter;
        lbl.font = [UIFont systemFontOfSize:10.0];
        [cell addSubview:lbl];
        
        [_cells addObject:cell];
        [_scrollView addSubview:cell];
        
        x += kCellWidth;
    }
}

- (NSString*) dayLetterForIndex:(NSInteger)index {
    NSInteger start = (self.weekStartDay + index) % 7;
    switch (start) {
        case 0:
            return @"M";
        case 1:
            return @"T";
        case 2:
            return @"W";
        case 3:
            return @"T";
        case 4:
            return @"F";
        case 5:
            return @"S";
        case 6:
            return @"S";
        default:
            return @"";
    }
}

- (void) setCurrentWeekStart:(NSDate *)currentWeekStart {
    _currentWeekStart = currentWeekStart;
    
	NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
	[outputFormatter setDateFormat:@"MMMM yyyy"];
	NSString *dateString = [outputFormatter stringFromDate:currentWeekStart];
    
    _lblTitle.text = dateString;
    [self updateCellsWithCurrentDate];
}

- (void) updateCellsWithCurrentDate {
    NSInteger days = -7;
    for (int i = 0; i < 21; i++) {
        UIView *cell = (UIView*)_cells[i];
        if ([[cell subviews] count] > 1) {
            [[[cell subviews] lastObject] removeFromSuperview];
        }
        
        UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, kCellWidth, kCellHeight - 20)];
        lbl.backgroundColor = [UIColor clearColor];
        lbl.userInteractionEnabled = NO;
        lbl.text = [NSString stringWithFormat:@"%d",[self.currentWeekStart dateByAddingDays:days].day];
        lbl.textColor = [UIColor blackColor];
        lbl.font = [UIFont boldSystemFontOfSize:16.0];
        lbl.textAlignment = NSTextAlignmentCenter;
        [cell addSubview:lbl];
        days++;
    }
    
    _scrollView.contentOffset = CGPointMake(kCellWidth*7, 0);
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSLog(@"%f", scrollView.contentOffset.x);
    
    if (scrollView.contentOffset.x == 0.0) {
        self.currentWeekStart = [self.currentWeekStart dateBySubtractingDays:7];
    }
    else if (scrollView.contentOffset.x == 640.0) {
        self.currentWeekStart = [self.currentWeekStart dateByAddingDays:7];
    }
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end