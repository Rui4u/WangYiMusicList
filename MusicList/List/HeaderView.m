//
//  HeaderView.m
//  MusicList
//
//  Created by sharui on 2018/5/7.
//  Copyright © 2018年 com.sharui.demo. All rights reserved.
//

#import "HeaderView.h"
#import "UIImageView+LBBlurredImage.h"
@interface HeaderView ()
/**
 背景图片
 */
@property (nonatomic, strong) UIImageView *bgImgView;
@end
@implementation HeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpUI];
        
    }
    return self;
}

- (void)setUpUI {
    
    UIImage *iconImage = [UIImage imageNamed:@"timg.jpeg"];
    
    
    //背景
    _backgroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, -kNavBarHeight - KHeadViewOff, self.bounds.size.width,
                                                                         self.bounds.size.height + kNavBarHeight +KHeadViewOff)];  //向上拉伸navbar 高度
    [_backgroundImageView setImageToBlur:iconImage blurRadius:20 completionBlock:nil]; //高斯处理
    [self addSubview:_backgroundImageView];
    _backgroundImageView.contentMode = UIViewContentModeScaleToFill;
    
    //左侧图片
    UIImageView * leftView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 15, 80, 80)];
    _leftView = leftView;
    leftView.image = iconImage;
    [self addSubview:leftView];
    
    //label
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(120, 15, 100, 20)];
    label.text = @"测试";
    label.textColor = [UIColor whiteColor];
    [self addSubview:label];
}
- (void)setLeftView:(UIImageView *)leftView {
    _leftView = leftView;
}
- (void)setIconPicStr:(NSString *)iconPicStr withCompleteBlock:(picCompleteBlock) completion {
    
    __weak typeof(self) weakSelf = self;
    
    //这块改成网络请求的加载的 利用sdwebiamge 请求完成后 走回调
    dispatch_async(dispatch_get_main_queue(), ^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{ //模拟网络延时
            
            //回调这里
            UIImage *iconImage = [UIImage imageNamed:@"1525674467336.jpg"]; //换成sd
            weakSelf.leftView.image = iconImage;
            
            [weakSelf.backgroundImageView setImageToBlur:iconImage blurRadius:20 completionBlock:^{
                completion();
            }]; //高斯处理
        });
    });
    
}
@end
