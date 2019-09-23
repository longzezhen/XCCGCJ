//
//  PlotAnimationObject.m
//  DDZCJ
//
//  Created by jjj on 2019/9/9.
//  Copyright © 2019 df. All rights reserved.
//

#import "PlotAnimationObject.h"

@interface PlotAnimationObject ()<CAAnimationDelegate>

@end

@implementation PlotAnimationObject

+ (void)translationAnimationView:(UIView *)view animationDuration:(NSTimeInterval)timer animationBlock:(QuitRentAnimationBlock)block
{
    [UIView animateWithDuration:timer animations:^{
        CGRect rect = view.frame;
        rect.origin.x = fabs(view.frame.origin.x) + KScreenWidth;
        view.frame = rect;
        
    } completion:^(BOOL finished) {
        if (finished) {
            block();
        }
    }];
}

+ (void)translationXYAnimationView:(UIView *)view animationDuration:(NSTimeInterval)timer animationBlock:(QuitRentAnimationBlock)block
{
    [UIView animateWithDuration:timer animations:^{
        CGRect rect = view.frame;
        rect.origin.x = Auto_Width(567);
        rect.origin.y = -(Auto_Height(7));
        view.frame = rect;
        
    } completion:^(BOOL finished) {
        if (finished) {
            block();
        }
    }];
}

+ (void)translationXY2AnimationView:(UIView *)view animationDuration:(NSTimeInterval)timer animationBlock:(QuitRentAnimationBlock)block
{
    [UIView animateWithDuration:timer animations:^{
        CGRect rect = view.frame;
        rect.origin.x = Auto_Width(567)+8;
        rect.origin.y = -(Auto_Height(7*.7));
        view.frame = rect;
        
    } completion:^(BOOL finished) {
        if (finished) {
            block();
        }
    }];
}

+ (void)translationXY3AnimationView:(UIView *)view animationDuration:(NSTimeInterval)timer animationBlock:(QuitRentAnimationBlock)block
{
    [UIView animateWithDuration:timer animations:^{
        CGRect rect = view.frame;
        rect.origin.x = Auto_Width(567)+16;
        rect.origin.y = -(Auto_Height(7*.7));
        view.frame = rect;
        
    } completion:^(BOOL finished) {
        if (finished) {
            block();
        }
    }];
}

+ (void)translationHouseAnimationView:(UIView *)view animationDuration:(NSTimeInterval)timer animationBlock:(QuitRentAnimationBlock)block
{
    // 表示view的原来尺寸
//    view.layer.transform = CATransform3DMakeScale(1, 1, 1);
    
//    [UIView animateWithDuration:timer animations:^{
//
//        view.layer.transform = CATransform3DMakeScale(1.2, 1.2, 1);
//
//    } completion:^(BOOL finished) {
//        if (finished) {
//            block();
//        }
//    }];
    
    [UIView animateWithDuration:timer animations:^{
        CGRect rect = view.frame;
        
        rect.size.width = Auto_Width(470)/2 + 10;
        rect.size.height = Auto_Height(331)/2 - 10;
        
        rect.origin.x = Auto_Width(140)/2 - 5;
        rect.origin.y = Auto_Height(442)/2 + 10;
        
        view.frame = rect;
        
    } completion:^(BOOL finished) {
        if (finished) {
            block();
        }
    }];
    
}

+ (void)translationGradeAnimationView:(UIView *)view animationDuration:(NSTimeInterval)timer animationBlock:(QuitRentAnimationBlock)block
{

    [UIView animateWithDuration:timer animations:^{
        CGRect rect = view.frame;
        
        rect.size.width = Auto_Width(257)/2 + 10;
        rect.size.height = Auto_Width(416)/2 - 10;
        
        rect.origin.x = (KScreenWidth-Auto_Width(257)/2)/2 - 5;
        CGFloat set_y = IS_IPhoneX_All ? Auto_Height(672) : Auto_Height(652);
        rect.origin.y = set_y/2 + 10;
        
        view.frame = rect;
        
    } completion:^(BOOL finished) {
        if (finished) {
            block();
        }
    }];
    
}

+ (void)translationKaoGuanAnimationView:(UIView *)view animationDuration:(NSTimeInterval)timer animationBlock:(QuitRentAnimationBlock)block
{
    
    [UIView animateWithDuration:timer animations:^{
        CGRect rect = view.frame;
        
        rect.size.width = Auto_Width(207)/2 + 4;
        rect.size.height = Auto_Width(274)/2 - 4;
        
        rect.origin.x = (KScreenWidth-Auto_Width(207)/2-Auto_Width(30)/2) - 2;
        
        CGFloat set_y = IS_IPhoneX_All ? (Auto_Height(582))/2 : (Auto_Height(626))/2;
        rect.origin.y = set_y + 4;
        
        view.frame = rect;
        
    } completion:^(BOOL finished) {
        if (finished) {
            block();
        }
    }];
    
}

+ (void)translationFeedBackAnimationView:(UIView *)view animationDuration:(NSTimeInterval)timer animationBlock:(QuitRentAnimationBlock)block
{
    CGFloat he_h = Auto_Width(10)/2;
    
    [UIView animateWithDuration:timer animations:^{
    
        CGRect rect = view.frame;
        rect.origin.y = view.frame.origin.y - he_h;
        view.frame = rect;
        
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:timer animations:^{
        
            CGAffineTransform rotation = CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(-35));

            view.transform = rotation;
        
        } completion:^(BOOL finished) {
        
            [UIView animateWithDuration:timer+0.2 animations:^{

                CGAffineTransform rotation = CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(35));

                view.transform = rotation;

            } completion:^(BOOL finished) {

                if (finished) {
                    block();
                }

            }];
        
        }];
        
    }];
    
}



@end
