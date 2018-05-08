//
//  HeaderView.h
//  MusicList
//
//  Created by sharui on 2018/5/7.
//  Copyright © 2018年 com.sharui.demo. All rights reserved.
//

#import <UIKit/UIKit.h>
#define Is_iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
/***  当前屏幕宽度 */
#define kScreenWidth  ([[UIScreen mainScreen] bounds].size.width)
/***  当前屏幕高度 */
#define kScreenHeight  ([[UIScreen mainScreen] bounds].size.height)
#define kTabBarHeight ((Is_iPhoneX)?(83):(49))
#define kTabViewHeight 250 
#define kNavBarHeight ((Is_iPhoneX)?(64.f + 20):(64.f))
#define KHeadViewOff 200  //下拉弹簧最大值
typedef void(^picCompleteBlock)(void);

@interface HeaderView : UIView
@property (nonatomic, strong) UIImageView *backgroundImageView;
@property (nonatomic, strong) UIImageView * leftView;
- (void)setIconPicStr:(NSString *)iconPicStr withCompleteBlock:(picCompleteBlock) completion;
@end
