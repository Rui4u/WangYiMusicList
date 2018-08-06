//
//  NSTimer+SRTimer.m
//  MusicList
//
//  Created by sharui on 2018/8/6.
//  Copyright © 2018 com.sharui.demo. All rights reserved.
//

#import "NSTimer+SRTimer.h"

@implementation NSTimer (SRTimer)
+ (NSTimer *)sr_scheduledTimerWithTimeInterval:(NSTimeInterval)interval
                                         block:(void(^)(void))block
                                       repeats:(BOOL)repeats {
    
    
    
    return [self timerWithTimeInterval:interval
                                target:self
                              selector:@selector(sr_blockInvoke:)
                              userInfo:[block copy]
                               repeats:repeats];
}
+ (void)sr_blockInvoke:(NSTimer *)timer {
    void (^block)(void) = timer.userInfo;
    if(block) {
        block();
    }
}

@end
