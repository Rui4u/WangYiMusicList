//
//  CollectionReusableViewTitle2.m
//  jingdongfang
//
//  Created by sharui on 2018/5/10.
//  Copyright © 2018年 BOE-SBG-CTO. All rights reserved.
//

#import "CollectionReusableViewTitle2.h"

@implementation CollectionReusableViewTitle2
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}
- (void)setupUI {
    UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 150, 40)];
    
    _titleLabel = titleLabel;
    titleLabel.textColor = [UIColor redColor];
    titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:19];
    [self addSubview:titleLabel];
}
@end
