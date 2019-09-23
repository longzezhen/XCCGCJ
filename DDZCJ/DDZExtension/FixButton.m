//
//  FixButton.m
//  DDZCJ
//
//  Created by jjj on 2019/9/18.
//  Copyright © 2019 df. All rights reserved.
//

#import "FixButton.h"

@interface FixButton ()

@property (nonatomic, strong) UIImageView *bgImgV;

@end

@implementation FixButton

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame]) {
        
        [self addSubview:self.bgImgV];
        
    }
    return self;
}

-(void)setBgImgVName:(NSString *)bgImgVName
{
    _bgImgVName = bgImgVName;
    [self.bgImgV setImage:DDImageName(bgImgVName)];
}


-(UIImageView *)bgImgV
{
    if (!_bgImgV) {
        _bgImgV = [[UIImageView alloc] initWithFrame:self.bounds];
    }
    return _bgImgV;
}

@end
