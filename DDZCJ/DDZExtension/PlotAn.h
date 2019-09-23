//
//  PlotAn.h
//  DDZCJ
//
//  Created by jjj on 2019/9/19.
//  Copyright © 2019 df. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^ PlotAnBlock)(void);

@interface PlotAn : NSObject

+(PlotAn *)initClient;

-(void)SetAninView:(UIView *)view;

-(void)translationFeedBackAnimationView:(UIView *)view animationDuration:(NSTimeInterval)timer animationBlock:(PlotAnBlock)block;

@end

NS_ASSUME_NONNULL_END
