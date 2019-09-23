//
//  LongPokerCardTool.m
//  ttttt
//
//  Created by df on 2019/8/27.
//  Copyright © 2019 df. All rights reserved.
//

#import "LongPokerCardTool.h"

@implementation LongPokerCardTool
+(LongPokerCardTool *)shareCardTool
{
    static LongPokerCardTool * tool = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tool = [[LongPokerCardTool alloc] init];
    });
    return tool;
}

-(NSArray*)sortCardFromMinToMax:(NSArray<LongCardModel *>*)cardArray
{
    if (cardArray == nil) {
        return nil;
    }
    NSMutableArray<LongCardModel *> * mutableCardArray = [NSMutableArray arrayWithArray:cardArray];
    NSInteger arrayCount = cardArray.count;
    //冒泡排序
    for (int i = 0; i < arrayCount; i++) {
        for (int j = 0; j < arrayCount-i-1; j++) {
            NSInteger gradeOne = mutableCardArray[j].grade;
            NSInteger gradeTwo = mutableCardArray[j+1].grade;
            BOOL isExchange = NO;
            if (gradeOne > gradeTwo) {
                isExchange = YES;
            }else if (gradeOne == gradeTwo){
                CardBigType typeOne = mutableCardArray[j].bigType;
                CardBigType typeTwo = mutableCardArray[j+1].bigType;
                //从左到右：♠️♥️♣️♦️
                if (typeOne == FANG_KUAI) {
                    isExchange = YES;
                }else if (typeOne == MEI_HUA){
                    if (typeTwo == HONG_TAO || typeTwo == HEI_TAO) {
                        isExchange = YES;
                    }
                }else if (typeOne == HONG_TAO){
                    if (typeTwo == HEI_TAO) {
                        isExchange = YES;
                    }
                }
            }
            if (isExchange) {
                [mutableCardArray exchangeObjectAtIndex:j withObjectAtIndex:j+1];
            }
        }
    }
    
    return mutableCardArray;
}

//1
-(BOOL)isDan:(NSArray<LongCardModel *>*)cardArray
{
    BOOL isDan = NO;
    if (cardArray != nil && cardArray.count == 1) {
        isDan = YES;
    }
    return isDan;
}
//2
-(BOOL)isDuiZi:(NSArray<LongCardModel *>*)cardArray
{
    BOOL isDuiZi = NO;
    if (cardArray != nil && cardArray.count == 2) {
        if (cardArray[0].grade == cardArray[1].grade) {
            isDuiZi = YES;
        }
    }
    return isDuiZi;
}
//3
-(BOOL)isSanDaiYi:(NSArray<LongCardModel *>*)cardArray
{
    if (cardArray.count == 4) {
        cardArray = [self sortCardFromMinToMax:cardArray];
        //炸弹不为三带一
        if (cardArray[0].grade == cardArray[1].grade && cardArray[0].grade == cardArray[2].grade && cardArray[0].grade == cardArray[3].grade) {
            return NO;
        }else if (cardArray[0].grade == cardArray[1].grade && cardArray[0].grade == cardArray[2].grade){//三带一，被带的牌在右边
            return YES;
        }else if (cardArray[1].grade == cardArray[2].grade && cardArray[1].grade == cardArray[3].grade){//三带一，被带的牌在左边
            return YES;
        }
    }
    return NO;
}
//4
-(BOOL)isSanDaiDui:(NSArray<LongCardModel *>*)cardArray
{
    BOOL isSanDaiDui = NO;
    if (cardArray.count == 5) {
        cardArray = [self sortCardFromMinToMax:cardArray];
        if (cardArray[0].grade == cardArray[1].grade && cardArray[2].grade == cardArray[3].grade && cardArray[2].grade == cardArray[4].grade) {//被带的牌在左边
            isSanDaiDui = YES;
        }else if (cardArray[0].grade == cardArray[1].grade && cardArray[0].grade == cardArray[2].grade && cardArray[3].grade == cardArray[4].grade){
            isSanDaiDui = YES;
        }
    }
    return isSanDaiDui;
}
//5
-(BOOL)isSanBuDai:(NSArray<LongCardModel *>*)cardArray
{
    BOOL isSanBuDai = NO;
    if (cardArray.count == 3) {
        if (cardArray[0].grade == cardArray[1].grade && cardArray[0].grade == cardArray[2].grade) {
            isSanBuDai = YES;
        }
    }
    return isSanBuDai;
}
//6
-(BOOL)isSunZi:(NSArray<LongCardModel *>*)cardArray
{
    BOOL isSunZi = YES;
    if (cardArray != nil) {
        if (cardArray.count < 5 || cardArray.count > 12) {
            return NO;
        }
        cardArray = [self sortCardFromMinToMax:cardArray];
        
        for (int i = 0; i < cardArray.count-1; i++) {
            NSInteger prev = cardArray[i].grade;
            NSInteger next = cardArray[i+1].grade;
            //大小王2不能加入顺子
            if (next == 17 || next == 16 || next == 15) {
                isSunZi = NO;
                break;
            }else{
                if (prev - next != -1) {
                    isSunZi = NO;
                    break;
                }
            }
        }
    }
    return isSunZi;
}
//7
-(BOOL)isZhaDan:(NSArray<LongCardModel *>*)cardArray
{
    BOOL isZhaDan = NO;
    if (cardArray.count == 4) {
        if (cardArray[0].grade == cardArray[1].grade && cardArray[0].grade == cardArray[2].grade && cardArray[0].grade == cardArray[3].grade) {
            isZhaDan = YES;
        }
    }
    return isZhaDan;
}
//8
-(BOOL)isWangZha:(NSArray<LongCardModel *>*)cardArray
{
    BOOL isWangZha = NO;
    if (cardArray != nil &&cardArray.count == 2) {
        if (cardArray[0].grade + cardArray[1].grade == 33) {
            isWangZha = YES;
        }
    }
    return isWangZha;
}
//9
-(BOOL)isLianDui:(NSArray<LongCardModel *>*)cardArray
{
    BOOL isLianDui = YES;
    if (cardArray == nil || cardArray.count < 6 || cardArray.count%2 != 0) {
        return NO;
    }
    cardArray = [self sortCardFromMinToMax:cardArray];
    for (int i=0; i<cardArray.count-1; i=i+2) {
        if (cardArray[i].grade != cardArray[i+1].grade) {
            isLianDui = NO;
            break;
        }
        
        if (i<cardArray.count-2) {
            if (cardArray[i].grade - cardArray[i+2].grade != -1) {
                isLianDui = NO;
                break;
            }
        }
    }
    
    return isLianDui;
}

//10
-(BOOL)isFeiJiBuDai:(NSArray<LongCardModel *>*)cardArray
{
    BOOL isFeiJiBuDai = YES;
    if (cardArray == nil || cardArray.count < 6 || cardArray.count%3 != 0) {
        isFeiJiBuDai = NO;
    }else{
        cardArray = [self sortCardFromMinToMax:cardArray];
        NSInteger n = cardArray.count/3;
        NSMutableArray * subMutableArray = [NSMutableArray array];
        for (int i = 0; i<n; i++) {
            NSArray * array = [cardArray subarrayWithRange:NSMakeRange(i*3, 3)];
            BOOL isSanBuDai = [self isSanBuDai:array];
            if (!isSanBuDai) {
                return NO;
            }else{
                [subMutableArray addObject:cardArray[i*3]];
            }
        }
        for (int i = 0; i<subMutableArray.count; i++) {
            LongCardModel * model = subMutableArray[i];
            if (model.grade == 15) {
                return NO;
            }
            if (i<subMutableArray.count-1) {
                LongCardModel * nextModel = subMutableArray[i+1];
                if (nextModel.grade - model.grade != 1) {
                    return NO;
                }
            }
        }
    }
    return isFeiJiBuDai;
}
//11
-(BOOL)isFeiJiDaiDanZhang:(NSArray<LongCardModel *>*)cardArray
{
    BOOL isFeiJiDaiDanZhang = NO;
    if (cardArray == nil || cardArray.count%4 != 0 ||cardArray.count<8) {
        isFeiJiDaiDanZhang = NO;
    }else{
        cardArray = [self sortCardFromMinToMax:cardArray];
        NSInteger n = cardArray.count/4;
        for (int i = 0; i<n+1; i++) {
            NSInteger gradeOne = cardArray[i].grade;
            NSInteger gradeTwo = cardArray[i+1].grade;
            NSInteger gradeThree = cardArray[i+2].grade;
            if (gradeOne == gradeTwo && gradeOne == gradeThree) {
                NSArray * array = [cardArray subarrayWithRange:NSMakeRange(i, 3*n)];
                isFeiJiDaiDanZhang = [self isSanBuDai:array];
            }
        }
    }
    return isFeiJiDaiDanZhang;
}
//12
-(BOOL)isFeiJiDaiDuiZi:(NSArray<LongCardModel *>*)cardArray
{
    BOOL isFeiJiDaiDuiZi = NO;
    if (cardArray == nil || cardArray.count%5 != 0 || cardArray.count <10) {
        isFeiJiDaiDuiZi = NO;
    }else{
        cardArray = [self sortCardFromMinToMax:cardArray];
        NSInteger n = cardArray.count/5;
        for (int i = 0; i<2*n+1; i++) {
            NSInteger gradeOne = cardArray[i].grade;
            NSInteger gradeTwo = cardArray[i+1].grade;
            NSInteger gradeThree = cardArray[i+2].grade;
            if (gradeOne == gradeTwo && gradeOne == gradeThree) {
                NSArray * array = [cardArray subarrayWithRange:NSMakeRange(i, 3*n)];
                if ([self isFeiJiBuDai:array]) {
                    NSMutableArray * mutableArray = [NSMutableArray arrayWithArray:cardArray];
                    [mutableArray removeObjectsInRange:NSMakeRange(i, 3*n)];
                    if (mutableArray.count/2 == n && mutableArray.count%2 == 0) {
                        BOOL allDuizi = YES;
                        for (int i = 0; i<mutableArray.count-1; i = i+2) {
                            LongCardModel * model1 = mutableArray[i];
                            LongCardModel * model2 = mutableArray[i+1];
                            if (model1.grade != model2.grade) {
                                allDuizi = NO;
                            }
                        }
                        if (allDuizi) {
                            isFeiJiDaiDuiZi = YES;
                        }
                    }
                }
            }
        }
    }
    return isFeiJiDaiDuiZi;
}
//13
-(BOOL)isSiDaiEr:(NSArray<LongCardModel *>*)cardArray
{
    BOOL isSiDaiEr = NO;
    if (cardArray.count == 6) {
        cardArray = [self sortCardFromMinToMax:cardArray];
        for (int i = 0; i<3; i++) {
            NSInteger gradeOne = cardArray[i].grade;
            NSInteger gradeTwo = cardArray[i+1].grade;
            NSInteger gradeThree = cardArray[i+2].grade;
            NSInteger gradeFour = cardArray[i+3].grade;
            
            if (gradeOne == gradeTwo && gradeOne == gradeThree && gradeOne == gradeFour) {
                isSiDaiEr = YES;
            }
        }
    }
    return isSiDaiEr;
}
//14
-(BOOL)isSiDaiLiangDui:(NSArray<LongCardModel *>*)cardArray
{
    BOOL isSiDaiLiangDui = NO;
    if (cardArray.count == 8) {
        cardArray = [self sortCardFromMinToMax:cardArray];
        for (int i = 0; i<5; i = i+2) {
            NSInteger gradeOne = cardArray[i].grade;
            NSInteger gradeTwo = cardArray[i+1].grade;
            NSInteger gradeThree = cardArray[i+2].grade;
            NSInteger gradeFour = cardArray[i+3].grade;
            
            if (gradeOne == gradeTwo && gradeOne == gradeThree && gradeOne == gradeFour) {
                NSMutableArray * mutableArray = [NSMutableArray arrayWithArray:cardArray];
                [mutableArray removeObjectsInRange:NSMakeRange(i, 4)];
                LongCardModel * model1 = mutableArray[0];
                LongCardModel * model2 = mutableArray[1];
                LongCardModel * model3 = mutableArray[2];
                LongCardModel * model4 = mutableArray[3];
                if (model1.grade == model2.grade && model3.grade == model4.grade) {
                    isSiDaiLiangDui = YES;
                }
            }
            
        }
    }
    return isSiDaiLiangDui;
}

-(ShowCardsType)getCardsType:(NSArray<LongCardModel *>*)cardArray
{
    ShowCardsType cardsType = 0;
    if (cardArray) {
        if ([self isDan:cardArray]) {
            cardsType = CardsType_Dan;
        }else if ([self isDuiZi:cardArray]){
            cardsType = CardsType_DuiZi;
        }else if ([self isWangZha:cardArray]){
            cardsType = CardsType_WangZha;
        }else if ([self isZhaDan:cardArray]){
            cardsType = CardsType_ZhaDan;
        }else if ([self isSanBuDai:cardArray]){
            cardsType = CardsType_SanBuDai;
        }else if ([self isSanDaiYi:cardArray]){
            cardsType = CardsType_SanDaiYi;
        }else if ([self isSanDaiDui:cardArray]){
            cardsType = CardsType_SanDaiDui;
        }else if ([self isSunZi:cardArray]){
            cardsType = CardsType_SunZi;
        }else if ([self isLianDui:cardArray]){
            cardsType = CardsType_LianDui;
        }else if ([self isFeiJiBuDai:cardArray]){
            cardsType = CardsType_FeiJiBuDai;
        }else if ([self isFeiJiDaiDanZhang:cardArray]){
            cardsType = CardsType_FeiJiDaiDanZhang;
        }else if ([self isFeiJiDaiDuiZi:cardArray]){
            cardsType = CardsType_FeiJiDaiDuiZi;
        }else if ([self isSiDaiEr:cardArray]){
            cardsType = CardsType_SiDaiLiangDanZhang;
        }else if ([self isSiDaiLiangDui:cardArray]){
            cardsType = CardsType_SiDaiLiangDuiZi;
        }else if (cardArray.count == 0){
            cardsType = CardType_MeiChuPai;
        }
    }
    return cardsType;
}

-(BOOL)isCanShowMyCards:(NSArray<LongCardModel*>*)myCardsArray andPrevCards:(NSArray<LongCardModel*>*)prevCardsArray
{
    ShowCardsType myCardsType = [self getCardsType:myCardsArray];
    ShowCardsType prevCardsType = [self getCardsType:prevCardsArray];
    if (myCardsType == 0 || prevCardsType == 0) {
        return NO;
    }
    NSInteger mySize = myCardsArray.count;
    NSInteger prevSize = prevCardsArray.count;
    //我先出牌，上家没出牌
    if (prevSize == 0 && mySize != 0) {
        return YES;
    }
    //集中判断是否王炸
    if (prevCardsType == CardsType_WangZha) {
        return NO;
    }else if (myCardsType == CardsType_WangZha){
        return YES;
    }
    //集中判断对方不是炸弹，我出炸弹的情况
    if (prevCardsType != CardsType_ZhaDan && myCardsType == CardsType_ZhaDan) {
        return YES;
    }
    
    //默认情况：上家和自己想出的牌都符合规则
    myCardsArray = [self sortCardFromMinToMax:myCardsArray];
    prevCardsArray = [self sortCardFromMinToMax:prevCardsArray];
    //比较两家的牌，主要有两种情况：
    //1.我出和上家一种n类型的牌；
    //2.我出炸弹，此时和上家的牌的类型可能不同；
    //王炸的情况已经排除；
    
    if (prevCardsType == CardsType_Dan && myCardsType == CardsType_Dan) {
        if (myCardsArray[0].grade > prevCardsArray[0].grade) {
            return YES;
        }else{
            return NO;
        }
    }else if (prevCardsType == CardsType_DuiZi && myCardsType == CardsType_DuiZi){
        if (myCardsArray[0].grade > prevCardsArray[0].grade) {
            return YES;
        }else{
            return NO;
        }
    }else if (prevCardsType == CardsType_SanBuDai && myCardsType == CardsType_SanBuDai){
        if (myCardsArray[0].grade > prevCardsArray[0].grade) {
            return YES;
        }else{
            return NO;
        }
    }else if (prevCardsType == CardsType_SanDaiYi && myCardsType == CardsType_SanDaiYi){
        if (myCardsArray[1].grade > prevCardsArray[1].grade) {
            return YES;
        }else{
            return NO;
        }
    }else if (prevCardsType == CardsType_SanDaiDui && myCardsType == CardsType_SanDaiDui){
        if (myCardsArray[2].grade > prevCardsArray[2].grade) {
            return YES;
        }else{
            return NO;
        }
    }else if (prevCardsType == CardsType_SunZi && myCardsType == CardsType_SunZi){
        if (mySize != prevSize) {
            return NO;
        }else{
            if (myCardsArray[0].grade > prevCardsArray[0].grade) {
                return YES;
            }else{
                return NO;
            }
        }
    }else if (prevCardsType == CardsType_LianDui && myCardsType == CardsType_LianDui){
        if (mySize != prevSize) {
            return NO;
        }else{
            if (myCardsArray[0].grade > prevCardsArray[0].grade) {
                return YES;
            }else{
                return NO;
            }
        }
    }else if (prevCardsType == CardsType_FeiJiBuDai && myCardsType == CardsType_FeiJiBuDai){
        if (mySize != prevSize) {
            return NO;
        }else{
            if (myCardsArray[0].grade > prevCardsArray[0].grade) {
                return YES;
            }else{
                return NO;
            }
        }
    }else if (prevCardsType == CardsType_FeiJiDaiDanZhang && myCardsType == CardsType_FeiJiDaiDanZhang){
        if (mySize != prevSize) {
            return NO;
        }else{
            if (myCardsArray[5].grade > prevCardsArray[5].grade) {
                return YES;
            }else{
                return NO;
            }
        }
    }else if (prevCardsType == CardsType_FeiJiDaiDuiZi && myCardsType == CardsType_FeiJiDaiDuiZi){
        if (mySize != prevSize) {
            return NO;
        }else{
            NSInteger n = mySize/5;
            if (myCardsArray[2*n].grade > prevCardsArray[2*n].grade) {
                return YES;
            }else{
                return NO;
            }
        }
    }else if (prevCardsType == CardsType_ZhaDan && myCardsType == CardsType_ZhaDan){
        if (myCardsArray[0].grade > prevCardsArray[0].grade) {
            return YES;
        }else{
            return NO;
        }
    }else if (prevCardsType == CardsType_SiDaiLiangDanZhang && myCardsType == CardsType_SiDaiLiangDanZhang){
        if (myCardsArray[2].grade > prevCardsArray[2].grade) {
            return YES;
        }else{
            return NO;
        }
    }else if (prevCardsType == CardsType_SiDaiLiangDanZhang && myCardsType == CardsType_SiDaiLiangDanZhang){
        NSInteger myGrade = 0;
        NSInteger prevGrade = 0;
        for (int i = 0; i<5; i = i+2) {
            NSInteger gradeOne = myCardsArray[i].grade;
            NSInteger gradeTwo = myCardsArray[i+1].grade;
            NSInteger gradeThree = myCardsArray[i+2].grade;
            NSInteger gradeFour = myCardsArray[i+3].grade;
            if (gradeOne == gradeTwo && gradeOne == gradeThree && gradeOne == gradeFour){
                myGrade = gradeOne;
            }
        }
        for (int i = 0; i<5; i = i+2) {
            NSInteger gradeOne = prevCardsArray[i].grade;
            NSInteger gradeTwo = prevCardsArray[i+1].grade;
            NSInteger gradeThree = prevCardsArray[i+2].grade;
            NSInteger gradeFour = prevCardsArray[i+3].grade;
            if (gradeOne == gradeTwo && gradeOne == gradeThree && gradeOne == gradeFour){
                prevGrade = gradeOne;
            }
        }
        if (myGrade > prevGrade) {
            return YES;
        }else{
            NO;
        }
    }

    return NO;
}
@end
