//
//  EnergyView.m
//  XZCJDDZ
//
//  Created by jjj on 2019/9/21.
//  Copyright © 2019 dub. All rights reserved.
//

#import "EnergyView.h"

@interface EnergyView ()

@property (nonatomic, strong) UILabel *countStar;
@property (nonatomic, strong) UILabel *timeLbl;

@end

@implementation EnergyView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self addSubview:self.timeLbl];
        [self addSubview:self.countStar];
        
    }
    return self;
}

-(void)setCuCount:(NSInteger)cuCount
{
    _cuCount  = cuCount;
    NSString *str_minute = [NSString stringWithFormat:@"%02ld",(cuCount%3600)/60];//分
    NSString *str_second = [NSString stringWithFormat:@"%02ld",cuCount%60];//秒
    NSString *format_time = [NSString stringWithFormat:@"%@:%@",str_minute,str_second];
    
     self.timeLbl.text = [NSString stringWithFormat:@"%@",format_time];
    
}

-(UILabel *)countStar
{
    if (!_countStar) {
        _countStar = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, self.frame.size.height)];
        _countStar.textColor = [UIColor whiteColor];
        _countStar.font = [UIFont boldSystemFontOfSize:15.];
    }
    return _countStar;
}

-(UILabel *)timeLbl
{
    if (!_timeLbl) {
        _timeLbl = [[UILabel alloc] initWithFrame:self.bounds];
        _timeLbl.textAlignment = NSTextAlignmentCenter;
        _timeLbl.textColor = [UIColor whiteColor];
        _timeLbl.font = [UIFont boldSystemFontOfSize:15.];
    }
    return _timeLbl;
}

@end
