//
//  PicRectionViewCollectionViewCell.m
//  jingdongfang
//
//  Created by sharui on 2018/5/10.
//  Copyright © 2018年 BOE-SBG-CTO. All rights reserved.
//

#import "PicRectionViewCollectionViewCell.h"
@interface PicRectionViewCollectionViewCell ()
@property (nonatomic, strong) UIScrollView *scrollview;
@end
@implementation PicRectionViewCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self privateSetUpUI];
    }
    return self;
}

- (void)privateSetUpUI {
    
    
    
    self.scrollview.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
}
- (void)setDataSourse:(NSArray *)dataSourse {
    for (UIView *view in _scrollview.subviews) {
        [view removeFromSuperview];
    }
    _dataSourse = dataSourse;
    CGFloat maxX = 0.0;
    CGFloat Margin = 3;
    CGFloat width = ((self.frame.size.width - 3 * 4)/3);
    for (int i = 0 ; i < dataSourse.count; i ++) {
        UIImageView * picImageView = [UIImageView new];
        picImageView.frame = CGRectMake(Margin +(width +Margin)*i, 0, width, width);
        picImageView.backgroundColor = [UIColor purpleColor];
        picImageView.layer.masksToBounds = YES;
        picImageView.layer.cornerRadius = 10;
        
        
        
        UILabel * title = [[UILabel alloc] initWithFrame:CGRectMake(Margin +(width +Margin)*i, CGRectGetMaxY(picImageView.frame) + 10, width, 14)];
        title.text = @"梵高遇见向日葵";
        title.textAlignment = NSTextAlignmentCenter;
        title.textColor = [UIColor redColor];
        title.font = [UIFont systemFontOfSize:14];
        
        
        [self.scrollview addSubview:picImageView];
        [self.scrollview addSubview:title];
        maxX = CGRectGetMaxX(picImageView.frame);
    }
    self.scrollview.contentSize = CGSizeMake(maxX + 3, 0);
    
}

-(UIScrollView *)scrollview {
    if (_scrollview == nil) {
        _scrollview = [UIScrollView new];
        [self addSubview:_scrollview];
    }
    return _scrollview;
}
@end
