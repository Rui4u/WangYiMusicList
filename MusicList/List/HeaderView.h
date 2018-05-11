//
//  HeaderView.h
//  jingdongfang
//
//  Created by RKL on 2018/5/7.
//  Copyright © 2018年 BOE-SBG-CTO. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kTabViewHeight 290 - kNavBarHeight
#define KHeadViewOff 200  //下拉弹簧最大值
typedef void(^picCompleteBlock)(void);

@interface HeaderView : UIView

@property (nonatomic, strong) UIImageView *backgroundImageView;


@property (nonatomic, strong) UIImageView * leftView;
@property (nonatomic, strong) UILabel * titleLabel;

@property (nonatomic, strong) UIImageView * authorImageView;
@property (nonatomic, strong) UILabel * authorLabel;


//四个按钮
@property (nonatomic, strong) UILabel * btnLabel1;
@property (nonatomic, strong) UILabel * btnLabel2;
@property (nonatomic, strong) UILabel * btnLabel3;
@property (nonatomic, strong) UILabel * btnLabel4;
//四个button
@property (nonatomic, strong) UIButton * btn1;
@property (nonatomic, strong) UIButton * btn2;
@property (nonatomic, strong) UIButton * btn3;
@property (nonatomic, strong) UIButton * btn4;

- (void)setIconPicStr:(NSString *)iconPicStr withCompleteBlock:(picCompleteBlock) completion;

@end








