//
//  LongFirstViewController.m
//  ttttt
//
//  Created by df on 2019/8/26.
//  Copyright © 2019 df. All rights reserved.
//

#import "LongFirstViewController.h"
#import "PlotAnimationObject.h"
#import "PlotProgressView.h"
#import "PlotTakeView.h"
#import "DDHomeController.h"

@interface LongFirstViewController ()<PlotTakeViewDelegate>
{
    BOOL isBirdOne;
    BOOL isBirdTwo;
    BOOL isBirdThree;
    
    NSTimer *_timer;
    NSTimer *_downTimer;
    
    CGFloat countD;
}
@property (nonatomic, strong) UIImageView *plotBgImgV;

@property (nonatomic, strong) UIImageView *plotCloudImgV_1;
@property (nonatomic, strong) UIImageView *plotCloudImgV_2;
@property (nonatomic, strong) UIImageView *plotCloudImgV_3;

@property (nonatomic, strong) UIImageView *plotBirdImgV_1;
@property (nonatomic, strong) UIImageView *plotBirdImgV_2;
@property (nonatomic, strong) UIImageView *plotBirdImgV_3;

@property (nonatomic, strong) UIImageView *plotTitle;

@property (nonatomic, strong) UIImageView *plotHouse;

@property (nonatomic, strong) PlotProgressView *progressView;

@property (nonatomic, strong) PlotTakeView *plotTakeView;

@end

@implementation LongFirstViewController

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
    
    if (_downTimer) {
        [_downTimer invalidate];
        _downTimer = nil;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [DDZN_C addObserver:self selector:@selector(refreshAnimation) name:@"refreshAnimation" object:nil];
    
    [self initUI];
    [self initData];
 
}

-(void)refreshAnimation
{
    if (!DDGET_CACHE(DDZ_ISEXIT)) {
        [self cloudImageView_1Animation];
        [self cloudImageView_2Animation];
        [self cloudImageView_3Animation];
        
        [self birdImageView_1Animation];
        [self birdImageView_2Animation];
        [self birdImageView_3Animation];
        
        [self houseImageView_Animation];
    }
}

-(void)initUI
{
    [self.view addSubview:self.plotBgImgV];

    [self.view addSubview:self.plotBirdImgV_1];
    [self.view addSubview:self.plotBirdImgV_2];
    [self.view addSubview:self.plotBirdImgV_3];

    [self.view addSubview:self.plotCloudImgV_1];
    [self.view addSubview:self.plotCloudImgV_2];
    [self.view addSubview:self.plotCloudImgV_3];

    [self.view addSubview:self.plotTitle];
    [self.view addSubview:self.plotHouse];

    [self.view addSubview:self.progressView];

}

-(void)initData
{
    countD = 0;
    
    [self cloudImageView_1Animation];
    [self cloudImageView_2Animation];
    [self cloudImageView_3Animation];

    [self birdImageView_1Animation];
    [self birdImageView_2Animation];
    [self birdImageView_3Animation];

    [self houseImageView_Animation];

//    [self.progressView setProgress:1.];
    
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:0.5
                                                     target:self
                                                   selector:@selector(plotBirdFly)
                                                   userInfo:nil
                                                    repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
        [_timer fire];
    }
    
    if (!_downTimer) {
        _downTimer = [NSTimer scheduledTimerWithTimeInterval:0.01
                                                  target:self
                                                selector:@selector(downCount)
                                                userInfo:nil
                                                 repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
        [_downTimer fire];
    }
    
}

#pragma mark - 加载
-(void)downCount
{
    countD = countD + 0.0022;
    
    if (countD > 0 && countD <= 1) {
        [self.progressView setProgress:countD];
    }
    
    if (countD >= 1) {
        
        if (_downTimer) {
            [_downTimer invalidate];
            _downTimer = nil;
        }
        
        if (DDGET_CACHE(DDZ_ISEXIT)) {
            DDHomeController * vc = [DDHomeController new];
            [self presentViewController:vc animated:YES completion:nil];
        }else{
            [self.view addSubview:self.plotTakeView];
        }
        
        
        
        
        
    }
}

#pragma mark - 前往首页
-(void)goToChallenge
{
    DDHomeController *homeCon = [[DDHomeController alloc] init];
    [self presentViewController:homeCon animated:YES completion:nil];
}

#pragma mark - 云朵的动画效果
//云彩1平移动画
- (void)cloudImageView_1Animation
{
    [PlotAnimationObject translationAnimationView:self.plotCloudImgV_1 animationDuration:45 animationBlock:^{
        CGRect rect = self.plotCloudImgV_1.frame;
        rect.origin.x = -(Auto_Width(124)/2);
        self.plotCloudImgV_1.frame = rect;
   
        [self cloudImageView_1Animation];
    }];
}

//云彩2平移动画
- (void)cloudImageView_2Animation
{
    [PlotAnimationObject translationAnimationView:self.plotCloudImgV_2 animationDuration:50 animationBlock:^{
        CGRect rect = self.plotCloudImgV_2.frame;
        rect.origin.x = -(Auto_Width(159)/2);
        self.plotCloudImgV_2.frame = rect;
        
        [self cloudImageView_2Animation];
    }];
}

//云彩3平移动画
- (void)cloudImageView_3Animation
{
    [PlotAnimationObject translationAnimationView:self.plotCloudImgV_3 animationDuration:39 animationBlock:^{
        CGRect rect = self.plotCloudImgV_3.frame;
        rect.origin.x = -(Auto_Width(93)/2);
        self.plotCloudImgV_3.frame = rect;
        
        [self cloudImageView_3Animation];
    }];
}

#pragma mark - Bird的动画效果
//Bird1右上动画
- (void)birdImageView_1Animation
{
    [PlotAnimationObject translationXYAnimationView:self.plotBirdImgV_1 animationDuration:21 animationBlock:^{
        CGRect rect = self.plotBirdImgV_1.frame;
        rect.origin.x = -Auto_Width(37)/2;
        rect.origin.y = Auto_Height(290)/2;
        self.plotBirdImgV_1.frame = rect;
        
        [self birdImageView_1Animation];
    }];
}

//Bird2右上动画
- (void)birdImageView_2Animation
{
    [PlotAnimationObject translationXY2AnimationView:self.plotBirdImgV_2 animationDuration:26 animationBlock:^{
        CGRect rect = self.plotBirdImgV_2.frame;
        rect.origin.x = -(Auto_Width(37*.7)/2+8);
        rect.origin.y = Auto_Height(320)/2;
        self.plotBirdImgV_2.frame = rect;
        
        [self birdImageView_2Animation];
    }];
}

//Bird3右上动画
- (void)birdImageView_3Animation
{
    [PlotAnimationObject translationXY3AnimationView:self.plotBirdImgV_3 animationDuration:29 animationBlock:^{
        CGRect rect = self.plotBirdImgV_3.frame;
        rect.origin.x = -(Auto_Width(37*.7)/2+16);
        rect.origin.y = Auto_Height(370)/2;
        self.plotBirdImgV_3.frame = rect;
        
        [self birdImageView_3Animation];
    }];
}

-(void)plotBirdFly
{
    if (isBirdOne) {
        [self bird_one_down];
    }else{
        [self bird_one_up];
    }
}

-(void)bird_one_down
{
    isBirdOne = NO;
    self.plotBirdImgV_1.transform = CGAffineTransformMakeRotation(M_PI);
    self.plotBirdImgV_2.transform = CGAffineTransformMakeRotation(M_PI);
    self.plotBirdImgV_3.transform = CGAffineTransformMakeRotation(M_PI);
}

-(void)bird_one_up
{
    isBirdOne = YES;
    self.plotBirdImgV_1.transform = CGAffineTransformIdentity;
    self.plotBirdImgV_2.transform = CGAffineTransformIdentity;
    self.plotBirdImgV_3.transform = CGAffineTransformIdentity;
}

#pragma mark - House
- (void)houseImageView_Animation
{
    [PlotAnimationObject translationHouseAnimationView:self.plotHouse animationDuration:2 animationBlock:^{
        
        [UIView animateWithDuration:2 animations:^{
            CGRect rect = self.plotHouse.frame;
            
            rect.size.width = Auto_Width(470)/2;
            rect.size.height = Auto_Height(331)/2;
            
            rect.origin.x = Auto_Width(140)/2;
            rect.origin.y = Auto_Height(442)/2;
            
            self.plotHouse.frame = rect;
            
        } completion:^(BOOL finished) {
            if (finished) {
                [self houseImageView_Animation];
            }
        }];
        
    }];
}

#pragma mark - lazy
#pragma mark -
-(UIImageView *)plotBgImgV
{
    if (!_plotBgImgV) {
        _plotBgImgV = [[UIImageView alloc] initWithFrame:self.view.bounds];
        [_plotBgImgV setImage:DDImageName(@"plot_bg")];
    }
    return _plotBgImgV;
}

#pragma mark - 云朵
-(UIImageView *)plotCloudImgV_1
{
    if (!_plotCloudImgV_1) {
        _plotCloudImgV_1 = [[UIImageView alloc] initWithFrame:CGRectMake(Auto_Width(19)/2, Auto_Height(196)/2, Auto_Width(124)/2, Auto_Height(27)/2)];
        [_plotCloudImgV_1 setImage:DDImageName(@"plot_cloud_1")];
    }
    return _plotCloudImgV_1;
}

-(UIImageView *)plotCloudImgV_2
{
    if (!_plotCloudImgV_2) {
        _plotCloudImgV_2 = [[UIImageView alloc] initWithFrame:CGRectMake(Auto_Width(280)/2, Auto_Height(72)/2, Auto_Width(159)/2, Auto_Height(33)/2)];
        [_plotCloudImgV_2 setImage:DDImageName(@"plot_cloud_2")];
    }
    return _plotCloudImgV_2;
}

-(UIImageView *)plotCloudImgV_3
{
    if (!_plotCloudImgV_3) {
        _plotCloudImgV_3 = [[UIImageView alloc] initWithFrame:CGRectMake(KScreenWidth - Auto_Width(32)/2 - Auto_Width(124)/2, Auto_Height(138)/2, Auto_Width(93)/2, Auto_Height(20)/2)];
        [_plotCloudImgV_3 setImage:DDImageName(@"plot_cloud_3")];
    }
    return _plotCloudImgV_3;
}

#pragma mark - Bird
-(UIImageView *)plotBirdImgV_1
{
    if (!_plotBirdImgV_1) {
        _plotBirdImgV_1 = [[UIImageView alloc] initWithFrame:CGRectMake(-Auto_Width(37)/2, Auto_Height(290)/2, Auto_Width(37)/2, Auto_Height(7)/2)];
        [_plotBirdImgV_1 setImage:DDImageName(@"plot_bird_1")];
    }
    return _plotBirdImgV_1;
}

-(UIImageView *)plotBirdImgV_2
{
    if (!_plotBirdImgV_2) {
        _plotBirdImgV_2 = [[UIImageView alloc] initWithFrame:CGRectMake(-(Auto_Width(37*.7)/2+8), Auto_Height(320)/2, Auto_Width(37*.7)/2, Auto_Height(7*.7)/2)];
        [_plotBirdImgV_2 setImage:DDImageName(@"plot_bird_1")];
    }
    return _plotBirdImgV_2;
}

-(UIImageView *)plotBirdImgV_3
{
    if (!_plotBirdImgV_3) {
        _plotBirdImgV_3 = [[UIImageView alloc] initWithFrame:CGRectMake(-(Auto_Width(37*.7)/2+16), Auto_Height(370)/2, Auto_Width(37*.7)/2, Auto_Height(7*.7)/2)];
        [_plotBirdImgV_3 setImage:DDImageName(@"plot_bird_1")];
    }
    return _plotBirdImgV_3;
}

#pragma mark - House
-(UIImageView *)plotHouse
{
    if (!_plotHouse) {
        _plotHouse = [[UIImageView alloc] initWithFrame:CGRectMake(Auto_Width(140)/2, Auto_Height(442)/2, Auto_Width(470)/2, Auto_Height(331)/2)];
        [_plotHouse setImage:DDImageName(@"plot_house")];
    }
    return _plotHouse;
}

-(UIImageView *)plotTitle
{
    if (!_plotTitle) {
        _plotTitle = [[UIImageView alloc] initWithFrame:CGRectMake((KScreenWidth-Auto_Width(502)/2)/2, Auto_Height(106)/2, Auto_Width(502)/2, Auto_Height(185)/2)];
        [_plotTitle setImage:DDImageName(@"plot_title")];
    }
    return _plotTitle;
}

#pragma mark - 进度条
-(PlotProgressView *)progressView
{
    if (!_progressView) {
        _progressView = [[PlotProgressView alloc] initWithFrame:CGRectMake((KScreenWidth-Auto_Width(590)/2)/2, KScreenHeight - Auto_Height(222)/2 - Auto_Width(36)/2, Auto_Width(590)/2, Auto_Width(36)/2)];
        //进度条边框宽度
        _progressView.progerStokeWidth = 0.0f;
        //进度条未加载背景
//        _progressView.progerssBackgroundColor = [UIColor lightGrayColor];
        //进度条已加载 颜色
//        _progressView.progerssColor = [UIColor blueColor];
        //背景边框颜色
//        _progressView.progerssStokeBackgroundColor = [UIColor grayColor];
    }
    return _progressView;
}

#pragma mark -
-(PlotTakeView *)plotTakeView
{
    if (!_plotTakeView) {
        _plotTakeView = [[PlotTakeView alloc] initWithFrame:self.view.bounds];
        _plotTakeView.delegate = self;
    }
    return _plotTakeView;
}

@end
