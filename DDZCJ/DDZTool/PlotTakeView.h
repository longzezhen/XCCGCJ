//
//  PlotTakeView.h
//  DDZCJ
//
//  Created by jjj on 2019/9/10.
//  Copyright © 2019 df. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol PlotTakeViewDelegate <NSObject>

-(void)goToChallenge;

@end

@interface PlotTakeView : UIView

@property (nonatomic, weak) id<PlotTakeViewDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
