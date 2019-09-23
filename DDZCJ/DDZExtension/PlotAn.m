//
//  PlotAn.m
//  DDZCJ
//
//  Created by jjj on 2019/9/19.
//  Copyright © 2019 df. All rights reserved.
//

#import "PlotAn.h"

#define duAng 25
#define duration_s 0.4

@interface PlotAn ()<CAAnimationDelegate>

@property (nonatomic , weak) UIImageView *imgV;



@end

@implementation PlotAn

+(PlotAn *)initClient
{
    static PlotAn *client = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        client = [[PlotAn alloc] init];
        [client initCustom];
        
    });
    
    return client;
}

-(void)initCustom
{
    
}

-(void)SetAninView:(UIView *)view
{
    _imgV = (UIImageView *)view;
    [self an1];
    
    
//    CAAnimationGroup *aniGroup = [CAAnimationGroup animation];
//    aniGroup.duration = 1;
//    aniGroup.animations = @[animation,animation2,animation3];
//    aniGroup.repeatCount = CGFLOAT_MAX;
//    [view.layer addAnimation:aniGroup forKey:@"grouani"];
}



-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if ([_imgV.layer animationForKey:@"move-up-layer"] == anim) {
        [self an2];
    }else if ([_imgV.layer animationForKey:@"rotation2"] == anim) {
        [self an3];
    }else if ([_imgV.layer animationForKey:@"rotation3"] == anim) {
        [self an4];
    }else if ([_imgV.layer animationForKey:@"rotation4"] == anim) {
        [self an5];
    }else if ([_imgV.layer animationForKey:@"move-down-layer"] == anim) {
        [self an1];
    }
}

-(void)an1
{
    CGFloat he_h = Auto_Width(10)/2;
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
    animation.delegate = self;
    animation.fromValue = [NSValue valueWithCGPoint:_imgV.layer.position]; // 起始帧
    animation.toValue = [NSValue valueWithCGPoint:CGPointMake(_imgV.layer.position.x, _imgV.layer.position.y - he_h)]; // 终了帧
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]; // 动画效果慢进慢出
    animation.duration = duration_s; //动画持续时间
    animation.fillMode = kCAFillModeForwards;
    //        circleAnimation.autoreverses = YES;
    animation.removedOnCompletion = NO; //动画后是否回到最初状态（配合kCAFillModeForwards使用）
    animation.repeatCount = 1; //如果这里想设置成一直自旋转，可以设置为MAXFLOAT，否则设置具体的数值则代表执行多少次
    [_imgV.layer addAnimation:animation forKey:@"move-up-layer"];
}

-(void)an2
{
    CABasicAnimation *animation2 = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation2.delegate = self;
    animation2.fromValue = [NSNumber numberWithFloat:0.f];
    //        circleAnimation.byValue = [NSNumber numberWithFloat: DEGREES_TO_RADIANS(-35)];
    animation2.toValue = [NSNumber numberWithFloat: DEGREES_TO_RADIANS(-duAng)];
    animation2.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]; // 动画效果慢进慢出
    animation2.duration = duration_s; //动画持续时间
    animation2.fillMode = kCAFillModeForwards;
    //        circleAnimation.autoreverses = YES;
    animation2.removedOnCompletion = NO; //动画后是否回到最初状态（配合kCAFillModeForwards使用）
    animation2.repeatCount = 1; //如果这里想设置成一直自旋转，可以设置为MAXFLOAT，否则设置具体的数值则代表执行多少次
    [_imgV.layer addAnimation:animation2 forKey:@"rotation2"];
}

-(void)an3
{
    CABasicAnimation *animation3 = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation3.delegate = self;
    animation3.fromValue = [NSNumber numberWithFloat: DEGREES_TO_RADIANS(-duAng)];
    animation3.toValue = [NSNumber numberWithFloat: DEGREES_TO_RADIANS(duAng)];
    animation3.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]; // 动画效果慢进慢出
    animation3.duration = duration_s; //动画持续时间
    animation3.fillMode = kCAFillModeForwards;
    //        circleAnimation.autoreverses = YES;
    animation3.removedOnCompletion = NO; //动画后是否回到最初状态（配合kCAFillModeForwards使用）
    animation3.repeatCount = 1; //如果这里想设置成一直自旋转，可以设置为MAXFLOAT，否则设置具体的数值则代表执行多少次
    [_imgV.layer addAnimation:animation3 forKey:@"rotation3"];
}

-(void)an4
{
    CABasicAnimation *animation4 = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation4.delegate = self;
    animation4.fromValue = [NSNumber numberWithFloat: DEGREES_TO_RADIANS(duAng)];
    animation4.toValue = [NSNumber numberWithFloat: 0.f];
    animation4.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]; // 动画效果慢进慢出
    animation4.duration = duration_s; //动画持续时间
    animation4.fillMode = kCAFillModeForwards;
    //        circleAnimation.autoreverses = YES;
    animation4.removedOnCompletion = NO; //动画后是否回到最初状态（配合kCAFillModeForwards使用）
    animation4.repeatCount = 1; //如果这里想设置成一直自旋转，可以设置为MAXFLOAT，否则设置具体的数值则代表执行多少次
    [_imgV.layer addAnimation:animation4 forKey:@"rotation4"];
}

-(void)an5
{
    CGFloat he_h = Auto_Width(10)/2;
    
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
    animation.delegate = self;
    animation.fromValue = [NSValue valueWithCGPoint:CGPointMake(_imgV.layer.position.x, _imgV.layer.position.y - he_h)]; // 起始帧
    animation.toValue = [NSValue valueWithCGPoint:CGPointMake(_imgV.layer.position.x, _imgV.layer.position.y)]; // 终了帧
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]; // 动画效果慢进慢出
    animation.duration = duration_s; //动画持续时间
    animation.fillMode = kCAFillModeForwards;
    //        circleAnimation.autoreverses = YES;
    animation.removedOnCompletion = NO; //动画后是否回到最初状态（配合kCAFillModeForwards使用）
    animation.repeatCount = 1; //如果这里想设置成一直自旋转，可以设置为MAXFLOAT，否则设置具体的数值则代表执行多少次
    [_imgV.layer addAnimation:animation forKey:@"move-down-layer"];
}


-(void)translationFeedBackAnimationView:(UIView *)view animationDuration:(NSTimeInterval)timer animationBlock:(PlotAnBlock)block
{
    _imgV = (UIImageView *)view;
    
//    CABasicAnimation *animation1 = [CABasicAnimation animationWithKeyPath:@"position"];
//    animation1.duration = 2;
//    animation1.repeatCount = 2;
//    animation1.beginTime = CACurrentMediaTime() + 1;// 1秒后执行
//
//    animation1.fromValue = [NSValue valueWithCGPoint:myView.layer.position]; // 起始帧
//
//    animation1.toValue = [NSValue valueWithCGPoint:CGPointMake(300, 300)]; // 终了帧
//
//    [View.layer addAnimation:animation1 forKey:@"move-layer"];
//
//    CGFloat he_h = Auto_Width(10)/2;
//
//    [UIView animateWithDuration:timer animations:^{
//
//        CGRect rect = view.frame;
//        rect.origin.y = view.frame.origin.y - he_h;
//        view.frame = rect;
//
//    } completion:^(BOOL finished) {
    
        //        [UIView animateWithDuration:timer animations:^{
        
        CABasicAnimation *circleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        circleAnimation.delegate = self;
        circleAnimation.fromValue = [NSNumber numberWithFloat:0.f];
//        circleAnimation.byValue = [NSNumber numberWithFloat: DEGREES_TO_RADIANS(-35)];
        circleAnimation.toValue = [NSNumber numberWithFloat: DEGREES_TO_RADIANS(-duAng)];
        circleAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]; // 动画效果慢进慢出
        circleAnimation.duration = 0.8; //动画持续时间
        circleAnimation.fillMode = kCAFillModeForwards;
//        circleAnimation.autoreverses = YES;
        circleAnimation.removedOnCompletion = NO; //动画后是否回到最初状态（配合kCAFillModeForwards使用）
        circleAnimation.repeatCount = 1; //如果这里想设置成一直自旋转，可以设置为MAXFLOAT，否则设置具体的数值则代表执行多少次
        [view.layer addAnimation:circleAnimation forKey:@"rotation"];
        
        //            CGAffineTransform rotation = CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(-35));
        //
        //            view.transform = rotation;
        
        //        } completion:^(BOOL finished) {
        
        //            [UIView animateWithDuration:timer+0.2 animations:^{
        //
        //                CGAffineTransform rotation = CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(35));
        //
        //                view.transform = rotation;
        //
        //            } completion:^(BOOL finished) {
        //
        //                if (finished) {
        //                    block();
        //                }
        //
        //            }];
        
        //        }];
        
//    }];
    
}

//-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
//{
//    NSLog(@"stop .....");
//
//    CABasicAnimation *circleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
////    circleAnimation.delegate = self;
//    circleAnimation.fromValue = [NSNumber numberWithFloat: DEGREES_TO_RADIANS(-duAng)];
//    //        circleAnimation.byValue = [NSNumber numberWithFloat: DEGREES_TO_RADIANS(-35)];
//    circleAnimation.toValue = [NSNumber numberWithFloat: DEGREES_TO_RADIANS(duAng)];
//    circleAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]; // 动画效果慢进慢出
//    circleAnimation.duration = 0.8; //动画持续时间
//    circleAnimation.fillMode = kCAFillModeForwards;
//    circleAnimation.autoreverses = YES;
//    circleAnimation.removedOnCompletion = NO; //动画后是否回到最初状态（配合kCAFillModeForwards使用）
//    circleAnimation.repeatCount = MAXFLOAT; //如果这里想设置成一直自旋转，可以设置为MAXFLOAT，否则设置具体的数值则代表执行多少次
//    [_imgV.layer addAnimation:circleAnimation forKey:@"rotation"];
//
//}



@end
