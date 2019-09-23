//
//  MapGradeButton.m
//  DDZCJ
//
//  Created by jjj on 2019/9/13.
//  Copyright © 2019 df. All rights reserved.
//

#import "MapGradeButton.h"
#import "DDZMapModel.h"

#define NameArr @[@"map_name_1",@"map_name_2",@"map_name_3",@"map_name_4",@"map_name_5",@"map_name_6"]
#define CurrentArr @[@"map_current_1",@"map_current_2",@"map_current_3",@"map_current_4",@"map_current_5",@"map_current_6"]
#define GradePassArr @[@"map_grade_pass_1",@"map_grade_pass_2",@"map_grade_pass_3",@"map_grade_pass_4",@"map_grade_pass_5",@"map_grade_pass_6"]
#define GradeNoPassArr @[@"map_grade_nopass_1",@"map_grade_nopass_2",@"map_grade_nopass_3",@"map_grade_nopass_4",@"map_grade_nopass_5",@"map_grade_nopass_6"]

@interface MapGradeButton ()

@property (nonatomic, strong) UIImageView *gradeImgV;
@property (nonatomic, strong) UIImageView *currentImgV;
@property (nonatomic, strong) UIImageView *nameImgV;

@end

@implementation MapGradeButton

-(instancetype)init
{
    if (self == [super init]) {
        
        self.gradeImgV = [UIImageView new];
        [self addSubview:self.gradeImgV];
        [self.gradeImgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(0);
            make.size.mas_equalTo(CGSizeMake(Auto_Width(142)/2, Auto_Width(160)/2));
        }];
        
        self.currentImgV = [UIImageView new];
        [self addSubview:self.currentImgV];
        self.currentImgV.contentMode = UIViewContentModeScaleAspectFit;
        [self.currentImgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self.gradeImgV.mas_bottom).offset(-Auto_Height(50)/2);
            make.centerX.mas_equalTo(self.gradeImgV.mas_centerX).offset(2);
            make.size.mas_equalTo(CGSizeMake(Auto_Width(147)/2, Auto_Width(245)/2));
        }];
        
        self.nameImgV = [UIImageView new];
        [self addSubview:self.nameImgV];
        [self.nameImgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self.gradeImgV.mas_bottom).offset(Auto_Height(8)/2);
            make.centerX.mas_equalTo(self.gradeImgV);
            make.size.mas_equalTo(CGSizeMake(Auto_Width(113)/2, Auto_Width(43)/2));
        }];
        
        
        
    }
    return self;
}

-(void)setGradeModel:(DDZMapModel *)mapModel
{
    _isPassOrNot = mapModel.isPassOrNot;
    _mapGrade = mapModel.mapGrade;
    _isCurrentPosition = mapModel.isCurrentPosition;
    
    self.currentImgV.hidden = !mapModel.isCurrentPosition;
    if (mapModel.isCurrentPosition) {
        [self.gradeImgV setImage:DDImageName(@"map_current_bg")];
        [self.currentImgV setImage:DDImageName(CurrentArr[mapModel.mapGrade])];
    }else{
        [self.gradeImgV setImage:mapModel.isPassOrNot ? DDImageName(GradePassArr[mapModel.mapGrade]) :  DDImageName(GradeNoPassArr[mapModel.mapGrade])];
        
        [self.nameImgV setImage:DDImageName(NameArr[mapModel.mapGrade])];
        
        if (mapModel.mapGrade == 0) {
            [self.nameImgV mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.bottom.mas_equalTo(self.gradeImgV.mas_bottom).offset(Auto_Height(8)/2);
                make.centerX.mas_equalTo(self.gradeImgV);
                make.size.mas_equalTo(CGSizeMake(Auto_Width(113)/2, Auto_Width(43)/2));
            }];
        }else if (mapModel.mapGrade == 1) {
            [self.nameImgV mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.bottom.mas_equalTo(self.gradeImgV.mas_bottom).offset(Auto_Height(8)/2);
                make.centerX.mas_equalTo(self.gradeImgV);
                make.size.mas_equalTo(CGSizeMake(Auto_Width(77)/2, Auto_Width(43)/2));
            }];
        }else if (mapModel.mapGrade == 2) {
            [self.nameImgV mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.bottom.mas_equalTo(self.gradeImgV.mas_bottom).offset(Auto_Height(8)/2);
                make.centerX.mas_equalTo(self.gradeImgV);
                make.size.mas_equalTo(CGSizeMake(Auto_Width(77)/2, Auto_Width(43)/2));
            }];
        }else if (mapModel.mapGrade == 3) {
            [self.nameImgV mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.bottom.mas_equalTo(self.gradeImgV.mas_bottom).offset(Auto_Height(8)/2);
                make.centerX.mas_equalTo(self.gradeImgV);
                make.size.mas_equalTo(CGSizeMake(Auto_Width(75)/2, Auto_Width(43)/2));
            }];
        }else if (mapModel.mapGrade == 4) {
            [self.nameImgV mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.bottom.mas_equalTo(self.gradeImgV.mas_bottom).offset(Auto_Height(8)/2);
                make.centerX.mas_equalTo(self.gradeImgV);
                make.size.mas_equalTo(CGSizeMake(Auto_Width(79)/2, Auto_Width(43)/2));
            }];
        }else if (mapModel.mapGrade == 5) {
            [self.nameImgV mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.bottom.mas_equalTo(self.gradeImgV.mas_bottom).offset(Auto_Height(8)/2);
                make.centerX.mas_equalTo(self.gradeImgV);
                make.size.mas_equalTo(CGSizeMake(Auto_Width(78)/2, Auto_Width(43)/2));
            }];
        }
    }
    
}

-(void)setIsShowTitle:(BOOL)isShowTitle
{
    _isShowTitle = isShowTitle;
    self.nameImgV.hidden = !isShowTitle;
    
    
    
}

//
-(void)setMapGrade:(MAPGRADELEVEL)mapGrade
{
    _mapGrade = mapGrade;
    
}


-(void)setIsPassOrNot:(BOOL)isPassOrNot
{
    _isPassOrNot = isPassOrNot;
    
    switch (self.mapGrade) {
        case GradeOne:
            
            [self.nameImgV setImage:DDImageName(NameArr[self.mapGrade])];
            [self.gradeImgV setImage:isPassOrNot ? DDImageName(GradePassArr[self.mapGrade]) : DDImageName(GradeNoPassArr[self.mapGrade])];
            
            break;
            
        case GradeTwo:
            
            [self.nameImgV setImage:DDImageName(NameArr[self.mapGrade])];
            [self.gradeImgV setImage:isPassOrNot ? DDImageName(GradePassArr[self.mapGrade]) : DDImageName(GradeNoPassArr[self.mapGrade])];
            
            break;
            
        default:
            break;
    }
    
}



-(void)setIsCurrentPosition:(BOOL)isCurrentPosition
{
    _isCurrentPosition = isCurrentPosition;
//    self.nameImgV.hidden = isCurrentPosition;
    self.currentImgV.hidden = !isCurrentPosition;
    if (isCurrentPosition) {
        [self.gradeImgV setImage:DDImageName(@"map_current_bg")];
        [self.currentImgV setImage:DDImageName(CurrentArr[self.mapGrade])];
        
    }
    
}


@end
