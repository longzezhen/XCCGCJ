//
//  LongPokerCardTool.h
//  ttttt
//
//  Created by df on 2019/8/27.
//  Copyright © 2019 df. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LongCardModel.h"
typedef NS_ENUM(NSInteger,ShowCardsType){
    CardsType_Dan = 1,
    CardsType_DuiZi,
    CardsType_WangZha,
    CardsType_ZhaDan,
    CardsType_SanBuDai,
    CardsType_SanDaiYi,
    CardsType_SanDaiDui,
    CardsType_SunZi,
    CardsType_LianDui,
    CardsType_FeiJiBuDai,
    CardsType_FeiJiDaiDanZhang,
    CardsType_FeiJiDaiDuiZi,
    CardsType_SiDaiLiangDanZhang,
    CardsType_SiDaiLiangDuiZi,
    
    CardType_MeiChuPai,
};

@interface LongPokerCardTool : NSObject
+(LongPokerCardTool *)shareCardTool;
-(ShowCardsType)getCardsType:(NSArray<LongCardModel *>*)cardArray;
-(NSArray*)sortCardFromMinToMax:(NSArray<LongCardModel *>*)cardArray;
-(BOOL)isCanShowMyCards:(NSArray<LongCardModel*>*)myCardsArray andPrevCards:(NSArray<LongCardModel*>*)prevCardsArray;
@end

