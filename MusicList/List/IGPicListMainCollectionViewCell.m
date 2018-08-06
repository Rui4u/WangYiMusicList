//
//  IGPicListMainCollectionViewCell.m
//  jingdongfang
//
//  Created by sharui on 2018/5/10.
//  Copyright © 2018年 BOE-SBG-CTO. All rights reserved.
//

#import "IGPicListMainCollectionViewCell.h"
@interface IGPicListMainCollectionViewCell()
{
}
@end
@implementation IGPicListMainCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self privateSetUpUI];
    }
    return self;
}
- (void)privateSetUpUI {
 

    
    UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, self.height -14 - 8, 80, 14)];
    _nameLabel = titleLabel;
    titleLabel.text = @"全部推送";
    titleLabel.textColor = [UIColor yellowColor];
    titleLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:titleLabel];
    
    _iconImage = [UIImageView new];
    [self addSubview:_iconImage];
    
}
- (void)layoutSubviews {
    [super layoutSubviews];
    _nameLabel.frame = CGRectMake(10, self.height -14 - 8, 80, 14);
    _iconImage.frame = CGRectMake(0,0,self.width,self.height);
}
@end
