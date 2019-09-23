//
//  LongCardModel.h
//  ttttt
//
//  Created by df on 2019/8/27.
//  Copyright © 2019 df. All rights reserved.
//

#import <Foundation/Foundation.h>
// 一张牌的大类型
typedef NS_ENUM(NSUInteger,CardBigType){
    HEI_TAO = 1,
    HONG_TAO,
    MEI_HUA,
    FANG_KUAI,
    XIAO_WANG,
    DA_WANG
};

typedef NS_ENUM(NSUInteger,CardNumberType){
    NUM_A = 1,
    NUM_ER,
    NUM_SAN,
    NUM_SI,
    NUM_WU,
    NUM_LIU,
    NUM_QI,
    NUM_BA,
    NUM_JIU,
    NUM_SHI,
    NUM_J,
    NUM_Q,
    NUM_K,
    NUM_XW,
    NUM_DW    
};

@interface LongCardModel : NSObject
@property (nonatomic,assign) NSInteger cardId;//牌的数字id,1-54
@property (nonatomic,assign) CardBigType bigType;//牌的大类型，方块，梅花,红桃,黑桃,小王,大王
@property (nonatomic,assign) CardNumberType numberType;//2-10,J-A
@property (nonatomic,assign) NSInteger grade;//牌的等级,对牌进行排序时会用到
@property (nonatomic,strong) NSString * imageName;

-(LongCardModel*)initWithID:(NSInteger)cardId;
@end

