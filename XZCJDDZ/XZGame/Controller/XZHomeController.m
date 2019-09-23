//
//  XZHomeController.m
//  XZCJDDZ
//
//  Created by jjj on 2019/9/21.
//  Copyright © 2019 dub. All rights reserved.
//

#import "XZHomeController.h"
#import "EnergyView.h"
#import "XZMapController.h"

@interface XZHomeController ()

@property (nonatomic, strong) UIImageView *XZBgImgV;
@property (nonatomic, strong) EnergyView *energyView;

@end

@implementation XZHomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self initUI];
    [self initData];
    
}

-(void)initUI
{
    [self.view addSubview:self.XZBgImgV];
//    [self.view addSubview:self.energyView];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(20, 50, 60, 60)];
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    btn.backgroundColor = [UIColor redColor];
    [self.view addSubview:btn];
    
    UIButton *btn2 = [[UIButton alloc] initWithFrame:CGRectMake(160, 50, 60, 60)];
    [btn2 addTarget:self action:@selector(btnClick2) forControlEvents:UIControlEventTouchUpInside];
    btn2.backgroundColor = [UIColor redColor];
    [self.view addSubview:btn2];
    
    [[TimeDownObj shareClient] setStarWithView:self.view];
}

-(void)btnClick
{
//    [self dismissViewControllerAnimated:YES completion:nil];
    
    XZMapController *con = [[XZMapController alloc] init];
    [self presentViewController:con animated:YES completion:nil];
}

-(void)btnClick2
{
//    [self dismissViewControllerAnimated:YES completion:nil];
    [AppDelegate shareDelegate].currentCount = XZ_CountSec;
    [[TimeDownObj shareClient] startCountDown];
}

-(void)initData
{
    

}

#pragma mark - lazy
#pragma mark -
-(UIImageView *)XZBgImgV
{
    if (!_XZBgImgV) {
        _XZBgImgV = [[UIImageView alloc] initWithFrame:self.view.bounds];
        [_XZBgImgV setImage:XZImageName(@"XZStartBG")];
    }
    return _XZBgImgV;
}

-(EnergyView *)energyView
{
    if (!_energyView) {
        _energyView = [[EnergyView alloc] initWithFrame:CGRectMake(40, 250, KScreenWidth-80, 80)];
        _energyView.backgroundColor = [UIColor blueColor];
    }
    return _energyView;
}


@end
