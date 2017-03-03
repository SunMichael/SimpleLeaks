//
//  SHTimer.h
//  SimpleLeaks
//
//  Created by mac on 2017/3/3.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SHTimer : NSObject

+ (SHTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)timeInterval target:(nonnull id)aTarget selector:(nonnull SEL)aSelector userInfo:(nullable id)userInfo repeats:(BOOL)yesOrNo;



@end
