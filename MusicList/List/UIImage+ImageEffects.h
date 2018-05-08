//
//  UIImage+imageEffects.h
//  MusicList
//
//  Created by sharui on 2018/5/7.
//  Copyright © 2018年 com.sharui.demo. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <UIKit/UIKit.h>
@interface UIImage (ImageEffects)
- (UIImage *)applyLightEffect;
- (UIImage *)applyExtraLightEffect;
- (UIImage *)applyDarkEffect;
- (UIImage *)applyTintEffectWithColor:(UIColor *)tintColor;
- (UIImage *)applyBlurWithRadius:(CGFloat)blurRadius tintColor:(UIColor *)tintColor saturationDeltaFactor:(CGFloat)saturationDeltaFactor maskImage:(UIImage *)maskImage;
@end
