//
//  DDZUpdateView.m
//  DDZCJ
//
//  Created by jjj on 2019/9/18.
//  Copyright © 2019 df. All rights reserved.
//

#define DIALOG_TAG 1105405
#define DIALOG_IMG_TAG 1105406
#define DIALOG_GRADE_TAG 1105407

#import "DDZUpdateView.h"

@implementation DDZUpdateView

+(void)creatUpdateGradeAnimationView
{
    UIView *progressDialog = [[UIView alloc] initWithFrame:LYWindow.bounds];
    progressDialog.tag = DIALOG_TAG;
    [LYWindow addSubview:progressDialog];
    
    UIView *bgView = [[UIView alloc] initWithFrame:progressDialog.bounds];
    bgView.backgroundColor = UIColorFromRGBA(0x000000, 0.75);
    [progressDialog addSubview:bgView];
    
    UIImageView *gongxi = [[UIImageView alloc] initWithFrame:CGRectMake((KScreenWidth-Auto_Width(239)/2)/2, Auto_Height(375)/2, Auto_Width(239)/2, Auto_Width(60)/2)];
    [gongxi setImage:DDImageName(@"updateGong")];
    [progressDialog addSubview:gongxi];
    
    //动画效果
    UIImageView* progressImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"updateView_01.png"]];
    NSMutableArray *imageAnimations = [[NSMutableArray alloc] init];
    for (int i = 1; i < 24; i++) {
        [imageAnimations addObject:[UIImage imageNamed:[NSString stringWithFormat:@"updateView_%02d",i]]];
    }
    
    progressImgView.animationImages = imageAnimations;
    progressImgView.animationDuration = 0.6;
    progressImgView.frame = CGRectMake((KScreenWidth-Auto_Width(556)/2)/2, DDMaxY(gongxi)+Auto_Height(32)/2, Auto_Width(556)/2, Auto_Width(573)/2);
    
    progressImgView.tag = DIALOG_IMG_TAG;
    [progressDialog addSubview:progressImgView];
    
    UIImageView *gradeImgV = [[UIImageView alloc] initWithFrame:CGRectMake((KScreenWidth-Auto_Width(257)/2)/2, DDMaxY(gongxi)+Auto_Height(88)/2, Auto_Width(257)/2, Auto_Width(416)/2)];
    [gradeImgV setImage:DDImageName(@"home_grade_1")];
    gradeImgV.tag = DIALOG_GRADE_TAG;
    [progressDialog addSubview:gradeImgV];
    
    progressDialog.hidden = YES;
    
}

+(void)showUpdateAnimation:(NSTimeInterval)delay gradeNum:(NSInteger)gradeNum
{
    UIView* progressDialog = (UIView*)[LYWindow viewWithTag:DIALOG_TAG];
    if (!progressDialog) {
        [self creatUpdateGradeAnimationView];
        progressDialog = (UIView*)[LYWindow viewWithTag:DIALOG_TAG];
    }
    UIImageView* progressImgView = (UIImageView*)[LYWindow viewWithTag:DIALOG_IMG_TAG];
    UIImageView *gradeImgV = (UIImageView*)[LYWindow viewWithTag:DIALOG_GRADE_TAG];
    if (progressDialog.isHidden) {
        [progressDialog setHidden:NO];
    }
    [LYWindow bringSubviewToFront:progressDialog];
    [progressImgView startAnimating];
    NSString *gr = [NSString stringWithFormat:@"home_grade_%ld",gradeNum];
    [gradeImgV setImage:DDImageName(gr)];
    
    if (delay) {
        [self performSelector:@selector(removeSharkAPPLoading) withObject:nil afterDelay:delay];
    }
    
}

+ (void)removeSharkAPPLoading{
    
    UIView* progressDialog = (UIView*)[[[[UIApplication sharedApplication] delegate] window] viewWithTag:DIALOG_TAG];
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(removeSharkAPPLoading) object:nil];
    UIImageView* progressImgView = (UIImageView*)[[[[UIApplication sharedApplication] delegate] window] viewWithTag:DIALOG_IMG_TAG];

    [progressImgView stopAnimating];
    [progressDialog setHidden:YES];
    
}

@end
