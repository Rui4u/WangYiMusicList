//
//  CollectionReusableViewTitle1.m
//  jingdongfang
//
//  Created by sharui on 2018/5/10.
//  Copyright © 2018年 BOE-SBG-CTO. All rights reserved.
//

#import "CollectionReusableViewTitle1.h"
@implementation CollectionReusableViewTitle1
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    UIImageView * iconImage = [UIImageView new];
    iconImage.backgroundColor = [UIColor redColor];
    iconImage.frame = CGRectMake(10, (40 - 15)/2, 15, 15);
    [self addSubview:iconImage];
    
    UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(iconImage.frame) + 8, 0, 80, 19)];
    titleLabel.centerY = iconImage.centerY;
    titleLabel.text = @"全部推送";
    titleLabel.textColor = [UIColor redColor];
    titleLabel.font = [UIFont systemFontOfSize:19];
    [self addSubview:titleLabel];
    
    UILabel * totolNum = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(titleLabel.frame) + 8, 0, 150, 19)];
    totolNum.centerY = iconImage.centerY;
    totolNum.text = @"(15)";
    totolNum.textColor = [UIColor greenColor];
    totolNum.font = [UIFont systemFontOfSize:19];
    _totolNum = totolNum;
    [self addSubview:totolNum];
    
    
    UILabel * selectTitle = [[UILabel alloc] initWithFrame:CGRectMake( - 50, 0, 50, 16)];
    selectTitle.text = @"多选";
    selectTitle.textAlignment = NSTextAlignmentCenter;
    selectTitle.centerY = iconImage.centerY;
    selectTitle.textColor = [UIColor redColor];
    selectTitle.font = [UIFont systemFontOfSize:16];
    [self addSubview:selectTitle];
    
    UIImageView * selectImage = [UIImageView new];
    selectImage.backgroundColor = [UIColor redColor];
    selectImage.frame = CGRectMake(CGRectGetMinX(selectTitle.frame) - 15,0, 15, 15);
    selectImage.centerY = iconImage.centerY;
    [self addSubview:selectImage];
    
    
}
@end
