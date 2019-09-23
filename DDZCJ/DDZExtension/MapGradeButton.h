//
//  MapGradeButton.h
//  DDZCJ
//
//  Created by jjj on 2019/9/13.
//  Copyright © 2019 df. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DDZMapModel;

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    GradeOne,
    GradeTwo,
    GradeThree,
    GradeFour,
    GradeFive,
    GradeSix,
} MAPGRADELEVEL;


@interface MapGradeButton : UIButton

@property (nonatomic, assign) MAPGRADELEVEL mapGrade;//考生级别

@property (nonatomic, assign) BOOL isPassOrNot;//是否通关

@property (nonatomic, assign) BOOL isShowTitle;//是否显示title

@property (nonatomic, assign) BOOL isCurrentPosition;//是否当前关卡

-(void)setGradeModel:(DDZMapModel *)mapModel;

@end


NS_ASSUME_NONNULL_END
