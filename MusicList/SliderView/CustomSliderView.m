//
//  CustomSliderView.m
//  MusicList
//
//  Created by sharui on 2018/7/31.
//  Copyright © 2018 com.sharui.demo. All rights reserved.
//

#import "CustomSliderView.h"
@implementation CustomSliderView
{
    UILabel *timeLabel;
    UIView *sliderView;
    CGFloat kMargin,bgViewHeight;
    UIView *bgView;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor yellowColor];
        [self privateUI];
    }
    return self;
}
- (void)privateUI {
    
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(swipeGes:)];

    [self addGestureRecognizer:pan];
    UITapGestureRecognizer *singleFingerOne = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                action:@selector(handleSingleFingerEvent:)];
    [self addGestureRecognizer:singleFingerOne];

    bgViewHeight = 5;
    kMargin = 10;
    
    bgView = [[UIView alloc] initWithFrame:CGRectMake(kMargin, (self.height - bgViewHeight)/2, kScreenWidth - kMargin*2, bgViewHeight)];
    bgView.backgroundColor = [UIColor redColor];
    [self addSubview:bgView];
    
    sliderView = [[UIView alloc] initWithFrame:CGRectMake(0,0,0,bgView.height)];
    sliderView.backgroundColor = [UIColor blueColor];
    sliderView.clipsToBounds = NO;
    
    [bgView addSubview:sliderView];
    
    
    timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];
    timeLabel.textAlignment = NSTextAlignmentCenter;
    timeLabel.backgroundColor = [UIColor greenColor];
    timeLabel.font = [UIFont systemFontOfSize:10];
    timeLabel.userInteractionEnabled = NO;
    [sliderView addSubview:timeLabel];
    timeLabel.centerY = sliderView.centerY;
}
- (void)setBeginTime:(NSString *)beginTime {
    _beginTime  = beginTime.copy;
    if (beginTime.intValue == 0) sliderView.width = 0;
    else sliderView.width = _beginTime.floatValue/_endTime.floatValue * bgView.width;
    timeLabel.text = [self setTimeLabelText];

}
- (void)setEndTime:(NSString *)endTime {
    _endTime = endTime.copy;
    timeLabel.text = [self setTimeLabelText];

}
//单击
- (void)handleSingleFingerEvent:(UITapGestureRecognizer *)tap {
    CGPoint nowPoint = [tap locationInView:sliderView];
    [self setPointWithNowPoint:nowPoint];
    
    
    if (self.setBeginTimeBlock) {
        int nowSec = (int)(sliderView.width /bgView.width * _endTime.intValue);
        NSString * nowTimeStr = [NSString stringWithFormat:@"%02d:%02d",nowSec/60,nowSec%60];
        self.setBeginTimeBlock(nowTimeStr);
    }
    
}
// 滑动
- (void)swipeGes:(UIPanGestureRecognizer *)pan
{
    CGPoint nowPoint = [pan locationInView:sliderView];
    [self setPointWithNowPoint:nowPoint];
    if (pan.state == UIGestureRecognizerStateEnded) {
        NSLog(@"结束");
        if (self.setBeginTimeBlock) {
            int nowSec = (int)(sliderView.width /bgView.width * _endTime.intValue);
            NSString * nowTimeStr = [NSString stringWithFormat:@"%02d:%02d",nowSec/60,nowSec%60];
            self.setBeginTimeBlock(nowTimeStr);
        }
    }
}
- (void)setPointWithNowPoint:(CGPoint)nowPoint{
    NSLog(@"nowPoint%@",NSStringFromCGPoint(nowPoint));
    
    if (nowPoint.x >= 0 && nowPoint.x <= bgView.width) {
        sliderView.width = nowPoint.x;
        if (nowPoint.x <timeLabel.width/2) {
            timeLabel.centerX = timeLabel.width/2;
        }else if (nowPoint.x >= bgView.width - timeLabel.width/2) {
            timeLabel.centerX = bgView.right - timeLabel.width/2 - kMargin;
        }else {
            timeLabel.centerX = nowPoint.x;
        }
    }
  
    timeLabel.text = [self setTimeLabelText];
}

- (NSString *)setTimeLabelText{
    NSString * endTimeStr = [NSString stringWithFormat:@"%02d:%02d",_endTime.intValue/60,_endTime.intValue%60];
    int nowSec = (int)(sliderView.width /bgView.width * _endTime.intValue);
    NSString * nowTimeStr = [NSString stringWithFormat:@"%02d:%02d",nowSec/60,nowSec%60];
    return [NSString stringWithFormat:@"%@/%@",nowTimeStr, endTimeStr];
}

@end
