//
//  RMWeekView.h
//  RMWeekView
//
//  Created by Ramy Medhat on 12/26/2013.
//  Copyright (c) 2013 ITWorx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OCCalendarView.h"

typedef enum WeekDay {
    Mon=0,
    Tue=1,
    Wed=2,
    Thu=3,
    Fri=4,
    Sat=5,
    Sun=6
    } WeekDay;

@interface RMWeekView : UIView <UIScrollViewDelegate, OCCalendarViewDelegate>

/**
 *  Date of first day of the current visible week.
 */
@property (nonatomic, strong) NSDate *currentWeekStart;

/**
 *  Start date of the control.
 */
@property (nonatomic, strong) NSDate *startDate;

/**
 *  End date of the control.
 */
@property (nonatomic, strong) NSDate *endDate;

/**
 *  Day the week starts.
 */
@property (nonatomic) WeekDay weekStartDay;

@end
