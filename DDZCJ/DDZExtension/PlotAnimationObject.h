//
//  PlotAnimationObject.h
//  DDZCJ
//
//  Created by jjj on 2019/9/9.
//  Copyright © 2019 df. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^ QuitRentAnimationBlock)(void);

@interface PlotAnimationObject : NSObject

+ (void)translationAnimationView:(UIView *)view animationDuration:(NSTimeInterval)timer animationBlock:(QuitRentAnimationBlock)block;

+ (void)translationXYAnimationView:(UIView *)view animationDuration:(NSTimeInterval)timer animationBlock:(QuitRentAnimationBlock)block;

+ (void)translationXY2AnimationView:(UIView *)view animationDuration:(NSTimeInterval)timer animationBlock:(QuitRentAnimationBlock)block;

+ (void)translationXY3AnimationView:(UIView *)view animationDuration:(NSTimeInterval)timer animationBlock:(QuitRentAnimationBlock)block;

+ (void)translationHouseAnimationView:(UIView *)view animationDuration:(NSTimeInterval)timer animationBlock:(QuitRentAnimationBlock)block;

+ (void)translationGradeAnimationView:(UIView *)view animationDuration:(NSTimeInterval)timer animationBlock:(QuitRentAnimationBlock)block;

+ (void)translationKaoGuanAnimationView:(UIView *)view animationDuration:(NSTimeInterval)timer animationBlock:(QuitRentAnimationBlock)block;

+ (void)translationFeedBackAnimationView:(UIView *)view animationDuration:(NSTimeInterval)timer animationBlock:(QuitRentAnimationBlock)block;

@end

NS_ASSUME_NONNULL_END
