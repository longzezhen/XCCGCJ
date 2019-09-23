//
//  DDZJieSuanView.m
//  DDZCJ
//
//  Created by df on 2019/9/17.
//  Copyright © 2019 df. All rights reserved.
//

#import "DDZJieSuanView.h"
#import "DDZBackgroundMusic.h"
@implementation DDZJieSuanView

-(instancetype)init
{
    if (self = [super init]) {
        self.shadowView.hidden = NO;
        self.juanChouImageView.hidden = NO;
        self.winAnimationImageView.hidden = NO;
        self.guanLabel.hidden = NO;
        self.leftButton.hidden = NO;
        self.rightButton.hidden = NO;
    }
    return self;
}

#pragma mark - action
-(void)clickLeftButton
{
    if (![DDGET_CACHE(DDZ_SET_GameMusic) isEqualToString:@"GBYXYX"]){
        [[DDZBackgroundMusic shareBackgroundMusic] clickMusicPlay];
    }
    self.clickLeftButtonBlock();
}

-(void)clickRightButton
{
    if (![DDGET_CACHE(DDZ_SET_GameMusic) isEqualToString:@"GBYXYX"]){
        [[DDZBackgroundMusic shareBackgroundMusic] clickMusicPlay];
    }
    self.clickRightButtonBlock();
}

#pragma mark - get
-(UIView *)shadowView
{
    if (!_shadowView) {
        _shadowView = [[UIView alloc] init];
        _shadowView.backgroundColor = UIColorFromRGBA(0x000000, 0.5);
        [self addSubview:_shadowView];
        [_shadowView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
    }
    return _shadowView;
}

-(UIImageView *)juanChouImageView
{
    if (!_juanChouImageView) {
        _juanChouImageView = [[UIImageView alloc] initWithImage:DDImageName(@"juanchou_win")];
        [self addSubview:_juanChouImageView];
        [_juanChouImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(Auto_Width(-49/4));
            make.top.mas_equalTo(Auto_Height(250/2));
            make.size.mas_equalTo(CGSizeMake(Auto_Width(624/2), Auto_Width(331/2)));
        }];
    }
    return _juanChouImageView;
}

-(UIImageView *)winAnimationImageView
{
    if (!_winAnimationImageView) {
        NSArray * images = @[DDImageName(@"win_1"),DDImageName(@"win_2"),DDImageName(@"win_3"),DDImageName(@"win_4")];
        _winAnimationImageView = [UIImageView new];
        _winAnimationImageView.animationImages = images;
        _winAnimationImageView.animationDuration = 1;
        [_winAnimationImageView startAnimating];
        [self addSubview:_winAnimationImageView];
        [_winAnimationImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(self.juanChouImageView);
            make.size.mas_equalTo(CGSizeMake(KScreenWidth, Auto_Width(544/2)));
        }];
    }
    return _winAnimationImageView;
}

-(UIImageView *)loseAnimationImageView
{
    if (!_loseAnimationImageView) {
        NSArray * images = @[DDImageName(@"Luoye_1"),DDImageName(@"Luoye_2"),DDImageName(@"Luoye_3"),DDImageName(@"Luoye_4"),DDImageName(@"Luoye_5"),DDImageName(@"Luoye_6"),DDImageName(@"Luoye_7"),DDImageName(@"Luoye_8"),DDImageName(@"Luoye_9"),DDImageName(@"Luoye_10"),DDImageName(@"Luoye_11"),DDImageName(@"Luoye_12"),DDImageName(@"Luoye_13"),DDImageName(@"Luoye_14"),DDImageName(@"Luoye_15")];
        _loseAnimationImageView = [UIImageView new];
        _loseAnimationImageView.animationImages = images;
        _loseAnimationImageView.animationDuration = 3;
        [_loseAnimationImageView startAnimating];
        [self addSubview:_loseAnimationImageView];
        [_loseAnimationImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
    }
    return _loseAnimationImageView;
}

-(UILabel *)guanLabel
{
    if (!_guanLabel) {
        _guanLabel = [UILabel new];
        _guanLabel.text = @"第三關";
        _guanLabel.font = kFont(14);
        _guanLabel.textColor = UIColorFromRGB(0xa13122);
        [self addSubview:_guanLabel];
        [_guanLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(0);
            make.top.mas_equalTo(self.juanChouImageView).mas_equalTo(Auto_Width(104));
        }];
    }
    return _guanLabel;
}

-(UIButton *)leftButton
{
    if (!_leftButton) {
        _leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_leftButton setImage:DDImageName(@"Outexamination") forState:UIControlStateNormal];
        [_leftButton addTarget:self action:@selector(clickLeftButton) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_leftButton];
        [_leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.mas_centerX).mas_equalTo(Auto_Width(-23/2));
            make.bottom.mas_equalTo(Auto_Height(-346/2));
        }];
    }
    return _leftButton;
}

-(UIButton *)rightButton
{
    if (!_rightButton) {
        _rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_rightButton setImage:DDImageName(@"NextGuan") forState:UIControlStateNormal];
        [_rightButton addTarget:self action:@selector(clickRightButton) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_rightButton];
        [_rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_centerX).mas_equalTo(Auto_Width(23/2));
            make.bottom.mas_equalTo(Auto_Height(-346/2));
        }];
    }
    return _rightButton;
}

@end
