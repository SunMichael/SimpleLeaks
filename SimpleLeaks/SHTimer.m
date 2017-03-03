//
//  SHTimer.m
//  SimpleLeaks
//
//  Created by mac on 2017/3/3.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "SHTimer.h"

@interface SHTimer ()

@property (nonatomic ,weak) id target;
@property (nonatomic ,weak) NSTimer *timer;
@property (nonatomic ,assign) SEL selector;

@end

@implementation SHTimer

+(SHTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)timeInterval target:(id)aTarget selector:(SEL)aSelector userInfo:(id)userInfo repeats:(BOOL)yesOrNo{
    
    SHTimer *timer = [[SHTimer alloc] init];
    timer.timer = [NSTimer scheduledTimerWithTimeInterval:timeInterval target:timer selector:@selector(timerStart) userInfo:userInfo repeats:yesOrNo];
    timer.target = aTarget;
    timer.selector = aSelector;
    return timer;
}

- (void)timerStart{
    if (self.target) {
        [self.target performSelector:self.selector withObject:self.timer.userInfo afterDelay:0.0f];
    }else{
        [self.timer invalidate];
        self.timer = nil;
    }
}


@end
