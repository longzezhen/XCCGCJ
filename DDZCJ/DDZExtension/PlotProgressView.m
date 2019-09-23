//
//  PlotProgressView.m
//  DDZCJ
//
//  Created by jjj on 2019/9/10.
//  Copyright © 2019 df. All rights reserved.
//

#import "PlotProgressView.h"

#define KProgressPadding 0.0f
//FZY4FW--GB1-0
@interface PlotProgressView ()

@property (nonatomic, weak) UIView *tView;
@property (nonatomic, weak) UIView *borderView;
@property (nonatomic, weak) UILabel *proLabel;

@end

@implementation PlotProgressView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame]) {
        
        //边框
        UIView *borderView = [[UIView alloc] initWithFrame:self.bounds];
        borderView.layer.cornerRadius = Auto_Width(18)/2;
        borderView.layer.masksToBounds = YES;
        borderView.backgroundColor = UIColorFromRGB(0x735a46);
//        borderView.layer.borderColor = [[UIColor blueColor] CGColor];
//        borderView.layer.borderWidth = 2.0f;
        self.borderView = borderView;
        [self addSubview:borderView];
        
        //进度
        UIView *tView = [[UIView alloc] init];
        tView.backgroundColor = UIColorFromRGB(0x2db355);
        tView.layer.cornerRadius = Auto_Width(18)/2;
        tView.layer.masksToBounds = YES;
        [self addSubview:tView];
        self.tView = tView;
        
        UILabel *proLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 2, self.bounds.size.width, self.bounds.size.height-4)];
        proLabel.textColor = [UIColor whiteColor];
        proLabel.font = IS_IPAD ? FZY4FWGB(25) : FZY4FWGB(15);
        proLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:proLabel];
        self.proLabel = proLabel;

    }
    
    return self;
}

-(void)setProgerssColor:(UIColor *)progerssColor{
    _progerssColor = progerssColor;
    _tView.backgroundColor = progerssColor;
}

-(void)setProgerStokeWidth:(CGFloat)progerStokeWidth{
    _progerStokeWidth = progerStokeWidth;
    _borderView.layer.borderWidth = progerStokeWidth;
    
}
-(void)setProgerssStokeBackgroundColor:(UIColor *)progerssStokeBackgroundColor{
    _progerssStokeBackgroundColor = progerssStokeBackgroundColor;
    _borderView.layer.borderColor = [progerssStokeBackgroundColor CGColor];
}
-(void)setProgerssBackgroundColor:(UIColor *)progerssBackgroundColor{
    _progerssBackgroundColor = progerssBackgroundColor;
    _borderView.backgroundColor = progerssBackgroundColor;
}

//更新进度
- (void)setProgress:(CGFloat)progress
{
    _progress = progress;
    
    CGFloat margin = self.progerStokeWidth + KProgressPadding;
    CGFloat maxWidth = self.bounds.size.width - margin * 2;
    CGFloat heigth = self.bounds.size.height - margin * 2;
    
    _tView.frame = CGRectMake(margin, margin, maxWidth * progress, heigth);
    
    _proLabel.text = [NSString stringWithFormat:@"加载%.0f%%",progress*100];
}

@end
