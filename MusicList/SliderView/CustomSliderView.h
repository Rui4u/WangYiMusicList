//
//  CustomSliderView.h
//  MusicList
//
//  Created by sharui on 2018/7/31.
//  Copyright © 2018 com.sharui.demo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomSliderView : UIView
@property (nonatomic, copy) NSString *beginTime; //开始时间
@property (nonatomic, copy) NSString *endTime; //结束时间
@property (nonatomic, copy) void(^setBeginTimeBlock)(NSString * beginTime); //拖动后回调;
@end
