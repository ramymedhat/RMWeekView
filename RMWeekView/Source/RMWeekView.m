//
//  RMWeekView.m
//  RMWeekView
//
//  Created by Ramy Medhat on 12/26/2013.
//  Copyright (c) 2013 ITWorx. All rights reserved.
//
@import QuartzCore;
#import "RMWeekView.h"
#import "OCCalendarView.h"
#import "NSDate-Utilities.h"
#import "NSDate+Helper.h"

const double kCellWidth = (320.0f/7.0f);
const double kCellHeight = 45.0f;
const double kLabelHeight = 20.0f;

@implementation RMWeekView {
    UIScrollView *_scrollView;
    UILabel *_lblTitle;
    NSMutableArray *_cells;
    OCCalendarView *calView;
    UIView *viewMask;
    BOOL isOpen;
}

- (id)initWithFrame:(CGRect)frame andWeekStart:(WeekDay)weekStartDay
{
    self = [super initWithFrame:frame];
    if (self) {
        self.weekStartDay = weekStartDay;
        
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
        _lblTitle.userInteractionEnabled = YES;
        [self addSubview:_lblTitle];
        
        viewMask = [[UIView alloc] initWithFrame:CGRectMake(0, kCellHeight+kLabelHeight, frame.size.width, 960)];
        viewMask.backgroundColor = [UIColor clearColor];
        viewMask.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped:)];
        [viewMask addGestureRecognizer:tapRecognizer];
        [self addSubview:viewMask];
        
        calView = [[OCCalendarView alloc] initAtPoint:CGPointMake(0, 0) withFrame:CGRectMake(-41,0, 390, 300)];
        calView.selectionMode = OCSelectionSingleDate;
        calView.delegate = self;
        calView.alpha = 0.0;
        [self addSubview:calView];
        
        UITapGestureRecognizer *tapRecognizer2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped:)];
        [_scrollView addGestureRecognizer:tapRecognizer2];
        UITapGestureRecognizer *tapRecognizer3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped:)];
        [_lblTitle addGestureRecognizer:tapRecognizer3];
        [self bringSubviewToFront:_scrollView];
        [self bringSubviewToFront:_lblTitle];
        
        isOpen = NO;
    }
    return self;
}

- (void) tapped:(UIGestureRecognizer*)recognizer {
    //if (![calView pointInside:[recognizer locationOfTouch:0 inView:calView] withEvent:nil]) {
    recognizer.enabled = NO;
    if (!isOpen) {
        calView.alpha = 1.0;
        [calView setCurrentMonth:self.currentWeekStart.month];
        [calView setCurrentYear:self.currentWeekStart.year];
        [calView setStartDate:self.currentWeekStart];
        [calView setEndDate:self.currentWeekStart];
        [calView resetViews];
        _scrollView.scrollEnabled = NO;
        [UIView animateWithDuration:0.25 delay:0 usingSpringWithDamping:0.3 initialSpringVelocity:0 options:0 animations:^{
            calView.center = CGPointMake(calView.center.x, calView.center.y+35);
        } completion:^(BOOL finished) {
            self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, self.frame.size.height+960);
            recognizer.enabled = YES;
            isOpen = YES;
        }];
    }
    else {
        NSLog(@"Close 2");
        [UIView animateWithDuration:0.25 animations:^{
            calView.alpha = 0.0;
            _scrollView.scrollEnabled = YES;
            calView.center = CGPointMake(calView.center.x, calView.center.y-35);
            self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, self.frame.size.height-960);
        } completion:^(BOOL finished) {
//          calView.center = CGPointMake(calView.center.x, calView.center.y+65);
            recognizer.enabled = YES;
            isOpen = NO;
        }];
    }
    //}
}

- (void) createCells {
    double x = 0.0f;
    
    for (int i = 0; i < 21; i++) {
        UIView *cell = [[UIView alloc] initWithFrame:CGRectMake(x, 0, kCellWidth, kCellHeight)];
        cell.backgroundColor = [UIColor clearColor];
        cell.layer.borderColor = [UIColor whiteColor].CGColor;
        cell.layer.borderWidth = 0.3;
        cell.userInteractionEnabled = NO;
        
        if (i < 7) {
            UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(x, 0, kCellWidth, 20)];
            lbl.backgroundColor = [UIColor clearColor];
            lbl.userInteractionEnabled = NO;
            lbl.text = [NSString stringWithFormat:@"%@",[self dayLetterForIndex:i%7]];
            lbl.textColor = [UIColor blackColor];
            lbl.textAlignment = NSTextAlignmentCenter;
            lbl.font = [UIFont systemFontOfSize:10.0];
            [self addSubview:lbl];
        }
        
        [_cells addObject:cell];
        [_scrollView addSubview:cell];
        
        x += kCellWidth;
    }
}


- (void) dateSelected:(NSDate*)date {
    if (isOpen) {
        NSLog(@"Close 1");
        isOpen = NO;
        self.currentWeekStart = [date beginningOfWeek];
        [UIView animateWithDuration:0.25 animations:^{
            calView.alpha = 0.0;
            _scrollView.scrollEnabled = YES;
            calView.center = CGPointMake(calView.center.x, calView.center.y-35);
            self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, self.frame.size.height-960);
        } completion:^(BOOL finished) {
            //          calView.center = CGPointMake(calView.center.x, calView.center.y+65);
            //recognizer.enabled = YES;
        }];
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
        if ([[cell subviews] count] > 0) {
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