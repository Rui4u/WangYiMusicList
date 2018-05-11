//
//  IGPicListMainCollectionViewCell.m
//  jingdongfang
//
//  Created by sharui on 2018/5/10.
//  Copyright © 2018年 BOE-SBG-CTO. All rights reserved.
//

#import "IGPicListMainCollectionViewCell.h"
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
    
    UIImageView * iconImage = [UIImageView new];
    iconImage.backgroundColor = [UIColor redColor];
    iconImage.frame = CGRectMake(self.width - 8 - 20, self.height - 20 - 8 ,20,20);
    [self addSubview:iconImage];
    
}
@end
