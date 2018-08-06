//
//  IGAlbumPreviewCollectionViewCell.h
//  CameraDemo
//
//  Created by sharui on 2016/10/12.
//  Copyright © 2016年 sharui. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol IGAlbumPreviewCollectionViewCellDelegate <NSObject>

/**
 选择哪那张图片

 @param indexPath cell路径
 */
- (void)didSelectItemAtIndexPath:(NSIndexPath *)indexPath;

@end

/**
 预览界面cell
 */
@interface IGAlbumPreviewCollectionViewCell : UICollectionViewCell
/**
 信息模型
 */
@property (nonatomic ,strong ) UIImage * picImageStr;
/// 点击角标
@property (nonatomic, strong) NSIndexPath *indexPath;

/**
 点击面包客
 */
@property (nonatomic ,weak ) id <IGAlbumPreviewCollectionViewCellDelegate> delegate;
@end
