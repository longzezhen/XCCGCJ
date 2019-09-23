//
//  PlotTakeView.m
//  DDZCJ
//
//  Created by jjj on 2019/9/10.
//  Copyright © 2019 df. All rights reserved.
//

#import "PlotTakeView.h"
#import "PlotImgVButton.h"
//PingFangSC-Semibold
@interface PlotTakeView ()
{
    NSInteger cur_int;
}
@property (nonatomic, weak) UIImageView *pImgV;
@property (nonatomic, weak) UIButton *keepGobtn;
@property (nonatomic, weak) UIButton *imgVbtn;

@property (nonatomic, strong) UIImageView *plotTakeView_9;

@property (nonatomic, strong) UITextField *stuName;

@end

@implementation PlotTakeView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame]) {
        
        UIView *bgV = [[UIView alloc] initWithFrame:self.bounds];
        bgV.backgroundColor = UIColorFromRGBA(0x000000, .5);
        [self addSubview:bgV];
        
        UIImageView *pImgV = [[UIImageView alloc] initWithFrame:CGRectMake(Auto_Width(20)/2, self.frame.size.height -Auto_Width(274)/2 - Auto_Height(30)/2, Auto_Width(710)/2, Auto_Width(274)/2)];
        pImgV.contentMode = UIViewContentModeScaleAspectFit;
        [pImgV setImage:DDImageName(@"plot_take_1")];
        [self addSubview:pImgV];
        self.pImgV = pImgV;
        
        UIButton *keepGobtn = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width - (Auto_Width(20)/2 * 2) - Auto_Width(150)/2, DDMaxY(pImgV) - 15 - Auto_Width(60)/2, Auto_Width(150)/2, Auto_Width(60)/2)];
//        keepGobtn.backgroundColor = [UIColor redColor];
        [keepGobtn addTarget:self action:@selector(keepGoClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:keepGobtn];
        self.keepGobtn = keepGobtn;
        
        PlotImgVButton *imgVbtn = [[PlotImgVButton alloc] initWithFrame:CGRectMake((self.frame.size.width-Auto_Width(272)/2)/2, self.frame.size.height-(Auto_Width(66)/2)-(Auto_Width(98)/2), Auto_Width(272)/2, Auto_Width(98)/2)];
        imgVbtn.whereToGo = GoToTown;
        [imgVbtn setBackgroundImage:DDImageName(@"plot_takeBtn_5") forState:0];
        [imgVbtn addTarget:self action:@selector(keepGoClick:) forControlEvents:UIControlEventTouchUpInside];
        [imgVbtn setAdjustsImageWhenHighlighted:NO];
        [self addSubview:imgVbtn];
        imgVbtn.hidden = YES;
        self.imgVbtn = imgVbtn;
        
        [self addSubview:self.plotTakeView_9];
        
        cur_int = 1;
        
    }
    return self;
}

#pragma mark - lazy
-(UIImageView *)plotTakeView_9
{
    if (!_plotTakeView_9) {
        _plotTakeView_9 = [[UIImageView alloc] initWithFrame:CGRectMake(Auto_Width(59)/2, Auto_Height(397)/2, Auto_Width(631)/2, (IS_IPhoneX_All ? Auto_Width(575) : Auto_Width(545))/2)];
        [_plotTakeView_9 setImage:DDImageName(@"plot_takeBg_9")];
        _plotTakeView_9.userInteractionEnabled = YES;
        _plotTakeView_9.hidden = YES;
        
        UIImageView *stuInfo = [[UIImageView alloc] initWithFrame:CGRectMake((_plotTakeView_9.frame.size.width-Auto_Width(279)/2)/2, Auto_Height(30)/2, Auto_Width(279)/2, Auto_Width(105)/2)];
        [stuInfo setImage:DDImageName(@"plot_takeTitle_9")];
        [_plotTakeView_9 addSubview:stuInfo];
        
        UIView *tvBg = [[UIView alloc] initWithFrame:CGRectMake((_plotTakeView_9.frame.size.width-Auto_Width(538)/2)/2, DDMaxY(stuInfo)+Auto_Height(64)/2, Auto_Width(538)/2, Auto_Width(110)/2)];
        tvBg.backgroundColor = UIColorFromRGB(0xe6d7ba);
        tvBg.layer.cornerRadius = 20/2;
        tvBg.layer.masksToBounds = YES;
        [_plotTakeView_9 addSubview:tvBg];
        
        UITextField *stuName = [[UITextField alloc] initWithFrame:CGRectMake(Auto_Width(40)/2, (DDHeight(tvBg)-Auto_Width(36)/2)/2, DDWidth(tvBg)-Auto_Width(80)/2, Auto_Width(36)/2)];
        stuName.font = IS_IPAD ? FZY3FWGB(26) : FZY3FWGB(16);
        stuName.textColor = UIColorFromRGB(0x3d3d3d);
        stuName.placeholder = @"请输入你的名字，最多6个字";
        [tvBg addSubview:stuName];
        self.stuName = stuName;
        
        UIButton *sureBtn = [[UIButton alloc] initWithFrame:CGRectMake((DDWidth(_plotTakeView_9)-Auto_Width(272)/2)/2, DDMaxY(tvBg)+Auto_Height(80)/2, Auto_Width(272)/2, Auto_Width(98)/2)];
        [sureBtn addTarget:self action:@selector(keepGoClick:) forControlEvents:UIControlEventTouchUpInside];
        [sureBtn setBackgroundImage:DDImageName(@"plot_takeBtn_9") forState:0];
        [_plotTakeView_9 addSubview:sureBtn];
        
        
        
    }
    return _plotTakeView_9;
}

#pragma mark -
-(void)keepGoClick:(UIButton *)btn
{
    [[MusicPlayObj initClient] playBgMusic];
    
    cur_int ++;
    
    //确定
    if (cur_int == 10) {
        
        if (self.stuName.text.length == 0) {
            [MBProgressHUD showText:@"請輸入您的名字" toView:self];
            cur_int = 9;
            return;
        }else if (self.stuName.text.length > 6) {
            [MBProgressHUD showText:@"請輸入6個字的名字" toView:self];
            cur_int = 9;
            return;
        }
        
        DDSET_CACHE(self.stuName.text, DDZ_USER_NAME);
        DDSET_CACHE(@YES, DDZ_ISEXIT);
        DDSET_CACHE(First_Money, DDZ_USER_MONEY);
        DDSET_CACHE(@"0", DDZ_CURRENT_NUMBER);
        
        NSDate *nowDate = [NSDate date];
        NSUserDefaults *dataUser = [NSUserDefaults standardUserDefaults];
        [dataUser setObject:nowDate forKey:@"nowDate"];
        [dataUser synchronize];
        
        [self.stuName resignFirstResponder];
        
    }
    
    
    if (cur_int == 11) {
        cur_int = 10;
        
        if ([_delegate respondsToSelector:@selector(goToChallenge)]) {
            [_delegate goToChallenge];
        }
        
        
        
        return;
    }
    
    if (cur_int == 9) {
        self.pImgV.hidden = YES;
        self.keepGobtn.hidden = YES;
        self.imgVbtn.hidden = YES;
        
        self.plotTakeView_9.hidden = NO;
        
        [self.stuName becomeFirstResponder];
    }else{
        self.pImgV.hidden = NO;
        self.keepGobtn.hidden = NO;
        self.imgVbtn.hidden = NO;
        
        self.plotTakeView_9.hidden = YES;
        
        NSString *currentStr = [NSString stringWithFormat:@"plot_take_%ld",cur_int];
        
        if (cur_int == 1 || cur_int == 7) {
//            self.pImgV.frame = CGRectMake(20/2, self.frame.size.height -274/2 - 30/2, 710/2, 274/2);
            self.pImgV.frame = CGRectMake(Auto_Width(20)/2, self.frame.size.height -Auto_Width(274)/2 - Auto_Height(30)/2, Auto_Width(710)/2, Auto_Width(274)/2);
        }else{
            self.pImgV.frame = CGRectMake(Auto_Width(20)/2, self.frame.size.height - Auto_Width(485)/2 - Auto_Height(30)/2, Auto_Width(710)/2, Auto_Width(485)/2);
        }
        
        if (cur_int == 5 || cur_int == 8 || cur_int == 10) {
            self.keepGobtn.hidden = YES;
            self.imgVbtn.hidden = NO;
            
            NSString *toImgS = [NSString stringWithFormat:@"plot_takeBtn_%ld",cur_int];
            [self.imgVbtn setBackgroundImage:DDImageName(toImgS) forState:0];
            
        }else{
            self.keepGobtn.hidden = NO;
            self.imgVbtn.hidden = YES;
        }
        
        [self.pImgV setImage:DDImageName(currentStr)];
        
    }
    
    
    
    
}

@end
