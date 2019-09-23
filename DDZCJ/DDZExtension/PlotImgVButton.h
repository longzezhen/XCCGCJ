//
//  PlotImgVButton.h
//  DDZCJ
//
//  Created by jjj on 2019/9/10.
//  Copyright © 2019 df. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    GoToTown = 0,
    GoToReg,
    GoToChallenge,
} GOENUMVALUE;

NS_ASSUME_NONNULL_BEGIN

@interface PlotImgVButton : UIButton

@property (nonatomic,assign) GOENUMVALUE whereToGo;

@end

NS_ASSUME_NONNULL_END
