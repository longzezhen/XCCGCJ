//
//  TimeDownObj.m
//  XZCJDDZ
//
//  Created by jjj on 2019/9/21.
//  Copyright © 2019 dub. All rights reserved.
//

#define BtnTag 10290

#import "TimeDownObj.h"

@interface TimeDownObj ()
{
    NSInteger countss;
    UIView *_selfView;
}
@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, copy) TimeDownBlock block;

@property (nonatomic, strong) UIView *timeView;
@property (nonatomic, strong) UILabel *timeLbl;

@end

@implementation TimeDownObj

+(TimeDownObj *)shareClient
{
    static TimeDownObj *client = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        client = [[TimeDownObj alloc] init];
        
        [client initCustom];
    });
    
    return client;
}

-(void)initCustom
{
//    [self setTitmeGo];
}

-(void)setTitmeGo
{
    
}

-(void)downCount
{

    [AppDelegate shareDelegate].currentCount --;
//
    NSLog(@"  -- %ld",(long)[AppDelegate shareDelegate].currentCount);
    countss = [AppDelegate shareDelegate].currentCount;

    NSString *str_minute = [NSString stringWithFormat:@"%02ld",(countss%3600)/60];//分
    NSString *str_second = [NSString stringWithFormat:@"%02ld",countss%60];//秒
    NSString *format_time = [NSString stringWithFormat:@"%@:%@",str_minute,str_second];
    
    self.timeLbl.text = [NSString stringWithFormat:@"%@",format_time];
    
    if (countss <= 0) {
        
        [self stopTimer];
    }
}

//填满当前星星
-(void)FullCurrentStar
{
    
    for (int i = 0; i < XZ_StarCount; i++) {
        UIButton *btn = (UIButton *)[self.timeView viewWithTag:BtnTag+i];
        if (!btn.selected) {
            btn.selected = YES;
        }
    }
}


//计算还有多少星没有填满
-(NSInteger)counDownStars
{
    NSInteger count = 0;
    for (int i = 0; i < XZ_StarCount; i++) {
        UIButton *btn = (UIButton *)[self.timeView viewWithTag:BtnTag+i];
        if (btn.selected) {
            count ++;
        }
    }
    return count;
    
}

//消耗当前能量值
-(void)consumeStar
{
    if ([self counDownStars] <= 0) {
        [MBProgressHUD showText:@"没有能量可以消耗了！" toView:_selfView];
        return;
    }
    
    for (int i = 9; i >= 0; i--) {
        UIButton *btn = (UIButton *)[self.timeView viewWithTag:i+BtnTag];
        if (btn.selected){
            btn.selected = NO;
            break;
        }
    }
}

-(void)setStarWithView:(UIView *)selfView
{
//    self.block = block;
    _selfView = selfView;
    [selfView bringSubviewToFront:self.timeView];
    
}

-(void)startCountDown
{
    if (![self.timer isValid]) {
        [self.timer fire];
    }
}

//计算当前
-(void)stopTimer
{
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
}

-(NSTimer *)timer
{
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:1
                                                  target:self
                                                selector:@selector(downCount)
                                                userInfo:nil
                                                 repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
        
    }
    return _timer;
}

-(UIView *)timeView
{
    if (!_timeView) {
        _timeView = [[UIView alloc] initWithFrame:CGRectMake(20, 200, KScreenWidth-40, 60)];
        _timeView.backgroundColor = [UIColor whiteColor];
        [_selfView addSubview:_timeView];
        
        
        _timeLbl = [[UILabel alloc] init];
        _timeLbl.frame = CGRectMake(XZWidth(_timeView)-10-60, (XZHeight(_timeView)-(XZHeight(_timeView)-10))/2, 60, XZHeight(_timeView)-10);
        _timeLbl.textAlignment = NSTextAlignmentCenter;
        _timeLbl.text = @"00:00";
        _timeLbl.textColor = [UIColor blackColor];
        _timeLbl.font = [UIFont boldSystemFontOfSize:15.];
        [_timeView addSubview:_timeLbl];
        
        CGFloat space_w = 5;
        CGFloat left_x = 10;
        CGFloat xz_w = XZWidth(_timeView) - (left_x*2) - XZWidth(_timeLbl) - 10;
        CGFloat btn_w = (xz_w - (space_w*9)) / 10;
        for (int i = 0; i < 10; i++) {
            UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(left_x + (i*(btn_w+space_w)), (XZHeight(_timeView)-(btn_w))/2, btn_w, btn_w)];
            [btn setBackgroundImage:XZImageName(@"home_head") forState:UIControlStateNormal];
            [btn setBackgroundImage:XZImageName(@"home_money_add") forState:UIControlStateSelected];
//            btn.backgroundColor = [UIColor redColor];
            btn.selected = YES;
            btn.tag = BtnTag + i;
            [_timeView addSubview:btn];
        }
        
        
    }
    return _timeView;
}

-(UILabel *)timeLbl
{
    if (!_timeLbl) {
        _timeLbl = [[UILabel alloc] init];
        _timeLbl.frame = CGRectMake(80, 200, KScreenWidth-160, 68);
        _timeLbl.textAlignment = NSTextAlignmentCenter;
        _timeLbl.textColor = [UIColor whiteColor];
        _timeLbl.font = [UIFont boldSystemFontOfSize:15.];
        
    }
    return _timeLbl;
}


@end
