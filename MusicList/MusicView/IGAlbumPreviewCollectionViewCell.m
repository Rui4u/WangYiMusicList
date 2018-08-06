//
//  IGAlbumPreviewCollectionViewCell.m
//  CameraDemo
//
//  Created by sharui on 2016/10/12.
//  Copyright © 2016年 sharui. All rights reserved.
//

#import "IGAlbumPreviewCollectionViewCell.h"


@interface IGAlbumPreviewCollectionViewCell()
@property (nonatomic,strong)UIImageView *imageView;
/**
 预览界面图片
 */
@property (nonatomic,strong)UIImage *conImage;
@end

@implementation IGAlbumPreviewCollectionViewCell

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if(self){
        
       
        _imageView = [[UIImageView alloc]initWithFrame:CGRectZero];
        [self.imageView setContentMode: UIViewContentModeScaleAspectFit];
        [self.contentView addSubview:_imageView];
        _imageView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return self;
}
- (void)setPicImageStr:(UIImage *)picImageStr {
    _picImageStr = picImageStr;
    self.conImage = picImageStr;
    self.imageView.image = self.conImage;
}
@end
