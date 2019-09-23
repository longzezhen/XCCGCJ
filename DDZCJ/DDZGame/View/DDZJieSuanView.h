//
//  DDZJieSuanView.h
//  DDZCJ
//
//  Created by df on 2019/9/17.
//  Copyright © 2019 df. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DDZJieSuanView : UIView
@property (nonatomic,strong)UIView * shadowView;
@property (nonatomic,strong)UIImageView * juanChouImageView;
@property (nonatomic,strong)UIImageView * winAnimationImageView;
@property (nonatomic,strong)UIImageView * loseAnimationImageView;
@property (nonatomic,strong)UILabel * guanLabel;
@property (nonatomic,strong)UIButton * leftButton;
@property (nonatomic,strong)UIButton * rightButton;
@property (nonatomic,copy)void(^clickLeftButtonBlock)(void);
@property (nonatomic,copy)void(^clickRightButtonBlock)(void);
@end

NS_ASSUME_NONNULL_END
