//
//  NSTimer+SRTimer.h
//  MusicList
//
//  Created by sharui on 2018/8/6.
//  Copyright © 2018 com.sharui.demo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer (SRTimer)
+ (NSTimer *)sr_scheduledTimerWithTimeInterval:(NSTimeInterval)interval
                                         block:(void(^)(void))block
                                       repeats:(BOOL)repeats;
@end
