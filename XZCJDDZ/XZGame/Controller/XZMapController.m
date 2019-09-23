//
//  XZMapController.m
//  XZCJDDZ
//
//  Created by jjj on 2019/9/21.
//  Copyright © 2019 dub. All rights reserved.
//

#import "XZMapController.h"

@interface XZMapController ()

@end

@implementation XZMapController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(20, 50, 60, 60)];
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    btn.backgroundColor = [UIColor redColor];
    [self.view addSubview:btn];
    
}

-(void)btnClick
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
