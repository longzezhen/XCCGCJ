//
//  DDMapController.m
//  DDZCJ
//
//  Created by jjj on 2019/9/12.
//  Copyright © 2019 df. All rights reserved.
//

#import "DDMapController.h"
#import "MapGradeButton.h"
#import "DDZMapModel.h"
#import "GameViewController.h"
#import "DDZBackgroundMusic.h"
#import "DDPopupView.h"

@interface DDMapController ()<UIScrollViewDelegate>
{
    NSUInteger currentNum;
}
@property (nonatomic, strong) UIScrollView *mapBgScrollView;
@property (nonatomic, strong) UIImageView *mapBgImgV;
@property (nonatomic, strong) UIButton *backBtn;

@property (nonatomic, strong) NSMutableArray *mapSoucreArrayM;

@property (nonatomic, strong) DDPopupView *popupView;

@property (nonatomic, strong) NSMutableArray *personArrayM;

@end

@implementation DDMapController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
//    [self initData];
    [self initUI];
//    [self initGradeImgV];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if (self.personArrayM.count > 0) {
        [self.personArrayM enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//            if ([obj isKindOfClass:[MapGradeButton class]]) {
                MapGradeButton *btn = (MapGradeButton *)obj;
                if (btn.isCurrentPosition) {
                    
                    CGPoint pp = [[self postionArray][idx] CGPointValue];
                    CGFloat cur_x = pp.x - KScreenWidth/2 + (Auto_Width(142)/2/2);
                    
//                    CGFloat fe = (cur_x + (KScreenWidth/2) + (Auto_Width(142)/2/2));
                    CGFloat ef = (Auto_Width(3000)/2) - (KScreenWidth);
                    
                    if (cur_x < 0) {
                        cur_x = 0.;
                    }else if (cur_x  > ef) {
                        cur_x = ef;
                    }
                    
                    [self.mapBgScrollView setContentOffset:CGPointMake(cur_x, 0) animated:YES];
                    
                }
                
                
//            }
        }];
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self initData];
    [self initGradeImgV];

    if ([DDGET_CACHE(DDZ_SET_BgMusic) isEqualToString:@"GBBJYY"]) {
        [[DDZBackgroundMusic shareBackgroundMusic] lobbyBackgroundMusicStop];
    }else{
        [[DDZBackgroundMusic shareBackgroundMusic] lobbyBackgroundMusicPlay];
    }
    
}


-(void)initUI
{
    [self.view addSubview:self.mapBgScrollView];
    [self.mapBgScrollView addSubview:self.mapBgImgV];
    
    [self.view addSubview:self.backBtn];
}

-(void)initData
{
    if (self.mapSoucreArrayM.count > 0) {
        [self.mapSoucreArrayM removeAllObjects];
    }

    currentNum = [DDGET_CACHE(DDZ_CURRENT_NUMBER) integerValue] ? : 0;
    
    for (int i = 0; i < 20; i++) {
        DDZMapModel *model = [[DDZMapModel alloc] init];
        if (i < 3) {
            model.mapGrade = 0;
        }else if ((i >= 3) && (i < 6)) {
            model.mapGrade = 1;
        }else if ((i >= 6) && (i < 9)) {
            model.mapGrade = 2;
        }else if ((i >= 9) && (i < 12)) {
            model.mapGrade = 3;
        }else if ((i >= 12) && (i < 16)) {
            model.mapGrade = 4;
        }else if (i >= 16) {
            model.mapGrade = 5;
        }
        
        model.isCurrentPosition = NO;
        
        if (i < currentNum) {
            model.isPassOrNot = YES;
        }else{
            model.isPassOrNot = NO;
        }
        if (i == currentNum) {
            model.isCurrentPosition = YES;
        }
        
        [self.mapSoucreArrayM addObject:model];
        
    }
}



-(void)initGradeImgV
{
    
    if (self.mapBgScrollView.subviews.count > 0) {
        [self.mapBgScrollView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj isKindOfClass:[MapGradeButton class]]) {
                [obj removeFromSuperview];
            }
        }];
    }
    
    if (self.personArrayM.count > 0) {
        [self.personArrayM removeAllObjects];
    }
    
    for (int i = 0; i < [self postionArray].count; i++) {
        
        CGPoint p = [[self postionArray][i] CGPointValue];
        
//        MapGradeButton *gradeBtn = [[MapGradeButton alloc] initWithFrame:CGRectMake(p.x, p.y, Auto_Width(142)/2, Auto_Width(160)/2)];
        MapGradeButton *gradeBtn = [[MapGradeButton alloc] init];
        [self.mapBgScrollView addSubview:gradeBtn];
        gradeBtn.tag = 10 + i;
        [gradeBtn addTarget:self action:@selector(gradeClick:) forControlEvents:UIControlEventTouchUpInside];
        [gradeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(p.x);
            make.top.mas_equalTo(p.y);
            make.size.mas_equalTo(CGSizeMake(Auto_Width(142)/2, Auto_Width(160)/2));
        }];
        [gradeBtn setGradeModel:self.mapSoucreArrayM[i]];
        gradeBtn.isShowTitle = NO;
        
        if (i == 0 || i == 3 || i == 6 || i == 9 || i == 12 || i == 16) {
            gradeBtn.isShowTitle = YES;
        }
        
        [self.personArrayM addObject:gradeBtn];
        
        
    }

}

#pragma mark - 点击事件
-(void)backClick
{
    [[MusicPlayObj initClient] playBgMusic];
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)gradeClick:(MapGradeButton *)btn
{

    [[MusicPlayObj initClient] playBgMusic];

    if ((btn.tag-10) <= currentNum) {
        DDWeakSelf
        
        NSInteger currentNum = btn.tag-10;
        NSInteger currentGrade = btn.mapGrade+1;
        
        if (btn.isPassOrNot) {
            
            [self.popupView addChallengeTipsText:@"已通過，本場將不消耗金額" block:^(BOOL isSuc) {
                
                weakSelf.popupView = nil;
                if (isSuc) {
                    [AppDelegate shareDelegate].paipuNumber = currentNum;
                    [AppDelegate shareDelegate].gradeNum = currentGrade;
                    
                    // 1. 从获取storyboard
                    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                    // 2. sb视图控制器
                    GameViewController * vc = [sb instantiateViewControllerWithIdentifier:@"game_vc"];
                    
                    [weakSelf presentViewController:vc animated:YES completion:nil];
                }
                
            }];
      
            return;
        }
        
        
        NSInteger cur_money = [DDGET_CACHE(DDZ_USER_MONEY) integerValue];
        
        if (cur_money < [Discount_Money integerValue]) {
            [MBProgressHUD showText:@"餘額不足請前往充值！" toView:self.view];
            return ;
        }
        
        
        [self.popupView challengeTipsWithGradeNum:currentNum+1 block:^(BOOL isSuc) {
            weakSelf.popupView = nil;
            if (isSuc) {
                NSInteger cur_moneyIn = [DDGET_CACHE(DDZ_USER_MONEY) integerValue];
                
                if (cur_moneyIn < [Discount_Money integerValue]) {
                    [MBProgressHUD showText:@"餘額不足請前往充值！" toView:weakSelf.view];
                    return ;
                }
                
                
                cur_moneyIn = cur_moneyIn - [Discount_Money integerValue];
                NSString *saveMoney = [NSString stringWithFormat:@"%ld",(long)cur_moneyIn];

                DDSET_CACHE(saveMoney, DDZ_USER_MONEY);
                
                [AppDelegate shareDelegate].paipuNumber = currentNum;
                [AppDelegate shareDelegate].gradeNum = currentGrade;
                // 1. 从获取storyboard
                UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                // 2. sb视图控制器
                GameViewController * vc = [sb instantiateViewControllerWithIdentifier:@"game_vc"];
                
                [weakSelf presentViewController:vc animated:YES completion:nil];
            }
        }];
        
    }else{
        [MBProgressHUD showText:@"先通關當前關卡" toView:self.view];
    }
}

#pragma mark - UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//    NSLog(@"移动的x:%f",scrollView.contentOffset.x);
}

#pragma mark - lazy
-(UIScrollView *)mapBgScrollView
{
    if (!_mapBgScrollView) {
        _mapBgScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight)];
        [_mapBgScrollView setContentSize:CGSizeMake(Auto_Width(3000)/2, KScreenHeight)];
        _mapBgScrollView.pagingEnabled = NO;
        _mapBgScrollView.delaysContentTouches = NO;
        _mapBgScrollView.delegate = self;
        [_mapBgScrollView setBounces:NO];
        _mapBgScrollView.showsHorizontalScrollIndicator = NO;
    }
    return _mapBgScrollView;
}

-(UIImageView *)mapBgImgV
{
    if (!_mapBgImgV) {
        _mapBgImgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, Auto_Width(3000)/2, KScreenHeight)];
        [_mapBgImgV setImage:DDImageName(@"map_bg")];
    }
    return _mapBgImgV;
}

-(UIButton *)backBtn
{
    if (!_backBtn) {
        _backBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, KScreenHeight-Auto_Height(60)/2-Auto_Width(98)/2, Auto_Width(152)/2, Auto_Width(98)/2)];
        [_backBtn setBackgroundImage:DDImageName(@"map_back") forState:0];
        [_backBtn addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backBtn;
}

-(NSMutableArray *)mapSoucreArrayM
{
    if (!_mapSoucreArrayM) {
        _mapSoucreArrayM = [NSMutableArray array];
    }
    return _mapSoucreArrayM;
}

-(DDPopupView *)popupView
{
    if (!_popupView) {
        _popupView = [[DDPopupView alloc] initWithFrame:self.view.bounds];
        [self.view addSubview:_popupView];
    }
    return _popupView;
}

-(NSMutableArray *)personArrayM
{
    if (!_personArrayM) {
        _personArrayM = [NSMutableArray array];
    }
    return _personArrayM;
}

#pragma mark - 人物位置x，y
-(NSArray *)postionArray
{
    CGPoint point = CGPointMake(Auto_Width(198)/2, Auto_Height(215)/2);
    NSValue *value = [NSValue valueWithCGPoint:point];
    
    CGPoint point2 = CGPointMake(Auto_Width(509)/2, Auto_Height(215)/2);
    NSValue *value2 = [NSValue valueWithCGPoint:point2];
    
    CGPoint point3 = CGPointMake(Auto_Width(497)/2, Auto_Height(490)/2);
    NSValue *value3 = [NSValue valueWithCGPoint:point3];
    
    CGPoint point4 = CGPointMake(Auto_Width(311)/2, Auto_Height(722)/2);
    NSValue *value4 = [NSValue valueWithCGPoint:point4];
    
    CGPoint point5 = CGPointMake(Auto_Width(554)/2, Auto_Height(1043)/2);
    NSValue *value5 = [NSValue valueWithCGPoint:point5];
    
    CGPoint point6 = CGPointMake(Auto_Width(997)/2, Auto_Height(1059)/2);
    NSValue *value6 = [NSValue valueWithCGPoint:point6];
    
    CGPoint point7 = CGPointMake(IS_IPhoneX_All?Auto_Width(1152)/2:Auto_Width(1166)/2, Auto_Height(793)/2);
    NSValue *value7 = [NSValue valueWithCGPoint:point7];
    
    CGPoint point8 = CGPointMake(Auto_Width(1045)/2, Auto_Height(478)/2);
    NSValue *value8 = [NSValue valueWithCGPoint:point8];
    
    CGPoint point9 = CGPointMake(Auto_Width(1269)/2, Auto_Height(288)/2);
    NSValue *value9 = [NSValue valueWithCGPoint:point9];
    
    CGPoint point10 = CGPointMake(Auto_Width(952)/2, Auto_Height(153)/2);
    NSValue *value10 = [NSValue valueWithCGPoint:point10];
    
    CGPoint point11 = CGPointMake(Auto_Width(1539)/2, Auto_Height(120)/2);
    NSValue *value11 = [NSValue valueWithCGPoint:point11];
    
    CGPoint point12 = CGPointMake(Auto_Width(1976)/2, IS_IPhoneX_All? Auto_Height(299)/2:Auto_Height(278)/2);
    NSValue *value12 = [NSValue valueWithCGPoint:point12];
    
    CGPoint point13 = CGPointMake(Auto_Width(1652)/2, Auto_Height(464)/2);
    NSValue *value13 = [NSValue valueWithCGPoint:point13];
    
    CGPoint point14 = CGPointMake(Auto_Width(1523)/2, Auto_Height(816)/2);
    NSValue *value14 = [NSValue valueWithCGPoint:point14];
    
    CGPoint point15 = CGPointMake(Auto_Width(1955)/2, IS_IPhoneX_All?Auto_Height(940)/2:Auto_Height(910)/2);
    NSValue *value15 = [NSValue valueWithCGPoint:point15];
    
    CGPoint point16 = CGPointMake(Auto_Width(2310)/2, Auto_Height(985)/2);
    NSValue *value16 = [NSValue valueWithCGPoint:point16];
    
    CGPoint point17 = CGPointMake(Auto_Width(2620)/2, Auto_Height(760)/2);
    NSValue *value17 = [NSValue valueWithCGPoint:point17];
    
    CGPoint point18 = CGPointMake(Auto_Width(2373)/2, IS_IPhoneX_All?Auto_Height(536)/2:Auto_Height(506)/2);
    NSValue *value18 = [NSValue valueWithCGPoint:point18];
    
    CGPoint point19 = CGPointMake(Auto_Width(2314)/2, Auto_Height(170)/2);
    NSValue *value19 = [NSValue valueWithCGPoint:point19];
    
    CGPoint point20 = CGPointMake(Auto_Width(2751)/2, Auto_Height(163)/2);
    NSValue *value20 = [NSValue valueWithCGPoint:point20];

    
    NSArray *postion = @[value,value2,value3,value4,value5,value6,value7,value8,value9,value10,value11,value12,value13,value14,value15,value16,value17,value18,value19,value20];
    
    return postion;
}

@end
