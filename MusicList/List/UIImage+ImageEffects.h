//
//  UIImage+imageEffects.h
//  jingdongfang
//
//  Created by RKL on 2018/5/7.
//  Copyright © 2018年 BOE-SBG-CTO. All rights reserved.
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
