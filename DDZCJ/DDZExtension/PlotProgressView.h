//
//  PlotProgressView.h
//  DDZCJ
//
//  Created by jjj on 2019/9/10.
//  Copyright © 2019 df. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PlotProgressView : UIView

@property (nonatomic, assign) CGFloat progress;
//进度条颜色
@property(nonatomic,strong) UIColor *progerssColor;
//进度条背景颜色
@property(nonatomic,strong) UIColor *progerssBackgroundColor;
//进度条边框的颜色
@property(nonatomic,strong) UIColor *progerssStokeBackgroundColor;
//进度条边框的宽度
@property(nonatomic,assign) CGFloat progerStokeWidth;

@end

NS_ASSUME_NONNULL_END
