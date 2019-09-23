//
//  ViewController.m
//  XZCJDDZ
//
//  Created by jjj on 2019/9/21.
//  Copyright © 2019 dub. All rights reserved.
//

#import "ViewController.h"
#import "GGProgressView.h"
#import "XZHomeController.h"

@interface ViewController ()
{
    NSTimer *_downTimer;
    CGFloat countD;
}
@property (nonatomic, strong) UIImageView *pBgImgV;
@property (nonatomic, strong) GGProgressView *progressView;
@property (nonatomic, strong) UILabel *loadLabel;

@end

@implementation ViewController

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    
    if (_downTimer) {
        [_downTimer invalidate];
        _downTimer = nil;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initUI];
    [self initData];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(20, 50, 60, 60)];
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    btn.backgroundColor = [UIColor redColor];
    [self.view addSubview:btn];
    
}

-(void)btnClick
{
    
    XZHomeController *con = [[XZHomeController alloc] init];
    [self presentViewController:con animated:YES completion:nil];
}

-(void)initUI
{
    [self.view addSubview:self.pBgImgV];
    [self.view addSubview:self.progressView];
    [self.view addSubview:self.loadLabel];
}

-(void)initData
{
    countD = 0;
    if (!_downTimer) {
        _downTimer = [NSTimer scheduledTimerWithTimeInterval:0.01
                                                      target:self
                                                    selector:@selector(downCount)
                                                    userInfo:nil
                                                     repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:_downTimer forMode:NSRunLoopCommonModes];
        [_downTimer fire];
    }
}

#pragma mark - 加载
-(void)downCount
{
    countD = countD + 0.0022;
    
    if (countD > 0 && countD <= 1) {
        
        self.loadLabel.text = [NSString stringWithFormat:@"Loading...\n%.0f%%",countD*100];
        self.progressView.progress = countD;
        
    }
    
    if (countD >= 1) {
        
        if (_downTimer) {
            [_downTimer invalidate];
            _downTimer = nil;
        }
        
        //        if (XZGET_CACHE(XZ_ISEXIT)) {
        XZHomeController * vc = [XZHomeController new];
        [self presentViewController:vc animated:YES completion:nil];
        //        }else{
        //            [self.view addSubview:self.plotTakeView];
        //        }
        
    }
}

#pragma mark - lazy
#pragma mark -
-(UIImageView *)pBgImgV
{
    if (!_pBgImgV) {
        _pBgImgV = [[UIImageView alloc] initWithFrame:self.view.bounds];
        [_pBgImgV setImage:XZImageName(@"XZStartBG")];
    }
    return _pBgImgV;
}

-(GGProgressView *)progressView
{
    if (!_progressView) {
        _progressView = [[GGProgressView alloc] initWithFrame:CGRectMake(Auto_Width(116)/2, Auto_Height(900)/2, KScreenWidth-(Auto_Width(116/2)*2), Auto_Width(39)/2)];
        _progressView.trackTintColor = RGBCOLOR(63,40,108);
        _progressView.progressTintColor = RGBCOLOR(80, 209, 250);
        
        //        _progressView.trackImage = XZImageName(@"XZStartBG");
        //        _progressView.progressImage = XZImageName(@"home_money_bg");
        
        _progressView.progressViewStyle = GGProgressViewStyleAllFillet;
        
    }
    return _progressView;
}

-(UILabel *)loadLabel
{
    if (!_loadLabel) {
        _loadLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, XZMinY(self.progressView) - Auto_Height(21)/2 - Auto_Height(86)/2, KScreenWidth, Auto_Height(86)/2)];
        _loadLabel.font = [UIFont boldSystemFontOfSize:18.];
        _loadLabel.textColor = [UIColor whiteColor];
        _loadLabel.numberOfLines = 0;
        _loadLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _loadLabel;
}

@end
