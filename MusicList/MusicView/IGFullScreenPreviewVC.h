//
//  IGFullScreenPreviewVC.h
//  jingdongfang
//
//  Created by RKL on 2018/8/3.
//  Copyright © 2018年 BOE-SBG-CTO. All rights reserved.
//  画单预览-全屏预览

#import <UIKit/UIKit.h>
#import "IGAlbumPreviewLayout.h"
@interface IGFullScreenPreviewVC : UICollectionViewController
/////> 数据源
//@property (nonatomic, strong) IGDrawModel * drawModel;

@property (nonatomic, strong) NSMutableArray *drawArray;
///> 返回时的回调 ， 带回当前浏览的作品页数
@property (nonatomic, copy) void(^currentPageBlock)(NSInteger pageNum);
///> 判断是横屏还是竖屏  1：横屏    2：竖屏
@property (nonatomic, copy) NSString * artworkPlate;

@property (nonatomic, assign) BOOL showPlayView;
@end






