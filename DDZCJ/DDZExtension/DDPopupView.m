//
//  DDPopupView.m
//  DDZCJ
//
//  Created by jjj on 2019/9/11.
//  Copyright © 2019 df. All rights reserved.
//

#import "DDPopupView.h"
#import "UITextView+Placeholder.h"

@interface DDPopupView ()

@property (nonatomic, strong) UIView *xieView;

@property (nonatomic, copy)DDPopupViewBlock block;

@property (nonatomic, copy)DDPopupGameHKBlock gameShopBlock;

@property (nonatomic, strong) UITextField *stuName;

@property (nonatomic, strong) UITextView *remark;

@end

@implementation DDPopupView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame]) {
        
//        self.backgroundColor = UIColorFromRGBA(0x000000, 0.5);
        
    }
    return self;
}

#pragma mark - 游戏反馈
- (void) addFeedBackViewBlock:(DDPopupViewBlock)commitBlock
{
    self.block = commitBlock;
    
    UIView *bgV = [[UIView alloc] initWithFrame:self.bounds];
    bgV.backgroundColor = UIColorFromRGBA(0x000000, 0.5);
    [self addSubview:bgV];
    
    UIImageView *imgVBg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, Auto_Width(630)/2, IS_IPhoneX_All?Auto_Width(764)/2:Auto_Width(724)/2)];
    imgVBg.center = self.center;
    [imgVBg setImage:DDImageName(@"home_feedback_bg")];
    [self addSubview:imgVBg];
    
    UIButton *closeBtn = [[UIButton alloc] initWithFrame:CGRectMake(DDMaxX(imgVBg)-Auto_Width(84)/2 +Auto_Width(20)/2, DDMinY(imgVBg)-Auto_Height(20)/2, Auto_Width(84)/2, Auto_Width(84)/2)];
    [closeBtn setBackgroundImage:DDImageName(@"home_close_btn") forState:0];
    [closeBtn addTarget:self action:@selector(closeClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:closeBtn];
    
    UIImageView *titleImgV = [[UIImageView alloc] initWithFrame:CGRectMake((DDWidth(self)-Auto_Width(277)/2)/2, DDMinY(imgVBg)+Auto_Height(20)/2, Auto_Width(277)/2, Auto_Width(105)/2)];
    [titleImgV setImage:DDImageName(@"home_feedback_title")];
    [self addSubview:titleImgV];
    
    UIView *tvBg1 = [[UIView alloc] initWithFrame:CGRectMake((DDWidth(self)-Auto_Width(538)/2)/2, DDMaxY(titleImgV)+Auto_Height(60)/2, Auto_Width(538)/2, Auto_Width(110)/2)];
    tvBg1.backgroundColor = UIColorFromRGB(0xe6d7ba);
    tvBg1.layer.cornerRadius = 20/2;
    tvBg1.layer.masksToBounds = YES;
    [self addSubview:tvBg1];
    
    UITextField *stuName = [[UITextField alloc] initWithFrame:CGRectMake(Auto_Width(40)/2, (DDHeight(tvBg1)-Auto_Width(36)/2)/2, DDWidth(tvBg1)-(Auto_Width(80)/2), Auto_Width(36)/2)];
    stuName.font = IS_IPAD ? FZY3FWGB(26) : FZY3FWGB(16);
    stuName.textColor = UIColorFromRGB(0x3d3d3d);
    stuName.placeholder = @"请输入反馈标题";
    [tvBg1 addSubview:stuName];
    self.stuName = stuName;
    
//    UIView *tvBg2 = [[UIView alloc] initWithFrame:CGRectMake((DDWidth(self)-Auto_Width(538)/2)/2, DDMaxY(tvBg1)+Auto_Height(20)/2, Auto_Width(538)/2, Auto_Width(210)/2)];
//    tvBg2.backgroundColor = UIColorFromRGB(0xe6d7ba);
//    tvBg2.layer.cornerRadius = 20/2;
//    tvBg2.layer.masksToBounds = YES;
//    [self addSubview:tvBg2];
    
    UITextView *remark = [[UITextView alloc] initWithFrame:CGRectMake((DDWidth(self)-Auto_Width(538)/2)/2, DDMaxY(tvBg1)+Auto_Height(20)/2, Auto_Width(538)/2, Auto_Width(210)/2)];
    [self addSubview:remark];
    remark.backgroundColor = UIColorFromRGB(0xe6d7ba);
    remark.layer.cornerRadius = Auto_Width(20)/2;
    remark.layer.masksToBounds = YES;
//    remark.layer.borderColor = [UIColor lightGrayColor].CGColor;
//    remark.layer.borderWidth = 0.5;
    remark.textContainerInset = UIEdgeInsetsMake(Auto_Height(30)/2, Auto_Width(28)/2, Auto_Height(30)/2, Auto_Width(28)/2);
//    remark.delegate = self;
    remark.textColor = UIColorFromRGB(0x3d3d3d);
    remark.font = IS_IPAD ? FZY3FWGB(26) : FZY3FWGB(16);
    [remark setPlaceholder:@"请输入反馈的内容" placeholdColor:UIColorFromRGB(0xb3a791)];
    self.remark = remark;
    
    UIButton *commitBtn = [[UIButton alloc] initWithFrame:CGRectMake((DDWidth(self)-Auto_Width(272)/2)/2, DDMaxY(remark)+(Auto_Height(54)/2), Auto_Width(272)/2, Auto_Width(98)/2)];
    [commitBtn setBackgroundImage:DDImageName(@"home_feedback_commit") forState:0];
    [commitBtn addTarget:self action:@selector(commitClick) forControlEvents:UIControlEventTouchUpInside];
    [commitBtn setAdjustsImageWhenDisabled:NO];
    [self addSubview:commitBtn];
}

#pragma mark - 游戏商店
-(void)addGameShopWithBlock:(DDPopupGameHKBlock)block
{
    self.gameShopBlock = block;
    
    UIView *bgV = [[UIView alloc] initWithFrame:self.bounds];
    bgV.backgroundColor = UIColorFromRGBA(0x000000, 0.5);
    [self addSubview:bgV];
    
    UIImageView *imgVBg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, Auto_Width(630)/2, IS_IPhoneX_All?Auto_Width(400)/2:Auto_Width(400)/2)];
    imgVBg.center = self.center;
    [imgVBg setImage:DDImageName(@"game_set_bg")];
    [self addSubview:imgVBg];
    
    UIButton *closeBtn = [[UIButton alloc] initWithFrame:CGRectMake(DDMaxX(imgVBg)-Auto_Width(84)/2 +Auto_Width(20)/2, DDMinY(imgVBg)-Auto_Height(20)/2, Auto_Width(84)/2, Auto_Width(84)/2)];
    [closeBtn setBackgroundImage:DDImageName(@"home_close_btn") forState:0];
    [closeBtn addTarget:self action:@selector(closeClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:closeBtn];
    
    UIImageView *titleImgV = [[UIImageView alloc] initWithFrame:CGRectMake((DDWidth(self)-Auto_Width(277)/2)/2, DDMinY(imgVBg)+Auto_Height(20)/2, Auto_Width(277)/2, Auto_Width(105)/2)];
    [titleImgV setImage:DDImageName(@"home_game_title")];
    [self addSubview:titleImgV];
    
//    NSArray *mImgVLArr = @[@"home_game_30l",@"home_game_60l",@"home_game_90l"];
//    NSArray *mHkArr = @[@"home_game_8",@"home_game_15",@"home_game_23"];
    NSArray *mImgVLArr = @[@"home_game_30l"];
    NSArray *mHkArr = @[@"home_game_8"];
    for (int i = 0; i < mHkArr.count; i++) {
        
        UIView *tvBg1 = [[UIView alloc] initWithFrame:CGRectMake((DDWidth(self)-Auto_Width(538)/2)/2, DDMaxY(titleImgV)+Auto_Height(60)/2 + (i * (Auto_Width(150)/2 + Auto_Height(20)/2)), Auto_Width(538)/2, Auto_Width(150)/2)];
        tvBg1.backgroundColor = UIColorFromRGB(0xe6d7ba);
        tvBg1.layer.cornerRadius = 20/2;
        tvBg1.layer.masksToBounds = YES;
        [self addSubview:tvBg1];
        
        UIImageView *mImg = [[UIImageView alloc] initWithFrame:CGRectMake(Auto_Width(30)/2, (DDHeight(tvBg1)-Auto_Width(84)/2)/2, Auto_Width(116)/2, Auto_Width(84)/2)];
        [mImg setImage:DDImageName(@"home_game_money")];
        [tvBg1 addSubview:mImg];
        
        UIImageView *mImgL = [[UIImageView alloc] initWithFrame:CGRectMake(DDMaxX(mImg)+Auto_Width(8)/2, (DDHeight(tvBg1)-Auto_Width(40)/2)/2, Auto_Width(86)/2, Auto_Width(40)/2)];
        [mImgL setImage:DDImageName(mImgVLArr[i])];
        [tvBg1 addSubview:mImgL];
        
        UIButton *hkBtn = [[UIButton alloc] initWithFrame:CGRectMake(DDWidth(tvBg1)-Auto_Width(30)/2-Auto_Width(172)/2, (DDHeight(tvBg1)-Auto_Width(88)/2)/2, Auto_Width(172)/2, Auto_Width(88)/2)];
        [hkBtn setBackgroundImage:DDImageName(mHkArr[i]) forState:0];
        [hkBtn addTarget:self action:@selector(hkClick:) forControlEvents:UIControlEventTouchUpInside];
        hkBtn.tag = i + 10;
        [tvBg1 addSubview:hkBtn];
        
    }
    
}

#pragma mark - 游戏设置
-(void)addGameSetWithBlock:(DDPopupViewBlock)block
{
    self.block = block;
    
    UIView *bgV = [[UIView alloc] initWithFrame:self.bounds];
    bgV.backgroundColor = UIColorFromRGBA(0x000000, 0.5);
    [self addSubview:bgV];
    
    UIImageView *imgVBg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, Auto_Width(630)/2, IS_IPhoneX_All?Auto_Width(424)/2:Auto_Width(364)/2)];
    imgVBg.center = self.center;
    [imgVBg setImage:DDImageName(@"home_feedback_bg")];
    [self addSubview:imgVBg];
    
    UIButton *closeBtn = [[UIButton alloc] initWithFrame:CGRectMake(DDMaxX(imgVBg)-Auto_Width(84)/2 +Auto_Width(20)/2, DDMinY(imgVBg)-Auto_Height(20)/2, Auto_Width(84)/2, Auto_Width(84)/2)];
    [closeBtn setBackgroundImage:DDImageName(@"home_close_btn") forState:0];
    [closeBtn addTarget:self action:@selector(closeClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:closeBtn];
    
    UIImageView *titleImgV = [[UIImageView alloc] initWithFrame:CGRectMake((DDWidth(self)-Auto_Width(277)/2)/2, DDMinY(imgVBg)+Auto_Height(20)/2, Auto_Width(277)/2, Auto_Width(105)/2)];
    [titleImgV setImage:DDImageName(@"home_set_title")];
    [self addSubview:titleImgV];

    UIImageView *bgMusicImgV = [[UIImageView alloc] initWithFrame:CGRectMake(DDMinX(imgVBg)+Auto_Width(60)/2,DDMaxY(titleImgV)+Auto_Height(70)/2, Auto_Width(135)/2, Auto_Width(38)/2)];
    [bgMusicImgV setImage:DDImageName(@"home_set_bgmusic")];
    [self addSubview:bgMusicImgV];
    
    UIButton *bgMusicSetBtn = [[UIButton alloc] initWithFrame:CGRectMake(DDMaxX(imgVBg)-Auto_Width(60)/2-Auto_Width(159)/2, DDMaxY(titleImgV)+Auto_Height(60)/2, Auto_Width(159)/2, Auto_Width(60)/2)];
    [bgMusicSetBtn setBackgroundImage:DDImageName(@"home_set_off") forState:0];
    [bgMusicSetBtn setBackgroundImage:DDImageName(@"home_set_on") forState:UIControlStateSelected];
    [bgMusicSetBtn addTarget:self action:@selector(bgSetClick:) forControlEvents:UIControlEventTouchUpInside];
    bgMusicSetBtn.selected = YES;
    [bgMusicSetBtn setAdjustsImageWhenHighlighted:NO];
    [self addSubview:bgMusicSetBtn];
    
    UIImageView *gameMusicImgV = [[UIImageView alloc] initWithFrame:CGRectMake(DDMinX(imgVBg)+Auto_Width(60)/2,DDMaxY(bgMusicImgV)+Auto_Height(52)/2, Auto_Width(135)/2, Auto_Width(38)/2)];
    [gameMusicImgV setImage:DDImageName(@"home_set_gamemusic")];
    [self addSubview:gameMusicImgV];
    
    UIButton *gameMusicSetBtn = [[UIButton alloc] initWithFrame:CGRectMake(DDMaxX(imgVBg)-Auto_Width(60)/2-Auto_Width(159)/2, DDMaxY(bgMusicSetBtn)+Auto_Height(30)/2, Auto_Width(159)/2, Auto_Width(60)/2)];
    [gameMusicSetBtn setBackgroundImage:DDImageName(@"home_set_off") forState:0];
    [gameMusicSetBtn setBackgroundImage:DDImageName(@"home_set_on") forState:UIControlStateSelected];
    [gameMusicSetBtn addTarget:self action:@selector(gameSetClick:) forControlEvents:UIControlEventTouchUpInside];
    gameMusicSetBtn.selected = YES;
    [gameMusicSetBtn setAdjustsImageWhenHighlighted:NO];
    [self addSubview:gameMusicSetBtn];
}

#pragma mark - 挑战提示
-(void)addChallengeTipsText:(NSString *)text block:(DDPopupViewBlock)block
{
    self.block = block;
    
    UIView *bgV = [[UIView alloc] initWithFrame:self.bounds];
    bgV.backgroundColor = UIColorFromRGBA(0x000000, 0.5);
    [self addSubview:bgV];
    
    UIImageView *imgVBg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, Auto_Width(630)/2,Auto_Width(546)/2)];
    imgVBg.center = self.center;
    [imgVBg setImage:DDImageName(@"home_feedback_bg")];
    [self addSubview:imgVBg];
    
    UIImageView *titleImgV = [[UIImageView alloc] initWithFrame:CGRectMake((DDWidth(self)-Auto_Width(277)/2)/2, DDMinY(imgVBg)+Auto_Height(20)/2, Auto_Width(277)/2, Auto_Width(105)/2)];
    [titleImgV setImage:DDImageName(@"chanllenge_title")];
    [self addSubview:titleImgV];

    UILabel *subTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(DDMinX(imgVBg), DDMaxY(titleImgV)+ Auto_Height(86)/2, DDWidth(imgVBg), Auto_Width(18))];
    subTitleLabel.textColor = UIColorFromRGB(0x3d3d3d);
    subTitleLabel.textAlignment = NSTextAlignmentCenter;
//    subTitleLabel.backgroundColor = [UIColor redColor];
    subTitleLabel.text = text;
    subTitleLabel.font = IS_IPAD ? PingFangFCHeavyFont(28) : PingFangFCHeavyFont(18);
    [self addSubview:subTitleLabel];
    
    UIButton *btnCancel = [[UIButton alloc] initWithFrame:CGRectMake(DDMidX(imgVBg)-Auto_Width(30)/2-Auto_Width(202)/2, DDMaxY(imgVBg)-Auto_Height(56)/2- Auto_Width(98)/2, Auto_Width(202)/2, Auto_Width(98)/2)];
    [btnCancel setBackgroundImage:DDImageName(@"chanllenge_cancel") forState:0];
    [btnCancel addTarget:self action:@selector(challengeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [btnCancel setAdjustsImageWhenHighlighted:NO];
    btnCancel.tag = 100;
    [self addSubview:btnCancel];
    
    UIButton *btnSure = [[UIButton alloc] initWithFrame:CGRectMake(DDMaxX(btnCancel)+Auto_Width(60)/2, DDMaxY(imgVBg)-Auto_Height(56)/2- Auto_Width(98)/2, Auto_Width(202)/2, Auto_Width(98)/2)];
    [btnSure setBackgroundImage:DDImageName(@"chanllenge_sure") forState:0];
    [btnSure addTarget:self action:@selector(challengeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [btnSure setAdjustsImageWhenHighlighted:NO];
    btnSure.tag = 101;
    [self addSubview:btnSure];
}

#pragma mark - 闯关提示框
-(void)challengeTipsWithGradeNum:(NSInteger)gradeNum block:(DDPopupViewBlock)block
{
    self.block = block;
    
    UIView *bgV = [[UIView alloc] initWithFrame:self.bounds];
    bgV.backgroundColor = UIColorFromRGBA(0x000000, 0.5);
    [self addSubview:bgV];
    
    UIImageView *imgVBg = [[UIImageView alloc] init];
    [self addSubview:imgVBg];
    [imgVBg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self);
        make.size.mas_equalTo(CGSizeMake(Auto_Width(630)/2, IS_IPhoneX_All?Auto_Width(595)/2:Auto_Width(545)/2));
    }];
    [imgVBg setImage:DDImageName(@"home_feedback_bg")];
    
    UIButton *closeBtn = [[UIButton alloc] init];
    [closeBtn setBackgroundImage:DDImageName(@"home_close_btn") forState:0];
    [closeBtn addTarget:self action:@selector(closeClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:closeBtn];
    [closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(imgVBg.mas_right).offset(Auto_Width(20)/2);
        make.top.mas_equalTo(imgVBg.mas_top).offset(-Auto_Height(20)/2);
        make.size.mas_equalTo(CGSizeMake(Auto_Width(84)/2, Auto_Width(84)/2));
    }];
    
    UIImageView *titleImgV = [[UIImageView alloc] init];
    [self addSubview:titleImgV];
    [titleImgV setImage:DDImageName(@"map_tips_titlebg")];
    [titleImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(imgVBg.mas_top).offset(Auto_Height(40)/2);
        make.centerX.mas_equalTo(imgVBg.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(Auto_Width(279)/2, Auto_Width(105)/2));
    }];
    
    if (gradeNum > 10) {

        NSString *geshi = [NSString stringWithFormat:@"%ld",gradeNum];
        NSString *firstStr = @"";
        if (gradeNum == 20) {
            firstStr = [NSString stringWithFormat:@"map_tips_%@",[geshi substringToIndex:1]];
        }else{
            firstStr = [NSString stringWithFormat:@"map_tips_0"];
        }

        NSString *secondStr = [NSString stringWithFormat:@"map_tips_%@",[geshi substringFromIndex:geshi.length-1]];;
        
        UIImageView *geImgV = [[UIImageView alloc] init];
        [geImgV setImage:DDImageName(firstStr)];
        [self addSubview:geImgV];
        [geImgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(titleImgV);
            make.right.mas_equalTo(titleImgV.mas_centerX);
            make.size.mas_equalTo(CGSizeMake(Auto_Width(52)/2, Auto_Width(48)/2));
        }];
        
        UIImageView *shiImgV = [[UIImageView alloc] init];
        [shiImgV setImage:DDImageName(secondStr)];
        [self addSubview:shiImgV];
        [shiImgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(geImgV.mas_top);
            make.left.mas_equalTo(titleImgV.mas_centerX);
            make.size.mas_equalTo(CGSizeMake(Auto_Width(52)/2, Auto_Width(48)/2));
        }];
        
        UIImageView *diImgV = [[UIImageView alloc] init];
        [diImgV setImage:DDImageName(@"map_tips_di")];
        [self addSubview:diImgV];
        [diImgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(geImgV);
            make.right.mas_equalTo(geImgV.mas_left);
            make.size.mas_equalTo(CGSizeMake(Auto_Width(49)/2, Auto_Width(49)/2));
        }];
        
        UIImageView *changImgV = [[UIImageView alloc] init];
        [changImgV setImage:DDImageName(@"map_tips_chang")];
        [self addSubview:changImgV];
        [changImgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(shiImgV);
            make.left.mas_equalTo(shiImgV.mas_right);
            make.size.mas_equalTo(CGSizeMake(Auto_Width(50)/2, Auto_Width(49)/2));
        }];
        
    }else{
        NSString *diStr = @"";
        if (gradeNum == 10) {
            diStr = [NSString stringWithFormat:@"map_tips_0"];
        }else{
            diStr = [NSString stringWithFormat:@"map_tips_%ld",gradeNum];
        }
        
        UIImageView *geImgV = [[UIImageView alloc] init];
        [geImgV setImage:DDImageName(diStr)];
        [self addSubview:geImgV];
        [geImgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(titleImgV);
            make.size.mas_equalTo(CGSizeMake(Auto_Width(52)/2, Auto_Width(48)/2));
        }];
        
        UIImageView *diImgV = [[UIImageView alloc] init];
        [diImgV setImage:DDImageName(@"map_tips_di")];
        [self addSubview:diImgV];
        [diImgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(geImgV);
            make.right.mas_equalTo(geImgV.mas_left);
            make.size.mas_equalTo(CGSizeMake(Auto_Width(49)/2, Auto_Width(49)/2));
        }];
        
        UIImageView *changImgV = [[UIImageView alloc] init];
        [changImgV setImage:DDImageName(@"map_tips_chang")];
        [self addSubview:changImgV];
        [changImgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(geImgV);
            make.left.mas_equalTo(geImgV.mas_right);
            make.size.mas_equalTo(CGSizeMake(Auto_Width(50)/2, Auto_Width(49)/2));
        }];
        
    }
    
    UIView *tvBg1 = [[UIView alloc] init];
    tvBg1.backgroundColor = UIColorFromRGB(0xe6d7ba);
    tvBg1.layer.cornerRadius = Auto_Width(34)/2;
    tvBg1.layer.masksToBounds = YES;
    [self addSubview:tvBg1];
    [tvBg1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(titleImgV.mas_bottom).offset(Auto_Height(68)/2);
        make.centerX.mas_equalTo(imgVBg);
        make.size.mas_equalTo(CGSizeMake(Auto_Width(240)/2, Auto_Width(68)/2));
    }];
    
    
    UIImageView *bgMImgV = [[UIImageView alloc] init];
    [bgMImgV setImage:DDImageName(@"map_tips_money")];
    [self addSubview:bgMImgV];
    [bgMImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(tvBg1.mas_left).offset(Auto_Width(16)/2);
        make.centerY.mas_equalTo(tvBg1.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(Auto_Width(66)/2, Auto_Width(45)/2));
    }];
    
    UILabel *feiyong = [[UILabel alloc] init];
    [self addSubview:feiyong];
    feiyong.font = IS_IPAD? PingFangFCHeavyFont(28) : PingFangFCHeavyFont(18);
    feiyong.textColor = UIColorFromRGB(0x3d3d3d);
    feiyong.text = [NSString stringWithFormat:@"-%@",Discount_Money];
    [feiyong mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(bgMImgV.mas_right).offset(Auto_Width(28)/2);
        make.centerY.mas_equalTo(bgMImgV.mas_centerY);
    }];

    NSString *gradeName = @"";
    
    if (gradeNum == 4) {
        gradeName = @"秀才";
    }else if (gradeNum == 7) {
        gradeName = @"舉人";
    }else if (gradeNum == 10) {
        gradeName = @"探花";
    }else if (gradeNum == 13) {
        gradeName = @"榜眼";
    }else if (gradeNum == 17) {
        gradeName = @"狀元";
    }
    
    UILabel *tipsLabel = [[UILabel alloc] init];
    [self addSubview:tipsLabel];
    tipsLabel.font = IS_IPAD ? PingFangFCHeavyFont(28) : PingFangFCHeavyFont(18);
    tipsLabel.textColor = UIColorFromRGB(0x3d3d3d);
    tipsLabel.text = [NSString stringWithFormat:@"通過後將考中【%@】",gradeName];
    tipsLabel.textAlignment = NSTextAlignmentCenter;
    [tipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(tvBg1.mas_bottom).offset(Auto_Height(30)/2);
        make.centerX.mas_equalTo(imgVBg);
        make.height.mas_equalTo(Auto_Width(32)/2);
    }];
    if ([gradeName isEqualToString:@""]) {
        tipsLabel.hidden = YES;
    }
    
    UIButton *sureBtn = [[UIButton alloc] init];
    [sureBtn setBackgroundImage:DDImageName(@"map_tips_btn") forState:0];
    [sureBtn addTarget:self action:@selector(sureClick) forControlEvents:UIControlEventTouchUpInside];
    sureBtn.selected = YES;
    [sureBtn setAdjustsImageWhenHighlighted:NO];
    [self addSubview:sureBtn];
    [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(imgVBg.mas_bottom).offset(-Auto_Height(56)/2);
        make.centerX.mas_equalTo(imgVBg.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(Auto_Width(262)/2, Auto_Width(98)/2));
    }];
    
    
}

#pragma mark - 挑战提示
-(void)addTipsTest:(NSString *)text block:(DDPopupViewBlock)block
{
    self.block = block;
    
    UIView *bgV = [[UIView alloc] initWithFrame:self.bounds];
    bgV.backgroundColor = UIColorFromRGBA(0x000000, 0.5);
    [self addSubview:bgV];
    
    UIImageView *imgVBg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, Auto_Width(630)/2,Auto_Width(546)/2)];
    imgVBg.center = self.center;
    [imgVBg setImage:DDImageName(@"home_feedback_bg")];
    [self addSubview:imgVBg];
    
    UIImageView *titleImgV = [[UIImageView alloc] initWithFrame:CGRectMake((DDWidth(self)-Auto_Width(277)/2)/2, DDMinY(imgVBg)+Auto_Height(20)/2, Auto_Width(277)/2, Auto_Width(105)/2)];
    [titleImgV setImage:DDImageName(@"chanllenge_title")];
    [self addSubview:titleImgV];
    
    UILabel *subTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(DDMinX(imgVBg), DDMaxY(titleImgV)+ Auto_Height(86)/2, DDWidth(imgVBg), Auto_Width(18))];
    subTitleLabel.textColor = UIColorFromRGB(0x3d3d3d);
    subTitleLabel.textAlignment = NSTextAlignmentCenter;
    //    subTitleLabel.backgroundColor = [UIColor redColor];
    subTitleLabel.text = text;
    subTitleLabel.font = IS_IPAD ? PingFangFCHeavyFont(28) : PingFangFCHeavyFont(18);
    [self addSubview:subTitleLabel];

    UIButton *btnSure = [[UIButton alloc] initWithFrame:CGRectMake((DDWidth(self)-(Auto_Width(262)/2))/2, DDMaxY(imgVBg)-Auto_Height(56)/2- Auto_Width(98)/2, Auto_Width(262)/2, Auto_Width(98)/2)];
    [btnSure setBackgroundImage:DDImageName(@"home_tips_sure") forState:0];
    [btnSure addTarget:self action:@selector(sBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [btnSure setAdjustsImageWhenHighlighted:NO];
    [self addSubview:btnSure];
}

#pragma mark - 游戏协议
-(void)addXieyiWithBlock:(DDPopupViewBlock)block
{
    self.block = block;
    
    UIView *bgV = [[UIView alloc] initWithFrame:LYWindow.bounds];
    bgV.backgroundColor = UIColorFromRGBA(0x000000, 0.5);
    [LYWindow addSubview:bgV];
    self.xieView = bgV;
    
    UIImageView *imgVBg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, Auto_Width(630)/2, IS_IPhoneX_All?Auto_Width(924)/2:Auto_Width(924)/2)];
    imgVBg.center = self.center;
    [imgVBg setImage:DDImageName(@"xieyi_title_bg")];
    [LYWindow addSubview:imgVBg];
    
    UIButton *closeBtn = [[UIButton alloc] initWithFrame:CGRectMake(DDMaxX(imgVBg)-Auto_Width(84)/2 +Auto_Width(20)/2, DDMinY(imgVBg)-Auto_Height(20)/2, Auto_Width(84)/2, Auto_Width(84)/2)];
    [closeBtn setBackgroundImage:DDImageName(@"home_close_btn") forState:0];
    [closeBtn addTarget:self action:@selector(closeXieClick) forControlEvents:UIControlEventTouchUpInside];
    [LYWindow addSubview:closeBtn];
    
    UIImageView *titleImgV = [[UIImageView alloc] initWithFrame:CGRectMake((DDWidth(self)-Auto_Width(277)/2)/2, DDMinY(imgVBg)+Auto_Height(20)/2, Auto_Width(277)/2, Auto_Width(105)/2)];
    [titleImgV setImage:DDImageName(@"xieyi_title")];
    [LYWindow addSubview:titleImgV];

}



#pragma mark - click
-(void)sBtnClick
{
    [[MusicPlayObj initClient] playBgMusic];
    
    if (self.block) {
        self.block(YES);
    }
    [self removeFromSuperview];
}

-(void)closeXieClick
{
    if (self.block) {
        self.block(NO);
    }
    [self.xieView removeFromSuperview];
}

-(void)closeClick
{
    [[MusicPlayObj initClient] playBgMusic];
    
    if (self.block) {
        self.block(NO);
    }
    
    if (self.gameShopBlock) {
        self.gameShopBlock(@"");
    }
    
    [self removeFromSuperview];
}

-(void)commitClick
{
    [[MusicPlayObj initClient] playBgMusic];
    
    if (self.stuName.text.length == 0) {
        [MBProgressHUD showText:@"請輸入標題" toView:self];
        return;
    }else if (self.remark.text.length == 0) {
        [MBProgressHUD showText:@"請輸入內容" toView:self];
        return;
    }
    
    
    if (self.block) {
        self.block(YES);
    }
    [self removeFromSuperview];
}

-(void)hkClick:(UIButton *)btn
{
    [[MusicPlayObj initClient] playBgMusic];
    
    if (self.gameShopBlock) {
        if (btn.tag == 10) {
            self.gameShopBlock(@"8");
        }else if (btn.tag == 11) {
            self.gameShopBlock(@"15");
        }else if (btn.tag == 12) {
            self.gameShopBlock(@"23");
        }
    }
}

-(void)bgSetClick:(UIButton *)btn
{
    btn.selected = !btn.selected;
    
}

-(void)gameSetClick:(UIButton *)btn
{
    btn.selected = !btn.selected;
    
}

-(void)challengeBtnClick:(UIButton *)btn
{
    [[MusicPlayObj initClient] playBgMusic];
    
    if (btn.tag == 101) {
        if (self.block) {
            self.block(YES);
        }
    }else{
        if (self.block) {
            self.block(NO);
        }
    }
    
    [self removeFromSuperview];
}

-(void)sureClick
{
    [[MusicPlayObj initClient] playBgMusic];
    
    if (self.block) {
        self.block(YES);
    }
    [self removeFromSuperview];
}

@end
