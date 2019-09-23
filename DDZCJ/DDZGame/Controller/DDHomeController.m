//
//  DDHomeController.m
//  DDZCJ
//
//  Created by jjj on 2019/9/10.
//  Copyright © 2019 df. All rights reserved.
//

#import "DDHomeController.h"
#import "UILabel+Extension.h"
#import "PlotAnimationObject.h"
#import "DDPopupView.h"
#import "DDMapController.h"
#import "DDPopupGameSet.h"

#import "DDZPayManager.h"
#import "DDZUpdateView.h"

#import "PlotAn.h"

@interface DDHomeController ()
{
    BOOL isAnimation;
    NSInteger home_current_grade;
}
@property (nonatomic, strong) UIImageView *home_bg;

@property (nonatomic, strong) UIImageView *plotCloudImgV_1;
@property (nonatomic, strong) UIImageView *plotCloudImgV_2;

@property (nonatomic, strong) UIImageView *home_head_bg;
@property (nonatomic, strong) UIImageView *home_head;

@property (nonatomic, strong) UIImageView *home_name_bg;
@property (nonatomic, strong) UILabel *home_name;

@property (nonatomic, strong) UIImageView *home_money_bg;
@property (nonatomic, strong) UILabel *home_money;
@property (nonatomic, strong) UIButton *home_money_add;

@property (nonatomic, strong) UIImageView *home_sign_bg;
@property (nonatomic, strong) UILabel *home_sign;

@property (nonatomic, strong) UIImageView *home_grade;//考生等级
@property (nonatomic, strong) UIImageView *home_examiner;//考官

@property (nonatomic, strong) UIButton *home_game_set;
@property (nonatomic, strong) UIButton *home_btn_go;
@property (nonatomic, strong) UIButton *home_game_shop;
@property (nonatomic, strong) UIButton *home_feedback_1;
@property (nonatomic, strong) UIImageView *home_feedback_2;

@property (nonatomic, strong) UILabel *home_tips;
@property (nonatomic, strong) UIImageView *home_tips_1;
@property (nonatomic, strong) UIImageView *home_tips_2;
@property (nonatomic, strong) UIImageView *home_tips_3;

@property (nonatomic, strong) DDPopupView *popupView;



@end

@implementation DDHomeController

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

    [self cloudImageView_1Animation];
    [self cloudImageView_2Animation];
    
    [self kaoGuanImageView_Animation];
    [self gradeImageView_Animation];
    
    [self EmailImageView_Animation];

    if (DDGET_CACHE(DDZ_CURRENT_GRADE)) {
        if (home_current_grade != [DDGET_CACHE(DDZ_CURRENT_GRADE) integerValue]) {
            if (home_current_grade < [DDGET_CACHE(DDZ_CURRENT_GRADE) integerValue]) {
                home_current_grade = [DDGET_CACHE(DDZ_CURRENT_GRADE) integerValue];
                [DDZUpdateView showUpdateAnimation:2.6 gradeNum:home_current_grade];
            }
            
        }
    }
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.home_money.text = DDGET_CACHE(DDZ_USER_MONEY);
    
    
    if (DDGET_CACHE(DDZ_CURRENT_GRADE)) {
        NSString *currentGradeStr = [NSString stringWithFormat:@"home_grade_%@",DDGET_CACHE(DDZ_CURRENT_GRADE)];
        [self.home_grade setImage:DDImageName(currentGradeStr)];
        
        NSArray *gradeNameArray = @[@"穷书生",@"秀才",@"举人",@"探花",@"榜眼",@"状元"];
        
        NSInteger cur_num = [DDGET_CACHE(DDZ_CURRENT_GRADE) integerValue];

        self.home_sign.verticalText = gradeNameArray[cur_num-1];
    }

    NSInteger currentNum = [DDGET_CACHE(DDZ_CURRENT_NUMBER) integerValue];
    
    NSArray *numA = @[@"4",@"7",@"10",@"13",@"17",@"20"];
    
    if (currentNum >= 17) {
        self.home_tips_1.hidden = YES;
        self.home_tips_2.hidden = YES;
        self.home_tips_3.hidden = YES;
    }else{
        
        for (int i = 0; i < numA.count; i++) {
            NSInteger num_a = [numA[i] integerValue];
            
            if (currentNum < num_a) {
                NSString *cu_str = [NSString stringWithFormat:@"home_num_%ld",num_a - currentNum];
                [self.home_tips_2 setImage:DDImageName(cu_str)];
                break;
            }

        }
        
    }
    
}
-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];

    [self stopAnimation];
}

-(void)refreshAnimation
{
    [self cloudImageView_1Animation];
    [self cloudImageView_2Animation];

    [self kaoGuanImageView_Animation];
    [self gradeImageView_Animation];
    
    [self EmailImageView_Animation];
}

-(void)stopAnimation
{
    
    [self.home_grade.layer removeAllAnimations];
    [self.home_examiner.layer removeAllAnimations];
    
    [self.home_feedback_2.layer removeAllAnimations];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [DDZN_C addObserver:self selector:@selector(refreshAnimation) name:@"refreshAnimation" object:nil];
    [DDZN_C addObserver:self selector:@selector(stopAnimation) name:@"stopAnimation" object:nil];
    
    self.view.backgroundColor = [UIColor whiteColor];
    isAnimation = NO;
    home_current_grade = [DDGET_CACHE(DDZ_CURRENT_GRADE) integerValue];
    if (home_current_grade == 0) {
        home_current_grade = 1;
    }
    
    [self initUI];
    [self initData];
    [self initMans];
    
//    for (NSString *fontfamilyname in [UIFont familyNames])
//    {
//        NSLog(@"family:'%@'",fontfamilyname);
//        for(NSString *fontName in [UIFont fontNamesForFamilyName:fontfamilyname])
//        {
//            NSLog(@"\tfont:'%@'",fontName);
//        }
//        NSLog(@"-------------");
//    }
}

-(void)initUI
{
    [self.view addSubview:self.home_bg];
    
    [self.view addSubview:self.plotCloudImgV_1];
    [self.view addSubview:self.plotCloudImgV_2];
    
    [self.view addSubview:self.home_head_bg];
    [self.view insertSubview:self.home_head belowSubview:self.home_head_bg];
    
    [self.view addSubview:self.home_name_bg];
    [self.view addSubview:self.home_name];
    
    [self.view addSubview:self.home_money_bg];
    [self.view addSubview:self.home_money];
    [self.view addSubview:self.home_money_add];
    
    [self.view addSubview:self.home_sign_bg];
    [self.view addSubview:self.home_sign];
    [self.view addSubview:self.home_examiner];
    [self.view addSubview:self.home_grade];
    
    [self.view addSubview:self.home_game_set];
    [self.view addSubview:self.home_btn_go];
    [self.view addSubview:self.home_tips];
    [self.view addSubview:self.home_game_shop];
    [self.view addSubview:self.home_feedback_1];
    [self.view addSubview:self.home_feedback_2];
    
    [self.view addSubview:self.home_tips_2];
    [self.view addSubview:self.home_tips_1];
    [self.view addSubview:self.home_tips_3];
    
    
    
}

-(void)initData
{
//    [self cloudImageView_1Animation];
//    [self cloudImageView_2Animation];
//
//    [self kaoGuanImageView_Animation];
//    [self gradeImageView_Animation];
    
//    [self EmailImageView_Animation];
}

-(void)initMans
{
    CGFloat set_y = IS_IPhoneX_All ? Auto_Height(100) : Auto_Height(80);
    [self.home_tips_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(-(Auto_Width(118)/2 + set_y/2));
        make.left.mas_equalTo(Auto_Width(322)/2);
        make.size.mas_equalTo(CGSizeMake(Auto_Width(30)/2, Auto_Width(41)/2));
    }];
    
    [self.home_tips_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.home_tips_2);
        make.right.mas_equalTo(self.home_tips_2.mas_left);
        make.size.mas_equalTo(CGSizeMake(Auto_Width(88)/2, Auto_Width(48)/2));
    }];
    
    [self.home_tips_3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.home_tips_2);
        make.left.mas_equalTo(self.home_tips_2.mas_right);
        make.size.mas_equalTo(CGSizeMake(Auto_Width(170)/2, Auto_Width(48)/2));
    }];
}


//云彩1平移动画
- (void)cloudImageView_1Animation
{
    [PlotAnimationObject translationAnimationView:self.plotCloudImgV_1 animationDuration:50 animationBlock:^{
        CGRect rect = self.plotCloudImgV_1.frame;
        rect.origin.x = -(Auto_Width(124)/2);
        self.plotCloudImgV_1.frame = rect;
        
        [self cloudImageView_1Animation];
    }];
}

//云彩2平移动画
- (void)cloudImageView_2Animation
{
    [PlotAnimationObject translationAnimationView:self.plotCloudImgV_2 animationDuration:45 animationBlock:^{
        CGRect rect = self.plotCloudImgV_2.frame;
        rect.origin.x = -(Auto_Width(159)/2);
        self.plotCloudImgV_2.frame = rect;
        
        [self cloudImageView_2Animation];
    }];
}

// 考生
- (void)gradeImageView_Animation
{
    [PlotAnimationObject translationGradeAnimationView:self.home_grade animationDuration:2 animationBlock:^{
        
        [UIView animateWithDuration:2 animations:^{
            CGRect rect = self.home_grade.frame;
            
            rect.size.width = Auto_Width(257)/2;
            rect.size.height = Auto_Width(416)/2;
            
            rect.origin.x = (KScreenWidth-Auto_Width(257)/2)/2;
            CGFloat set_y = IS_IPhoneX_All ? Auto_Height(672) : Auto_Height(652);
            rect.origin.y = set_y/2;
            
            self.home_grade.frame = rect;
            
        } completion:^(BOOL finished) {
            if (finished) {
                [self gradeImageView_Animation];
            }
        }];
        
    }];
}

// 考官
- (void)kaoGuanImageView_Animation
{
    [PlotAnimationObject translationKaoGuanAnimationView:self.home_examiner animationDuration:1.5 animationBlock:^{

        [UIView animateWithDuration:2 animations:^{
            CGRect rect = self.home_examiner.frame;

            rect.size.width = Auto_Width(207)/2;
            rect.size.height = Auto_Width(274)/2;

            rect.origin.x = (KScreenWidth-Auto_Width(207)/2-Auto_Width(30)/2);
            rect.origin.y = IS_IPhoneX_All?Auto_Height(582)/2:Auto_Height(626)/2;

            self.home_examiner.frame = rect;

        } completion:^(BOOL finished) {
            if (finished) {
                [self kaoGuanImageView_Animation];
            }
        }];

    }];
}

//邮箱
-(void)EmailImageView_Animation
{
//    [[PlotAn initClient] translationFeedBackAnimationView:self.home_feedback_2 animationDuration:0.8 animationBlock:^{
//
//    }];
    [self.home_feedback_2.layer removeAllAnimations];
    [[PlotAn initClient] SetAninView:self.home_feedback_2];
    
//    [PlotAnimationObject translationFeedBackAnimationView:self.home_feedback_2 animationDuration:0.8 animationBlock:^{
//
//        [UIView animateWithDuration:0.8 animations:^{
//
//            CGAffineTransform rotation = CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(0));
//
//            self.home_feedback_2.transform = rotation;
//
//        } completion:^(BOOL finished) {
//
//            [UIView animateWithDuration:0.8 animations:^{
//
//                CGFloat he_h = Auto_Width(10)/2;
//
//                CGRect rect = self.home_feedback_2.frame;
//                rect.origin.y = self.home_feedback_2.frame.origin.y + he_h;
//                self.home_feedback_2.frame = rect;
//
//            } completion:^(BOOL finished) {
//                [self EmailImageView_Animation];
//            }];
//        }];
//
//    }];
}

#pragma mark - 去闯关
-(void)btnGoClick
{

    [[MusicPlayObj initClient] playBgMusic];
    
//    NSLog(@"去闯关。。。。。。");
    if (DDGET_CACHE(DDZ_CURRENT_GRADE)) {
        home_current_grade = [DDGET_CACHE(DDZ_CURRENT_GRADE) integerValue];
    }

    DDMapController *mapCon = [[DDMapController alloc] init];
    [self presentViewController:mapCon animated:YES completion:nil];
    
}
#pragma mark - 游戏设置
-(void)gameSetClick
{
    [[MusicPlayObj initClient] playBgMusic];
    [[DDPopupGameSet initClient] showGameSetViewBlock:^{
        DDWeakSelf
        [self.popupView addXieyiWithBlock:^(BOOL isSuc) {
            weakSelf.popupView = nil;
            
        }];
        
    }];
}
#pragma mark - 游戏商店
-(void)gameShopClick
{
    [[MusicPlayObj initClient] playBgMusic];
    DDWeakSelf
    [self.popupView addGameShopWithBlock:^(NSString * _Nonnull moneyStr) {
        NSLog(@"--充值：%@",moneyStr);
        if ([moneyStr isEqualToString:@"8"]) {
            [MBProgressHUD showHUDAddedTo:weakSelf.view animated:YES];
            
            [[DDZPayManager sharedPayManager] requestAppleStoreProductDataWithString:@"com.xccg.clever_6_v1" payComplete:^(NSDictionary * _Nonnull resultDic, BOOL isSuccess) {
                
                [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
                
                if (isSuccess) {
                    NSString *currentMoney = DDGET_CACHE(DDZ_USER_MONEY);
                    currentMoney = [NSString stringWithFormat:@"%ld",[currentMoney integerValue]+[Chong_Money integerValue]];
                    
                    DDSET_CACHE(currentMoney, DDZ_USER_MONEY);
                    
                    weakSelf.home_money.text = DDGET_CACHE(DDZ_USER_MONEY);
                }
                
            }];
            
            
        }else{
            weakSelf.popupView = nil;
        }
    }];
}

#pragma mark - 游戏反馈
-(void)feedbackClick
{
    [[MusicPlayObj initClient] playBgMusic];
    DDWeakSelf
    [self.popupView addFeedBackViewBlock:^(BOOL isSuc) {
        weakSelf.popupView = nil;
    }];
}
#pragma mark - 充钱
-(void)addMoney
{
    NSLog(@"充钱。。。。");
    [self gameShopClick];
}

#pragma mark - lazy
-(UIImageView *)home_bg
{
    if (!_home_bg) {
        _home_bg = [[UIImageView alloc] initWithFrame:self.view.bounds];
        [_home_bg setImage:DDImageName(@"home_bg")];
    }
    return _home_bg;
}

// 云朵
-(UIImageView *)plotCloudImgV_1
{
    if (!_plotCloudImgV_1) {
        _plotCloudImgV_1 = [[UIImageView alloc] initWithFrame:CGRectMake(-Auto_Width(159)/2, Auto_Height(72)/2, Auto_Width(159)/2, Auto_Height(33)/2)];
        [_plotCloudImgV_1 setImage:DDImageName(@"plot_cloud_2")];
    }
    return _plotCloudImgV_1;
}

-(UIImageView *)plotCloudImgV_2
{
    if (!_plotCloudImgV_2) {
        _plotCloudImgV_2 = [[UIImageView alloc] initWithFrame:CGRectMake(-Auto_Width(93)/2, Auto_Height(138)/2, Auto_Width(93)/2, Auto_Height(20)/2)];
        [_plotCloudImgV_2 setImage:DDImageName(@"plot_cloud_3")];
    }
    return _plotCloudImgV_2;
}

-(UIImageView *)home_head_bg
{
    if (!_home_head_bg) {
        _home_head_bg = [[UIImageView alloc] initWithFrame:CGRectMake(Auto_Width(32)/2, DDNavigation_TopHeight+Auto_Height(32)/2, Auto_Width(98)/2, Auto_Width(98)/2)];
        [_home_head_bg setImage:DDImageName(@"home_head")];
    }
    return _home_head_bg;
}

-(UIImageView *)home_head
{
    if (!_home_head) {
        _home_head = [[UIImageView alloc] initWithFrame:CGRectMake(DDMidX(self.home_head_bg)-(Auto_Width(79)/2/2), DDMidY(self.home_head_bg)-(Auto_Width(79)/2/2), Auto_Width(79)/2, Auto_Width(79)/2)];
        [_home_head setImage:DDImageName(@"ddz_head")];
//        _home_head.layer.cornerRadius = 10;
//        _home_head.layer.masksToBounds = YES;
//        _home_head.backgroundColor = [UIColor redColor];
    }
    return _home_head;
}

-(UIImageView *)home_name_bg
{
    if (!_home_name_bg) {
        _home_name_bg = [[UIImageView alloc] initWithFrame:CGRectMake(DDMaxX(self.home_head_bg)+Auto_Width(20)/2, DDMidY(self.home_head_bg)-(Auto_Width(62)/2)/2, Auto_Width(249)/2, Auto_Width(62)/2)];
        [_home_name_bg setImage:DDImageName(@"home_name")];
    }
    return _home_name_bg;
}

-(UILabel *)home_name
{
    if (!_home_name) {
        _home_name = [[UILabel alloc] initWithFrame:CGRectMake(DDMinX(self.home_name_bg)+Auto_Width(28)/2, DDMidY(self.home_name_bg)-Auto_Width(31)/2/2, DDWidth(self.home_name_bg)-Auto_Width(56)/2, Auto_Width(31)/2)];
        _home_name.font = IS_IPAD ? FZY3FWGB(26) : FZY3FWGB(16);
        _home_name.textColor = UIColorFromRGB(0x3d3d3d);
        _home_name.text = DDGET_CACHE(DDZ_USER_NAME);
    }
    return _home_name;
}

-(UIImageView *)home_money_bg
{
    if (!_home_money_bg) {
        _home_money_bg = [[UIImageView alloc] initWithFrame:CGRectMake(DDMaxX(self.home_name_bg)+Auto_Width(10)/2, DDMinY(self.home_name_bg), Auto_Width(249)/2, Auto_Width(62)/2)];
        [_home_money_bg setImage:DDImageName(@"home_money_bg")];
    }
    return _home_money_bg;
}

-(UILabel *)home_money
{
    if (!_home_money) {
        _home_money = [[UILabel alloc] initWithFrame:CGRectMake(DDMinX(self.home_money_bg)+Auto_Width(90)/2, DDMidY(self.home_money_bg)-Auto_Width(46)/2/2, Auto_Width(95)/2, Auto_Width(46)/2)];
        _home_money.font = IS_IPAD ? FZY3FWGB(26) : FZY3FWGB(16);
        _home_money.textColor = UIColorFromRGB(0x3d3d3d);
        
    }
    return _home_money;
}

-(UIButton *)home_money_add
{
    if (!_home_money_add) {
        _home_money_add = [[UIButton alloc] initWithFrame:CGRectMake(DDMaxX(self.home_money_bg)-Auto_Width(8)/2-Auto_Width(46)/2, DDMidY(self.home_money_bg)-Auto_Width(46)/2/2, Auto_Width(46)/2, Auto_Width(46)/2)];
//        [_home_money_add setImage:DDImageName(@"home_money_add") forState:0];
        [_home_money_add setBackgroundImage:DDImageName(@"home_money_add") forState:0];
        [_home_money_add addTarget:self action:@selector(addMoney) forControlEvents:UIControlEventTouchUpInside];
    }
    return _home_money_add;
}

-(UIImageView *)home_grade
{
    if (!_home_grade) {
        CGFloat set_y = IS_IPhoneX_All ? Auto_Height(672) : Auto_Height(652);
        _home_grade = [[UIImageView alloc] initWithFrame:CGRectMake((KScreenWidth-Auto_Width(257)/2)/2, set_y/2, Auto_Width(257)/2, Auto_Width(416)/2)];
        [_home_grade setImage:DDImageName(@"home_grade_1")];
    }
    return _home_grade;
}

-(UIImageView *)home_examiner
{
    if (!_home_examiner) {
        _home_examiner = [[UIImageView alloc] initWithFrame:CGRectMake(KScreenWidth-Auto_Width(207)/2-Auto_Width(30)/2, IS_IPhoneX_All?Auto_Height(582)/2:Auto_Height(626)/2, Auto_Width(207)/2, Auto_Width(274)/2)];
        [_home_examiner setImage:DDImageName(@"home_examiner")];
    }
    return _home_examiner;
}

-(UIImageView *)home_sign_bg
{
    if (!_home_sign_bg) {
        _home_sign_bg = [[UIImageView alloc] initWithFrame:CGRectMake(Auto_Width(180)/2, Auto_Height(680)/2, Auto_Width(56)/2, Auto_Width(172)/2)];
        [_home_sign_bg setImage:DDImageName(@"home_sign")];
    }
    return _home_sign_bg;
}

-(UILabel *)home_sign
{
    if (!_home_sign) {
        CGFloat setX_y = IS_IPhoneX_All ? Auto_Height(36) : Auto_Height(42);
        _home_sign = [[UILabel alloc] initWithFrame:CGRectMake(DDMidX(self.home_sign_bg)-(IS_IPAD ? 22 : 12)/2, DDMinY(self.home_sign_bg)+(IS_IPAD ? Auto_Height(62) : setX_y)/2, IS_IPAD ? 22:12, Auto_Width(82)/2)];
        _home_sign.font = IS_IPAD ? FZY4FWGB(22) : FZY4FWGB(12);
//        _home_sign.backgroundColor = [UIColor redColor];
        _home_sign.textColor = UIColorFromRGB(0xfff8e9);
//        _home_sign.font = [UIFont fontWithName:@"Helvetica-Bold" size:12];
        _home_sign.verticalText = @"穷书生";
//        _home_sign.text = @"穷";
        [_home_sign sizeToFit];
        
    }
    return _home_sign;
}

-(UIButton *)home_game_set
{
    if (!_home_game_set) {
        CGFloat set_y = IS_IPhoneX_All ? Auto_Height(54) : Auto_Height(34);
        _home_game_set = [[UIButton alloc] initWithFrame:CGRectMake(Auto_Width(26)/2, KScreenHeight-set_y/2-Auto_Width(124)/2, Auto_Width(110)/2, Auto_Width(124)/2)];
        [_home_game_set setAdjustsImageWhenHighlighted:NO];
        [_home_game_set setBackgroundImage:DDImageName(@"home_game_set") forState:0];
        [_home_game_set addTarget:self action:@selector(gameSetClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _home_game_set;
}

-(UIButton *)home_btn_go
{
    if (!_home_btn_go) {
        CGFloat set_y = IS_IPhoneX_All ? Auto_Height(60) : Auto_Height(40);
        _home_btn_go = [[UIButton alloc] initWithFrame:CGRectMake((KScreenWidth-Auto_Width(332)/2)/2, KScreenHeight-set_y/2-Auto_Width(118)/2, Auto_Width(332)/2, Auto_Width(118)/2)];
        [_home_btn_go setBackgroundImage:DDImageName(@"home_btn_go") forState:0];
        [_home_btn_go setAdjustsImageWhenHighlighted:NO];
        [_home_btn_go addTarget:self action:@selector(btnGoClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _home_btn_go;
}

//-(UILabel *)home_tips
//{
//    if (!_home_tips) {
//        _home_tips = [[UILabel alloc] initWithFrame:CGRectMake(DDMaxX(self.home_feedback_1), DDMinY(self.home_btn_go)-Auto_Height(40)/2-Auto_Height(45)/2, KScreenWidth-(DDMaxX(self.home_feedback_1)*2), Auto_Height(45)/2)];
//        _home_tips.font = FZY3FWGB(22);
//        _home_tips.textColor = [UIColor whiteColor];
//        _home_tips.textAlignment = NSTextAlignmentCenter;
//        _home_tips.text = @"还差5关可升官";
//    }
//    return _home_tips;
//}

-(UIImageView *)home_tips_2
{
    if (!_home_tips_2) {
        _home_tips_2 = [[UIImageView alloc] init];
        [_home_tips_2 setImage:DDImageName(@"home_num_3")];
    }
    return _home_tips_2;
}

-(UIImageView *)home_tips_1
{
    if (!_home_tips_1) {
        _home_tips_1 = [[UIImageView alloc] init];
        [_home_tips_1 setImage:DDImageName(@"home_pass_1")];
    }
    return _home_tips_1;
}

-(UIImageView *)home_tips_3
{
    if (!_home_tips_3) {
        _home_tips_3 = [[UIImageView alloc] init];
        [_home_tips_3 setImage:DDImageName(@"home_pass_2")];
    }
    return _home_tips_3;
}



-(UIButton *)home_game_shop
{
    if (!_home_game_shop) {
        CGFloat set_y = IS_IPhoneX_All ? Auto_Height(54) : Auto_Height(34);
        _home_game_shop = [[UIButton alloc] initWithFrame:CGRectMake(KScreenWidth-Auto_Width(110)/2-Auto_Width(26)/2, KScreenHeight-set_y/2-Auto_Width(124)/2, Auto_Width(110)/2, Auto_Width(124)/2)];
        [_home_game_shop setBackgroundImage:DDImageName(@"home_game_shop") forState:0];
        [_home_game_shop setAdjustsImageWhenHighlighted:NO];
        [_home_game_shop addTarget:self action:@selector(gameShopClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _home_game_shop;
}

-(UIButton *)home_feedback_1
{
    if (!_home_feedback_1) {
        _home_feedback_1 = [[UIButton alloc] initWithFrame:CGRectMake(Auto_Width(26)/2, DDMinY(self.home_game_set)-Auto_Height(30)/2-Auto_Width(124)/2, Auto_Width(110)/2, Auto_Width(124)/2)];
        [_home_feedback_1 setBackgroundImage:DDImageName(@"home_feedback_1") forState:0];
        [_home_feedback_1 setAdjustsImageWhenHighlighted:NO];
        [_home_feedback_1 addTarget:self action:@selector(feedbackClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _home_feedback_1;
}

-(UIImageView *)home_feedback_2
{
    if (!_home_feedback_2) {
        _home_feedback_2 = [[UIImageView alloc] initWithFrame:CGRectMake(DDMidX(self.home_feedback_1)-Auto_Width(53)/2/2,DDMinY(self.home_feedback_1)+(IS_IPAD?Auto_Height(29):Auto_Height(19))/2, Auto_Width(53)/2, Auto_Width(41)/2)];
        [_home_feedback_2 setImage:DDImageName(@"home_feedback_2")];
//        [self.view addSubview:_home_feedback_2];
    }
    return _home_feedback_2;
}

-(DDPopupView *)popupView
{
    if (!_popupView) {
        _popupView = [[DDPopupView alloc] initWithFrame:self.view.bounds];
        [self.view addSubview:_popupView];
    }
    return _popupView;
}

@end
