//
//  HeaderView.m
//  jingdongfang
//
//  Created by RKL on 2018/5/7.
//  Copyright © 2018年 BOE-SBG-CTO. All rights reserved.
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
    if (self)
    {
        [self setUpUI];
    }
    return self;
}
#pragma mark - 构建UI
- (void)setUpUI
{
    UIImage *iconImage = [UIImage imageNamed:@"timg.jpeg"];//默认图片
    
    //背景
    _backgroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, -kNavBarHeight - KHeadViewOff, self.bounds.size.width,
                                                                         self.bounds.size.height + kNavBarHeight +KHeadViewOff)];  //向上拉伸navbar 高度
    [_backgroundImageView setImageToBlur:iconImage blurRadius:20 completionBlock:nil]; //高斯处理
    [self addSubview:_backgroundImageView];
    _backgroundImageView.contentMode = UIViewContentModeScaleToFill;
    
    //左侧图片
    UIImageView * leftView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 80 - kNavBarHeight, 139, 139)];
    leftView.image = iconImage;
    _leftView = leftView;
    _leftView.layer.masksToBounds = YES;
    [_leftView.layer setCornerRadius:10]; //设置矩形四个圆角半径
    [self addSubview:leftView];
    
    //label
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(leftView.frame)+15, CGRectGetMinY(leftView.frame)+24, kScreenWidth-CGRectGetMaxX(leftView.frame)-30, 18)];
    label.text = @"动人情话遇见申请告白";
    _titleLabel = label;
    [self addSubview:label];
    
    
    self.authorImageView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(leftView.frame)+15, CGRectGetMaxY(_titleLabel.frame)+24, 24, 24)];
    self.authorImageView.backgroundColor = [UIColor redColor];
    [self.authorImageView.layer setCornerRadius:12]; //设置矩形四个圆角半径
    [self.authorImageView.layer setBorderWidth:0]; //边框宽度
    [self addSubview:self.authorImageView];
    
    self.authorLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.authorImageView.frame)+5, CGRectGetMaxY(_titleLabel.frame)+26, 100, 18)];
    self.authorLabel.text = @"zhuzhidaong";
    [self addSubview:self.authorLabel];
    
    
    float tempWidth = (kScreenWidth-88)/8;
    self.btn1 = ({
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(tempWidth, CGRectGetMaxY(_leftView.frame)+19, 22, 19);
        button.backgroundColor = [UIColor yellowColor];
        button;
    });
    [self addSubview:self.btn1];

    self.btn2 = ({
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(CGRectGetMaxX(self.btn1.frame)+2*tempWidth, CGRectGetMaxY(_leftView.frame)+19, 22, 19);
        button.backgroundColor = [UIColor yellowColor];
        button;
    });
    [self addSubview:self.btn2];

    self.btn3 = ({
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(CGRectGetMaxX(self.btn2.frame)+2*tempWidth, CGRectGetMaxY(_leftView.frame)+19, 22, 19);
        button.backgroundColor = [UIColor yellowColor];
        button;
    });
    [self addSubview:self.btn3];

    self.btn4 = ({
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(CGRectGetMaxX(self.btn3.frame)+2*tempWidth, CGRectGetMaxY(_leftView.frame)+19, 22, 19);
        button.backgroundColor = [UIColor yellowColor];
        button;
    });
    [self addSubview:self.btn4];

    
    self.btnLabel1 = ({
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.btn1.frame)+6, kScreenWidth/4, 12)];
        label.text = @"2222";
        label.font = [UIFont systemFontOfSize:12];
        label.textAlignment = NSTextAlignmentCenter;
        label;
    });
    [self addSubview:self.btnLabel1];
    
    self.btnLabel2 = ({
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth/4, CGRectGetMaxY(self.btn1.frame)+6, kScreenWidth/4, 12)];
        label.text = @"2222";
        label.font = [UIFont systemFontOfSize:12];
        label.textAlignment = NSTextAlignmentCenter;
        label;
    });
    [self addSubview:self.btnLabel2];
    
    self.btnLabel3 = ({
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth/4*2, CGRectGetMaxY(self.btn1.frame)+6, kScreenWidth/4, 12)];
        label.text = @"2222";
        label.font = [UIFont systemFontOfSize:12];
        label.textAlignment = NSTextAlignmentCenter;
        label;
    });
    [self addSubview:self.btnLabel3];
    
    self.btnLabel4 = ({
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth/4*3, CGRectGetMaxY(self.btn1.frame)+6, kScreenWidth/4, 12)];
        label.text = @"2222";
        label.font = [UIFont systemFontOfSize:12];
        label.textAlignment = NSTextAlignmentCenter;
        label;
    });
    [self addSubview:self.btnLabel4];
    
}

#pragma markk - set方法
- (void)setTitleLabel:(UILabel *)titleLabel
{
    _titleLabel = titleLabel;
    
}

- (void)setLeftView:(UIImageView *)leftView
{
    _leftView = leftView;
}



#pragma mark - 处理图片的方法  网络请求回来后调用
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
