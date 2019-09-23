//
//  LongDDZScene.m
//  GameTest
//
//  Created by df on 2019/8/26.
//  Copyright © 2019 df. All rights reserved.
//

#import "LongDDZScene.h"
#import "LongCardModel.h"
#import "LongPokerCardTool.h"
#import "AppDelegate.h"
#import "LongFirstViewController.h"
#import "DDPopupView.h"
#import "DDZJieSuanView.h"
#import "DDPopupGameSet.h"
#import "DDZBackgroundMusic.h"
#define BIGCARDWIDE      186*0.8/2
#define BIGCARDHEIGHT    257*0.8/2
#define SMALLCARDWIDE    186*0.6/2
#define SMALLCARDHEIGHT  257*0.6/2
#define SPACEBIG            54/2
#define SPACESMALL       40/2
#define PAIUP           60/2

@interface LongDDZScene()
@property (nonatomic,strong)SKSpriteNode * backgroundNode;
@property (nonatomic,strong)SKAudioNode * gameAudioNode;
@property (nonatomic,strong)SKSpriteNode * nongMingNode;
@property (nonatomic,strong)SKSpriteNode * diZhuNode;
@property (nonatomic,strong)SKSpriteNode * chuPaiNode;
@property (nonatomic,strong)SKSpriteNode * buChuNode;
@property (nonatomic,strong)SKSpriteNode * yaoBuQiNode;
@property (nonatomic,strong)SKSpriteNode * backNode;
@property (nonatomic,strong)SKSpriteNode * settingNode;
@property (nonatomic,strong)SKSpriteNode * moneyNode;
@property (nonatomic,strong)SKLabelNode * moneyValueLabelNode;
@property (nonatomic,strong)UILabel * moneyValueLabel;
@property (nonatomic,strong)DDPopupView * popupView;
@property (nonatomic,strong)DDZJieSuanView * winJieSuanView;
@property (nonatomic,strong)DDZJieSuanView * loseJieSuanView;
@property (nonatomic,strong)SKSpriteNode * gameBeginNode;

@property (nonatomic,strong)NSMutableArray * myCardArray;
@property (nonatomic,strong)NSMutableArray * myNodeArray;
@property (nonatomic,strong)NSMutableArray * robotCardArray;
@property (nonatomic,strong)NSMutableArray * robotNodeArray;
@property (nonatomic,strong)NSMutableArray * myWillShowCardArray;
@property (nonatomic,strong)NSMutableArray * myWillShowNodeArray;
@property (nonatomic,strong)NSMutableArray * prevShowCardArray;
@property (nonatomic,strong)NSMutableArray * myZhuoShangNodeArray;
@property (nonatomic,strong)NSMutableArray * robotZhuoShangNodeArray;

@property (nonatomic,strong)SKAudioNode * choiceCardNode;
@end
@implementation LongDDZScene
-(void)dealloc
{
    
}

-(instancetype)initWithSize:(CGSize)size
{
    if (self = [super initWithSize:size]) {
        [self addChild:self.backgroundNode];
        [self addChild:self.nongMingNode];
        [self addChild:self.diZhuNode];
        [self addChild:self.backNode];
        [self addChild:self.settingNode];
        [self addChild:self.moneyNode];
        [self addChild:self.gameBeginNode];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0001 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.moneyValueLabel.hidden = NO;
        });

        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [self.gameBeginNode removeFromParent];
            if (![DDGET_CACHE(DDZ_SET_BgMusic) isEqualToString:@"GBBJYY"]) {
                [[DDZBackgroundMusic shareBackgroundMusic] gameBackgroundMusicPlay];
            }
//            NSString * plistPath = [[NSBundle mainBundle] pathForResource:@"PaiXingProperty" ofType:@"plist"];
//            NSArray * paipuArray = [[NSArray alloc] initWithContentsOfFile:plistPath];
//            NSDictionary * dic = paipuArray[[AppDelegate shareDelegate].paipuNumber];
//            self.myCardArray = [NSMutableArray arrayWithArray:[self cardsForCardIDArray:dic[@"player"]]];
//            self.robotCardArray = [NSMutableArray arrayWithArray:[self cardsForCardIDArray:dic[@"robot"]]];
//            [self addMyNodeWithCardArray:self.myCardArray];
//            [self addRobotNodeWithCardArray:self.robotCardArray];
//
//            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                [self addChild:self.chuPaiNode];
//                [self addChild:self.buChuNode];
//                self.buChuNode.hidden = YES;
//            });
            
        });
        
    }
    return self;
}

-(void)fapai
{
    NSString * plistPath = [[NSBundle mainBundle] pathForResource:@"PaiXingProperty" ofType:@"plist"];
    NSArray * paipuArray = [[NSArray alloc] initWithContentsOfFile:plistPath];
    NSDictionary * dic = paipuArray[[AppDelegate shareDelegate].paipuNumber];
    self.myCardArray = [NSMutableArray arrayWithArray:[self cardsForCardIDArray:dic[@"player"]]];
    self.robotCardArray = [NSMutableArray arrayWithArray:[self cardsForCardIDArray:dic[@"robot"]]];
    [self addMyNodeWithCardArray:self.myCardArray];
    [self addRobotNodeWithCardArray:self.robotCardArray];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self addChild:self.chuPaiNode];
        [self addChild:self.buChuNode];
        self.buChuNode.hidden = YES;
    });
}

#pragma mark - private
-(void)addMyNodeWithCardArray:(NSArray<LongCardModel*>*)cardsArray
{
    CGFloat pointx = (self.size.width-SPACEBIG*(cardsArray.count-1)-BIGCARDWIDE)/2;
    for (int i = 0; i<cardsArray.count; i++) {
        LongCardModel * model = cardsArray[i];
        SKSpriteNode * cardNode = [[SKSpriteNode alloc] initWithImageNamed:model.imageName];
        cardNode.name = model.imageName;
        cardNode.size = CGSizeMake(BIGCARDWIDE, BIGCARDHEIGHT);
        cardNode.position = CGPointMake(self.size.width+BIGCARDWIDE/2, Auto_Height(20)+BIGCARDHEIGHT/2);
        [self addChild:cardNode];
        SKAction * moveAction = [SKAction moveTo:CGPointMake(pointx+BIGCARDWIDE/2+SPACEBIG*i, Auto_Height(20)+BIGCARDHEIGHT/2) duration:0.8];
        [self.myNodeArray addObject:cardNode];
        [cardNode runAction:moveAction];
    }
}

-(void)addRobotNodeWithCardArray:(NSArray<LongCardModel*>*)cardsArray
{
    CGFloat pointx = (self.size.width-SPACEBIG*(cardsArray.count-1)-BIGCARDWIDE)/2;
    for (int i = 0; i<cardsArray.count; i++) {
        LongCardModel * model = cardsArray[i];
        SKSpriteNode * cardNode = [[SKSpriteNode alloc] initWithImageNamed:model.imageName];
        cardNode.size = CGSizeMake(BIGCARDWIDE, BIGCARDHEIGHT);
        cardNode.position = CGPointMake(self.size.width+BIGCARDWIDE/2, self.size.height-Auto_Height(324/2)-BIGCARDHEIGHT/2);
        [self addChild:cardNode];
        SKAction * moveAction = [SKAction moveTo:CGPointMake(pointx+BIGCARDWIDE/2+SPACEBIG*i, self.size.height-Auto_Height(324/2)-BIGCARDHEIGHT/2) duration:0.8];
        [self.robotNodeArray addObject:cardNode];
        [cardNode runAction:moveAction];
    }
}

#pragma mark - 移除我桌上的牌
//移除我桌上的牌
-(void)removeMyZhuoShangNodePai
{
    for (SKNode * node in self.myZhuoShangNodeArray) {
        [node removeFromParent];
    }
}

#pragma mark - 移除机器人桌上的牌
//移除机器人桌上的牌
-(void)removeRobotZhuoShangNodePai
{
    for (SKNode * node in self.robotZhuoShangNodeArray) {
        [node removeFromParent];
    }
}

-(void)robotCardsAnimationWithIndex:(NSInteger)i andWithRobotCardsNumber:(NSInteger)n
{
    [self.robotZhuoShangNodeArray replaceObjectsInRange:NSMakeRange(0, self.robotZhuoShangNodeArray.count) withObjectsFromArray:self.robotNodeArray range:NSMakeRange(i, n)];
    //移动robot要出的牌
    [self moveRobotCardsWithNodeArray:self.robotZhuoShangNodeArray];
    [self.prevShowCardArray replaceObjectsInRange:NSMakeRange(0, self.prevShowCardArray.count) withObjectsFromArray:self.robotCardArray range:NSMakeRange(i, n)];
    
    [self.robotCardArray removeObjectsInRange:NSMakeRange(i, n)];
    [self.robotNodeArray removeObjectsInRange:NSMakeRange(i, n)];
    
    //更新robot手牌布局
    [self updateRobotNodeBuju];
}

#pragma mark - 移动robot出的牌
//移动robot牌
-(void)moveRobotCardsWithNodeArray:(NSArray*)array
{
    //移走robot要出的牌
    CGFloat pointx = (self.size.width-SPACESMALL*(array.count-1)-SMALLCARDWIDE)/2;
    for (int j = 0; j<array.count; j++) {
        SKNode * node = array[j];
        SKAction * moveAction = [SKAction moveTo:CGPointMake(pointx+SMALLCARDWIDE/2+SPACESMALL*j, self.size.height-Auto_Height(324/2)-BIGCARDHEIGHT-Auto_Height(10)-SMALLCARDHEIGHT/2) duration:0.1];
        SKAction * scaleAction = [SKAction scaleTo:0.75 duration:0.1];
        [node runAction:[SKAction group:@[moveAction,scaleAction]]];
    }
}

#pragma mark - 更新我的手牌布局
//更新我的手牌布局
-(void)updateMyNodeBuju
{
    CGFloat pointx = (self.size.width-SPACEBIG*(self.myNodeArray.count-1)-BIGCARDWIDE)/2;
    for (int i = 0; i<self.myNodeArray.count; i++) {
        SKNode * node = self.myNodeArray[i];
        SKAction * moveAction = [SKAction moveTo:CGPointMake(pointx+BIGCARDWIDE/2+SPACEBIG*i, Auto_Height(20)+BIGCARDHEIGHT/2) duration:0.1];
        [node runAction:moveAction];
    }
}

#pragma mark - 更新robot手牌布局
//更新robot手牌布局
-(void)updateRobotNodeBuju
{
    CGFloat pointx = (self.size.width-(self.robotNodeArray.count-1)*SPACEBIG-BIGCARDWIDE)/2;
    for (int n = 0; n<self.robotNodeArray.count; n++) {
        SKNode * node = self.robotNodeArray[n];
        SKAction * moveAction = [SKAction moveTo:CGPointMake(pointx+BIGCARDWIDE/2+SPACEBIG*n, self.size.height-Auto_Height(324/2)-BIGCARDHEIGHT/2) duration:0.1];
        [node runAction:moveAction];
    }
}

//是否有炸弹管上
-(BOOL)myCardZhaDanGuanShang
{
    BOOL canShow = NO;
    for (int i = 0; i+3<self.myCardArray.count; i++) {
        LongCardModel * modelOne = self.myCardArray[i];
        LongCardModel * modelTwo = self.myCardArray[i+1];
        LongCardModel * modelThree = self.myCardArray[i+2];
        LongCardModel * modelFour = self.myCardArray[i+3];
        if (modelOne.grade == modelTwo.grade && modelOne.grade == modelThree.grade && modelOne.grade == modelFour.grade) {
            canShow = YES;
            break;
        }
    }
    return canShow;
}

//是否有王炸管上
-(BOOL)myCardWangZhaGuanShang
{
    BOOL canShow = NO;
    //牌数小于2张肯定没王炸
    if (self.myCardArray.count<2) {
        return NO;
    }
    LongCardModel * lastModel = [self.myCardArray lastObject];
    NSInteger robotNum = self.myCardArray.count;
    LongCardModel * preLastModel = self.myCardArray[robotNum-2];
    if (lastModel.grade+preLastModel.grade == 33) {
        canShow = YES;
    }
    return canShow;
}


//机器人是否有炸弹管上并出牌
-(BOOL)robotZhaDanGuanShang
{
    BOOL canShow = NO;
    for (int i = 0; i+3<self.robotCardArray.count; i++) {
        LongCardModel * modelOne = self.robotCardArray[i];
        LongCardModel * modelTwo = self.robotCardArray[i+1];
        LongCardModel * modelThree = self.robotCardArray[i+2];
        LongCardModel * modelFour = self.robotCardArray[i+3];
        if (modelOne.grade == modelTwo.grade && modelOne.grade == modelThree.grade && modelOne.grade == modelFour.grade) {
            canShow = YES;
            [self robotCardsAnimationWithIndex:i andWithRobotCardsNumber:4];
            break;
        }
    }
    return canShow;
}

//机器人是否有王炸管上
-(BOOL)robotWangZhaGuanShang
{
    BOOL canShow = NO;
    //牌数小于2张肯定没王炸
    if (self.robotCardArray.count<2) {
        return NO;
    }
    LongCardModel * lastModel = [self.robotCardArray lastObject];
    NSInteger robotNum = self.robotCardArray.count;
    LongCardModel * preLastModel = self.robotCardArray[robotNum-2];
    if (lastModel.grade+preLastModel.grade == 33) {
        canShow = YES;
        //[self removeLastZhuoShangPai];
        [self.robotZhuoShangNodeArray removeAllObjects];
        [self.robotZhuoShangNodeArray addObject:self.robotNodeArray[robotNum-2]];
        [self.robotZhuoShangNodeArray addObject:self.robotNodeArray[robotNum-1]];
        [self.prevShowCardArray removeAllObjects];
        [self.prevShowCardArray addObject:preLastModel];
        [self.prevShowCardArray addObject:lastModel];
        [self moveRobotCardsWithNodeArray:self.robotZhuoShangNodeArray];
        [self.robotCardArray removeObjectsInArray:self.prevShowCardArray];
        [self.robotNodeArray removeObjectsInArray:self.robotZhuoShangNodeArray];
        [self updateRobotNodeBuju];
    }
    return canShow;
}

-(NSArray*)cardsForCardIDArray:(NSArray*)idArray
{
    NSMutableArray * mutableArray = [NSMutableArray array];
    for (int i = 0; i<idArray.count; i++) {
        LongCardModel * model = [[LongCardModel alloc] initWithID:[idArray[i] integerValue]];
        [mutableArray addObject:model];
    }
    NSArray* array = [[LongPokerCardTool shareCardTool] sortCardFromMinToMax:mutableArray];
    return array;
}

//根据关卡判断等级
-(NSString*)gradeWithGuanka:(NSInteger)guanka
{
    if (guanka <= 2) {
        return @"1";
    }else if (guanka>2 && guanka<=5){
        return @"2";
    }else if (guanka>5 && guanka<=8){
        return @"3";
    }else if (guanka>8 && guanka<=11){
        return @"4";
    }else if (guanka>11 && guanka<=15){
        return @"5";
    }else{
        return @"6";
    }
}

//退出游戏
-(void)whenOutOfGame
{
    //关闭游戏背景音乐
    [[DDZBackgroundMusic shareBackgroundMusic] gameBackgroundMusicStop];
    [DDZBackgroundMusic shareBackgroundMusic].gameBgPlayer = nil;
    //关闭过关音乐
    [[DDZBackgroundMusic shareBackgroundMusic] gameWinMusicStop];
    [DDZBackgroundMusic shareBackgroundMusic].gameWinPlayer = nil;
    //关闭失败音乐
    [[DDZBackgroundMusic shareBackgroundMusic] gameLoseMusicStop];
    [DDZBackgroundMusic shareBackgroundMusic].gameLosePlayer = nil;
}

//我点击不出的时候机器人响应
-(void)robotResponseMeBuChu
{
    LongCardModel * cardOneModel = self.robotCardArray[0];
    LongCardModel * cardTwoModel = [LongCardModel new];
    LongCardModel * cardThreeModel = [LongCardModel new];;
    LongCardModel * cardFourModel = [LongCardModel new];;
    
    if (self.robotCardArray.count == 2) {
        cardTwoModel = self.robotCardArray[1];
    }else if (self.robotCardArray.count == 3){
        cardTwoModel = self.robotCardArray[1];
        cardThreeModel = self.robotCardArray[2];
    }else if (self.robotCardArray.count >= 4){
        cardTwoModel = self.robotCardArray[1];
        cardThreeModel = self.robotCardArray[2];
        cardFourModel = self.robotCardArray[3];
    }
    //移除robot桌上的牌
    [self removeRobotZhuoShangNodePai];
    
    if (cardOneModel.grade != cardTwoModel.grade) {
        if (![DDGET_CACHE(DDZ_SET_GameMusic) isEqualToString:@"GBYXYX"]){
            [[DDZBackgroundMusic shareBackgroundMusic] danZhangMusicPlay];
        }
        [self.robotZhuoShangNodeArray replaceObjectsInRange:NSMakeRange(0, self.robotZhuoShangNodeArray.count) withObjectsFromArray:[NSArray arrayWithObject:self.robotNodeArray[0]]];
        [self.prevShowCardArray replaceObjectsInRange:NSMakeRange(0, self.prevShowCardArray.count) withObjectsFromArray:[NSArray arrayWithObject:self.robotCardArray[0]]];
        
        [self.robotCardArray removeObjectAtIndex:0];
        [self.robotNodeArray removeObjectAtIndex:0];
    }else{
        if (![DDGET_CACHE(DDZ_SET_GameMusic) isEqualToString:@"GBYXYX"]){
            [[DDZBackgroundMusic shareBackgroundMusic] duoZhangMusicPlay];
        }
        if (cardTwoModel.grade != cardThreeModel.grade) {
            [self.robotZhuoShangNodeArray replaceObjectsInRange:NSMakeRange(0, self.robotZhuoShangNodeArray.count) withObjectsFromArray:@[self.robotNodeArray[0],self.robotNodeArray[1]]];
            [self.prevShowCardArray replaceObjectsInRange:NSMakeRange(0, self.prevShowCardArray.count) withObjectsFromArray:@[cardOneModel,cardTwoModel]];
            [self.robotCardArray removeObjectsInRange:NSMakeRange(0, 2)];
            [self.robotNodeArray removeObjectsInRange:NSMakeRange(0, 2)];
        }else{
            if (cardThreeModel.grade != cardFourModel.grade) {
                [self.robotZhuoShangNodeArray replaceObjectsInRange:NSMakeRange(0, self.robotZhuoShangNodeArray.count) withObjectsFromArray:@[self.robotNodeArray[0],self.robotNodeArray[1],self.robotNodeArray[2]]];
                [self.prevShowCardArray replaceObjectsInRange:NSMakeRange(0, self.prevShowCardArray.count) withObjectsFromArray:@[cardOneModel,cardTwoModel,cardThreeModel]];
                [self.robotCardArray removeObjectsInRange:NSMakeRange(0, 3)];
                [self.robotNodeArray removeObjectsInRange:NSMakeRange(0, 3)];
            }else{
                [self.robotZhuoShangNodeArray replaceObjectsInRange:NSMakeRange(0, self.robotZhuoShangNodeArray.count) withObjectsFromArray:@[self.robotNodeArray[0],self.robotNodeArray[1],self.robotNodeArray[2],self.robotNodeArray[3]]];
                [self.prevShowCardArray replaceObjectsInRange:NSMakeRange(0, self.prevShowCardArray.count) withObjectsFromArray:@[cardOneModel,cardTwoModel,cardThreeModel,cardFourModel]];
                [self.robotCardArray removeObjectsInRange:NSMakeRange(0, 4)];
                [self.robotNodeArray removeObjectsInRange:NSMakeRange(0, 4)];
            }
        }
    }
    //移走robot要出的牌
    [self moveRobotCardsWithNodeArray:self.robotZhuoShangNodeArray];
    
    if (self.robotCardArray.count == 0) {
        //闯关失败
        self.loseJieSuanView.hidden = NO;
        self.userInteractionEnabled = NO;
        self.chuPaiNode.hidden = YES;
        self.buChuNode.hidden = YES;
        [self.yaoBuQiNode removeFromParent];
        if (![DDGET_CACHE(DDZ_SET_GameMusic) isEqualToString:@"GBYXYX"]){
            [[DDZBackgroundMusic shareBackgroundMusic] gameLoseMusicPlay];
        }
    }else{
        //更新robot手牌布局
        [self updateRobotNodeBuju];
    }
    
}

#pragma mark - action
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    for (UITouch * touch in touches) {
        CGPoint touchLocation = [touch locationInNode:self];
        SKNode * node = [self nodeAtPoint:touchLocation];
        
        if ([self.myNodeArray containsObject:node]) {
            CGFloat height = Auto_Height(20)+BIGCARDHEIGHT/2;
            if (node.position.y - height < 0.1) {
                [self.myWillShowNodeArray addObject:node];
                SKAction * action = [SKAction moveTo:CGPointMake(node.position.x, Auto_Height(20)+BIGCARDHEIGHT/2+PAIUP) duration:0.1];
                [node runAction:action];
                for (LongCardModel * model in self.myCardArray) {
                    if ([node.name isEqualToString:model.imageName]) {
                        [self.myWillShowCardArray addObject:model];
                    }
                }
            }else{
                [self.myWillShowNodeArray removeObject:node];
                SKAction * action = [SKAction moveTo:CGPointMake(node.position.x, Auto_Height(20)+BIGCARDHEIGHT/2) duration:0.1];
                [node runAction:action];
                for (LongCardModel * model in self.myCardArray) {
                    if ([node.name isEqualToString:model.imageName]) {
                        [self.myWillShowCardArray removeObject:model];
                    }
                }
            }
            if (![DDGET_CACHE(DDZ_SET_GameMusic) isEqualToString:@"GBYXYX"]) {
                [[DDZBackgroundMusic shareBackgroundMusic] choiceCardMusicPlay];
            }
        }
        
        if ([node.name isEqualToString:@"chuPai"]) {
            if (![DDGET_CACHE(DDZ_SET_GameMusic) isEqualToString:@"GBYXYX"]){
                [[DDZBackgroundMusic shareBackgroundMusic] clickMusicPlay];
            }
            if ([[LongPokerCardTool shareCardTool] isCanShowMyCards:self.myWillShowCardArray andPrevCards:self.prevShowCardArray]) {
                //能管上时用户在机器人响应前不能点牌
                self.userInteractionEnabled = NO;
                //播放出牌音效
                if (![DDGET_CACHE(DDZ_SET_GameMusic) isEqualToString:@"GBYXYX"]) {
                    if (self.myWillShowCardArray.count == 1) {
                        [[DDZBackgroundMusic shareBackgroundMusic] danZhangMusicPlay];
                    }else{
                        [[DDZBackgroundMusic shareBackgroundMusic] duoZhangMusicPlay];
                    }
                }
                //隐藏要不起、出牌、不要等按钮
                self.chuPaiNode.hidden = YES;
                self.buChuNode.hidden = YES;
                self.yaoBuQiNode.hidden = YES;
                //移除robot桌上的牌
                [self removeRobotZhuoShangNodePai];
                //移除自己桌上的牌
                [self removeMyZhuoShangNodePai];
                //移动出掉牌
                CGFloat outPointx = (self.size.width-SPACESMALL*(self.myWillShowNodeArray.count-1)-SMALLCARDWIDE)/2;
                //出去的牌按位置从左到右排序
                //冒泡排序
                for (int i=0; i<self.myWillShowNodeArray.count; i++) {
                    for (int j=0; j<self.myWillShowNodeArray.count-1-i; j++) {
                        SKSpriteNode * node1 = self.myWillShowNodeArray[j];
                        SKSpriteNode * node2 = self.myWillShowNodeArray[j+1];
                        if (node1.position.x > node2.position.x) {
                            [self.myWillShowNodeArray exchangeObjectAtIndex:j withObjectAtIndex:j+1];
                        }
                    }
                }
                
                for (int i = 0; i<self.myWillShowNodeArray.count; i++) {
                    SKNode * node = self.myWillShowNodeArray[i];
                    SKAction * moveAction = [SKAction moveTo:CGPointMake(outPointx+SMALLCARDWIDE/2+SPACESMALL*i, Auto_Height(20)+BIGCARDHEIGHT+Auto_Height(10)+SMALLCARDHEIGHT/2) duration:0.1];
                    SKAction * scaleAction = [SKAction scaleTo:0.75 duration:0.1];
                    [node runAction:[SKAction group:@[moveAction,scaleAction]]];
                }

                //我的桌上的牌
                [self.myZhuoShangNodeArray replaceObjectsInRange:NSMakeRange(0, self.myZhuoShangNodeArray.count) withObjectsFromArray:self.myWillShowNodeArray];
                
                
                [self.myCardArray removeObjectsInArray:self.myWillShowCardArray];
                [self.myNodeArray removeObjectsInArray:self.myWillShowNodeArray];
                if (self.myCardArray.count == 0) {//过关
                    self.winJieSuanView.hidden = NO;
                    self.userInteractionEnabled = NO;
                    //播放过关音效
                    if (![DDGET_CACHE(DDZ_SET_GameMusic) isEqualToString:@"GBYXYX"]){
                        [[DDZBackgroundMusic shareBackgroundMusic] gameWinMusicPlay];
                    }
                    NSInteger choiceNumber = [AppDelegate shareDelegate].paipuNumber;
                    NSInteger currentNuber = [DDGET_CACHE(DDZ_CURRENT_NUMBER) integerValue];
                    if (choiceNumber == currentNuber) {
                        NSString * guanka = [NSString stringWithFormat:@"%ld",[AppDelegate shareDelegate].paipuNumber+1];
                        DDSET_CACHE(guanka, DDZ_CURRENT_NUMBER)
                        NSString * grade = [NSString stringWithFormat:@"%ld",[AppDelegate shareDelegate].gradeNum];
                        DDSET_CACHE(grade, DDZ_CURRENT_GRADE)
                    }
                    
                }else{
                    //更新我的手牌布局
                    [self updateMyNodeBuju];
                    //机器人响应我的出牌
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.7 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [self showRobotCardsWithMyShowCards:self.myWillShowCardArray];
                        self.userInteractionEnabled = YES;
                        [self.myWillShowNodeArray removeAllObjects];
                        [self.myWillShowCardArray removeAllObjects];
                    });
                }
            }else{
                NSLog(@"牌型不符合规则~");
                for (SKNode * node in self.myWillShowNodeArray) {
                    SKAction * action = [SKAction moveTo:CGPointMake(node.position.x, Auto_Height(20)+BIGCARDHEIGHT/2) duration:0.1];
                    [node runAction:action];
                }
                [self.myWillShowNodeArray removeAllObjects];
                [self.myWillShowCardArray removeAllObjects];
            }
        }
        
        if ([node.name isEqualToString:@"buChu"]) {
            self.userInteractionEnabled = NO;
            self.yaoBuQiNode.hidden = YES;
            self.buChuNode.hidden = YES;
            self.chuPaiNode.hidden = YES;
            if (![DDGET_CACHE(DDZ_SET_GameMusic) isEqualToString:@"GBYXYX"]){
                [[DDZBackgroundMusic shareBackgroundMusic] buYaoMusicPlay];
            }
            
            //点不要后机器人出牌
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.7 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self robotResponseMeBuChu];
                self.userInteractionEnabled = YES;
                if ([self myCardCanHitRobotShowCard:self.prevShowCardArray]) {
                    //我的牌能管上
                    self.chuPaiNode.hidden = NO;
                    self.buChuNode.hidden = NO;
                    self.yaoBuQiNode.hidden = YES;
                }else{
                    self.chuPaiNode.hidden = YES;
                    self.buChuNode.hidden = YES;
                    self.yaoBuQiNode.hidden = NO;
                }
            });
        }
        
        if ([node.name isEqualToString:@"fanHui"]) {
            if (![DDGET_CACHE(DDZ_SET_GameMusic) isEqualToString:@"GBYXYX"]){
                [[DDZBackgroundMusic shareBackgroundMusic] clickMusicPlay];
            }
            self.userInteractionEnabled = NO;
            DDWeakSelf
            [self.popupView addChallengeTipsText:@"您確定要放棄本場考試嗎？" block:^(BOOL isSuc) {
                if (isSuc) {
                    weakSelf.exitTheSceneBlock();
                    [weakSelf whenOutOfGame];
                }else{
                    weakSelf.userInteractionEnabled = YES;
                }
                weakSelf.popupView = nil;
                
            }];
            
        }
        
        if ([node.name isEqualToString:@"setting"]) {
            if (![DDGET_CACHE(DDZ_SET_GameMusic) isEqualToString:@"GBYXYX"]){
                [[DDZBackgroundMusic shareBackgroundMusic] clickMusicPlay];
            }
            [[DDPopupGameSet initClient] showGameSetViewBlock:^{
                
            }];
        }
    }
}

#pragma mark - 判断我手上的牌有没有大过robot的牌
-(BOOL)myCardCanHitRobotShowCard:(NSArray<LongCardModel*>*)robotShowCardsArray
{
    if ([self myCardWangZhaGuanShang]) {
        return YES;
    }
    BOOL iCanHit = NO;
    ShowCardsType type = [[LongPokerCardTool shareCardTool] getCardsType:robotShowCardsArray];
    switch (type) {
        case CardsType_Dan:
            {
                LongCardModel * model = robotShowCardsArray[0];
                for (int i = 0; i<self.myCardArray.count; i++) {
                    LongCardModel * myModel = self.myCardArray[i];
                    if (myModel.grade>model.grade) {
                        iCanHit = YES;
                        break;
                    }
                }
                if (!iCanHit) {
                    iCanHit = [self myCardZhaDanGuanShang];
                }
            }
            break;
        case CardsType_DuiZi:
        {
            LongCardModel * model = robotShowCardsArray[0];
            for (int i = 0; i+1<self.myCardArray.count; i++) {
                LongCardModel * modelOne = self.myCardArray[i];
                LongCardModel * modelTwo = self.myCardArray[i+1];
                if (modelOne.grade == modelTwo.grade && modelOne.grade>model.grade) {
                    iCanHit = YES;
                    break;
                }
            }
            if (!iCanHit) {
                iCanHit = [self myCardZhaDanGuanShang];
            }
        }
            break;
        case CardsType_WangZha:
        {
            iCanHit = NO;
        }
            break;
        case CardsType_ZhaDan:
        {
            LongCardModel * model = robotShowCardsArray[0];
            for (int i = 0; i+3<self.myCardArray.count; i++) {
                LongCardModel * modelOne = self.myCardArray[i];
                LongCardModel * modelTwo = self.myCardArray[i+1];
                LongCardModel * modelThree = self.myCardArray[i+2];
                LongCardModel * modelFour = self.myCardArray[i+3];
                if (modelOne.grade == modelTwo.grade && modelOne.grade == modelThree.grade && modelOne.grade == modelFour.grade && modelOne.grade > model.grade) {
                    iCanHit = YES;
                    [self robotCardsAnimationWithIndex:i andWithRobotCardsNumber:4];
                    break;
                }
            }
        }
            break;
        case CardsType_SanBuDai:
        {
            LongCardModel * model = robotShowCardsArray[0];
            for (int i = 0; i+2<self.myCardArray.count; i++) {
                LongCardModel * modelOne = self.myCardArray[i];
                LongCardModel * modelTwo = self.myCardArray[i+1];
                LongCardModel * modelThree = self.myCardArray[i+2];
                if (modelOne.grade == modelTwo.grade && modelOne.grade == modelThree.grade && modelOne.grade > model.grade) {
                    iCanHit = YES;
                    break;
                }
            }
            //是否有炸弹
            if (!iCanHit) {
                iCanHit = [self myCardZhaDanGuanShang];
            }
        }
            break;
        case CardsType_SanDaiYi:
        {
            LongCardModel * model = robotShowCardsArray[1];
            for (int i = 0; i+2<self.myCardArray.count; i++) {
                LongCardModel * modelOne = self.myCardArray[i];
                LongCardModel * modelTwo = self.myCardArray[i+1];
                LongCardModel * modelThree = self.myCardArray[i+2];
                if (modelOne.grade == modelTwo.grade && modelOne.grade == modelThree.grade && modelOne.grade > model.grade){
                    if (self.myCardArray.count>=4) {
                        iCanHit = YES;
                    }
                }
            }
            //是否有炸弹
            if (!iCanHit) {
                iCanHit = [self myCardZhaDanGuanShang];
            }
        }
            break;
        case CardsType_SanDaiDui:
        {
            LongCardModel * model = robotShowCardsArray[2];
            for (int i = 0; i+2<self.myCardArray.count; i++) {
                if (iCanHit) {
                    break;
                }
                LongCardModel * modelOne = self.myCardArray[i];
                LongCardModel * modelTwo = self.myCardArray[i+1];
                LongCardModel * modelThree = self.myCardArray[i+2];
                if (modelOne.grade == modelTwo.grade && modelOne.grade == modelThree.grade && modelOne.grade > model.grade){
                    for (int j = 0; j+1<self.robotCardArray.count; j++) {
                        LongCardModel * model1 = self.robotCardArray[j];
                        LongCardModel * model2 = self.robotCardArray[j+1];
                        if (model1.grade == model2.grade && model1.grade != modelOne.grade) {
                            iCanHit = YES;
                            break;
                        }
                    }
                }
            }
            //是否有炸弹
            if (!iCanHit) {
                iCanHit = [self myCardWangZhaGuanShang];
            }
        }
            break;
        case CardsType_SunZi:
        {
            //残局如果顺子被管上，我就没有顺子能管上了
            if (!iCanHit) {
                iCanHit = [self myCardZhaDanGuanShang];
            }
        }
            break;
        case CardsType_LianDui:
        {
            //残局如果连对被管上，我就没有连对能管上了
            if (!iCanHit) {
                iCanHit = [self myCardZhaDanGuanShang];
            }
        }
            break;
        case CardsType_FeiJiBuDai:
        {
            //残局如果飞机被管上，我就没有飞机能管上了
            if (!iCanHit) {
                iCanHit = [self myCardZhaDanGuanShang];
            }
        }
            break;
        case CardsType_FeiJiDaiDanZhang:
        {
            //残局如果飞机被管上，我就没有飞机能管上了
            if (!iCanHit) {
                iCanHit = [self myCardZhaDanGuanShang];
            }
        }
            break;
        case CardsType_FeiJiDaiDuiZi:
        {
            //残局如果飞机被管上，我就没有飞机能管上了
            if (!iCanHit) {
                iCanHit = [self myCardZhaDanGuanShang];
            }
        }
            break;
        case CardsType_SiDaiLiangDanZhang:
        {
            //残局如果四带二被管上，我就没有四带二能管上了
            if (!iCanHit) {
                iCanHit = [self myCardZhaDanGuanShang];
            }
        }
            break;
        case CardsType_SiDaiLiangDuiZi:
        {
            //残局如果四带二被管上，我就没有四带二能管上了
            if (!iCanHit) {
                iCanHit = [self myCardZhaDanGuanShang];
            }
        }
            break;
            
        default:
            break;
    }
    return iCanHit;
}

#pragma mark - robot响应玩家出牌
-(void)showRobotCardsWithMyShowCards:(NSArray<LongCardModel*>*)myShowCardsArray
{
    //robot是否要得起我出的牌
    BOOL robotCanHit = NO;
    //只要robot响应，就除我桌上的牌
    [self removeMyZhuoShangNodePai];
    
    ShowCardsType type = [[LongPokerCardTool shareCardTool] getCardsType:myShowCardsArray];
    switch (type) {
        case CardsType_Dan:
        {
            LongCardModel * model = myShowCardsArray[0];
            BOOL  canShow = NO;
            for (int i = 0; i<self.robotCardArray.count; i++) {
                LongCardModel * robotModel = self.robotCardArray[i];
                if (robotModel.grade>model.grade) {
                    canShow = YES;
                    [self robotCardsAnimationWithIndex:i andWithRobotCardsNumber:1];
                    break;
                }
            }
            //是否有炸弹
            if (!canShow) {
                canShow = [self robotZhaDanGuanShang];
            }
            //是否有王炸
            if (!canShow) {
                canShow = [self robotWangZhaGuanShang];
            }
//            if (!canShow) {
//                NSLog(@"机器人要不起单张");
//                [self.prevShowCardArray removeAllObjects];
//            }
            robotCanHit = canShow;
        }
            break;
        case CardsType_DuiZi:
        {
            LongCardModel * model = myShowCardsArray[0];
            BOOL  canShow = NO;
            for (int i = 0; i+1<self.robotCardArray.count; i++) {
                LongCardModel * modelOne = self.robotCardArray[i];
                LongCardModel * modelTwo = self.robotCardArray[i+1];
                if (modelOne.grade == modelTwo.grade && modelOne.grade>model.grade) {
                    canShow = YES;
                    //更新数组，更新布局
                    [self robotCardsAnimationWithIndex:i andWithRobotCardsNumber:2];
                    break;
            }
        }
            //是否有炸弹
            if (!canShow) {
                canShow = [self robotZhaDanGuanShang];
            }
            //是否有王炸
            if (!canShow) {
                canShow = [self robotWangZhaGuanShang];
            }
//            if (!canShow) {
//                NSLog(@"机器人要不起对子");
//                [self.prevShowCardArray removeAllObjects];
//            }
            robotCanHit = canShow;
        }
            break;
        case CardsType_WangZha:
        {
            NSLog(@"机器人要不起王炸");
            robotCanHit = NO;
            //[self.prevShowCardArray removeAllObjects];
        }
            break;
        case CardsType_ZhaDan:
        {
            LongCardModel * model = myShowCardsArray[0];
            BOOL  canShow = NO;
            for (int i = 0; i+3<self.robotCardArray.count; i++) {
                LongCardModel * modelOne = self.robotCardArray[i];
                LongCardModel * modelTwo = self.robotCardArray[i+1];
                LongCardModel * modelThree = self.robotCardArray[i+2];
                LongCardModel * modelFour = self.robotCardArray[i+3];
                if (modelOne.grade == modelTwo.grade && modelOne.grade == modelThree.grade && modelOne.grade == modelFour.grade && modelOne.grade > model.grade) {
                    canShow = YES;
                    [self robotCardsAnimationWithIndex:i andWithRobotCardsNumber:4];
                    break;
                }
            }
            //是否有王炸
            if (!canShow) {
                canShow = [self robotWangZhaGuanShang];
            }
//            if (!canShow) {
//                NSLog(@"机器人要不起炸弹");
//                [self.prevShowCardArray removeAllObjects];
//            }
            robotCanHit = canShow;
        }
            break;
        case CardsType_SanBuDai:
        {
            LongCardModel * model = myShowCardsArray[0];
            BOOL canShow = NO;
            for (int i = 0; i+2<self.robotCardArray.count; i++) {
                LongCardModel * modelOne = self.robotCardArray[i];
                LongCardModel * modelTwo = self.robotCardArray[i+1];
                LongCardModel * modelThree = self.robotCardArray[i+2];
                if (modelOne.grade == modelTwo.grade && modelOne.grade == modelThree.grade && modelOne.grade > model.grade) {
                    canShow = YES;
                    [self robotCardsAnimationWithIndex:i andWithRobotCardsNumber:3];
                    break;
                }
            }
            //是否有炸弹
            if (!canShow) {
                canShow = [self robotZhaDanGuanShang];
            }
            //是否有王炸
            if (!canShow) {
                canShow = [self robotWangZhaGuanShang];
            }
//            if (!canShow) {
//                NSLog(@"机器人要不起三不带");
//                [self.prevShowCardArray removeAllObjects];
//            }
            robotCanHit = canShow;
        }
            break;
        case CardsType_SanDaiYi:
        {
            LongCardModel * model = myShowCardsArray[1];
            BOOL canShow = NO;
            for (int i = 0; i+2<self.robotCardArray.count; i++) {
                LongCardModel * modelOne = self.robotCardArray[i];
                LongCardModel * modelTwo = self.robotCardArray[i+1];
                LongCardModel * modelThree = self.robotCardArray[i+2];
                if (modelOne.grade == modelTwo.grade && modelOne.grade == modelThree.grade && modelOne.grade > model.grade){
                    if (i==0) {
                        if (self.robotCardArray.count>=4) {
                            canShow = YES;
                            [self robotCardsAnimationWithIndex:i andWithRobotCardsNumber:4];
                        }
                    }else{
                        canShow = YES;
                        NSMutableArray * mutableNodeArray = [NSMutableArray arrayWithArray:[self.robotNodeArray subarrayWithRange:NSMakeRange(i, 3)]];
                        [mutableNodeArray insertObject:self.robotNodeArray[0] atIndex:0];
                        
                        NSMutableArray * mutableCardArray = [NSMutableArray arrayWithArray:[self.robotCardArray subarrayWithRange:NSMakeRange(i, 3)]];
                        [mutableCardArray insertObject:self.robotCardArray[0] atIndex:0];
                        
                        [self.robotZhuoShangNodeArray replaceObjectsInRange:NSMakeRange(0, self.robotZhuoShangNodeArray.count) withObjectsFromArray:mutableNodeArray];
                        //移走robot要出的牌
                        [self moveRobotCardsWithNodeArray:mutableNodeArray];
                        //更新上一手机器人出的牌
                        [self.prevShowCardArray replaceObjectsInRange:NSMakeRange(0, self.prevShowCardArray.count) withObjectsFromArray:mutableCardArray];
                        
                        [self.robotCardArray removeObjectsInArray:mutableCardArray];
                        [self.robotNodeArray removeObjectsInArray:mutableNodeArray];
                        
                        //更新robot手牌布局
                        [self updateRobotNodeBuju];
                        break;
                    }
                }
            }
            //是否有炸弹
            if (!canShow) {
                canShow = [self robotZhaDanGuanShang];
            }
            //是否有王炸
            if (!canShow) {
                canShow = [self robotWangZhaGuanShang];
            }
//            if (!canShow) {
//                NSLog(@"机器人要不起三带一");
//                [self.prevShowCardArray removeAllObjects];
//            }
            robotCanHit = canShow;
        }
            break;
        case CardsType_SanDaiDui:
        {
            LongCardModel * model = myShowCardsArray[2];
            BOOL canShow = NO;
            
            for (int i = 0; i+2<self.robotCardArray.count; i++) {
                if (canShow) {
                    break;
                }
                LongCardModel * modelOne = self.robotCardArray[i];
                LongCardModel * modelTwo = self.robotCardArray[i+1];
                LongCardModel * modelThree = self.robotCardArray[i+2];
                if (modelOne.grade == modelTwo.grade && modelOne.grade == modelThree.grade && modelOne.grade > model.grade){
                    for (int j = 0; j+1<self.robotCardArray.count; j++) {
                        LongCardModel * model1 = self.robotCardArray[j];
                        LongCardModel * model2 = self.robotCardArray[j+1];
                        if (model1.grade == model2.grade && model1.grade != modelOne.grade) {
                            canShow = YES;
                            
                            //更新桌上的牌
                            [self.robotZhuoShangNodeArray removeAllObjects];
                            [self.robotZhuoShangNodeArray addObjectsFromArray:[self.robotNodeArray subarrayWithRange:NSMakeRange(i, 3)]];
                            [self.robotZhuoShangNodeArray addObjectsFromArray:[self.robotNodeArray subarrayWithRange:NSMakeRange(j, 2)]];
                            //冒泡排序
                            for (int a=0; a<self.robotZhuoShangNodeArray.count; a++) {
                                for (int b=0; b<self.robotZhuoShangNodeArray.count-1-a; b++) {
                                    SKSpriteNode * node1 = self.robotZhuoShangNodeArray[b];
                                    SKSpriteNode * node2 = self.robotZhuoShangNodeArray[b+1];
                                    if (node1.position.x > node2.position.x) {
                                        [self.robotZhuoShangNodeArray exchangeObjectAtIndex:b withObjectAtIndex:b+1];
                                    }
                                }
                            }
                            
                            //更新机器人上一轮出的牌
                            [self.prevShowCardArray removeAllObjects];
                            [self.prevShowCardArray addObjectsFromArray:[self.robotCardArray subarrayWithRange:NSMakeRange(i, 3)]];
                            [self.prevShowCardArray addObjectsFromArray:[self.robotCardArray subarrayWithRange:NSMakeRange(j, 2)]];
                            //移动robot要出的牌
                            [self moveRobotCardsWithNodeArray:self.robotZhuoShangNodeArray];
                            //更新机器人cardArray和nodeArray
                            [self.robotCardArray removeObjectsInArray:self.prevShowCardArray];
                            [self.robotNodeArray removeObjectsInArray:self.robotZhuoShangNodeArray];
                            //更新机器人手牌布局
                            [self updateRobotNodeBuju];
                            break;
                        }
                    }
                }
            }
        
            //是否有炸弹
            if (!canShow) {
                canShow = [self robotZhaDanGuanShang];
            }
            //是否有王炸
            if (!canShow) {
                canShow = [self robotWangZhaGuanShang];
            }
//            if (!canShow) {
//                NSLog(@"机器人要不起三带一");
//                [self.prevShowCardArray removeAllObjects];
//            }
            robotCanHit = canShow;
        }
            break;
        case CardsType_SunZi:
        {
            LongCardModel * model = myShowCardsArray[0];
            BOOL canShow = NO;
            for (int i=0; i<self.robotCardArray.count; i++) {
                if (canShow) {
                    break;
                }
                LongCardModel * model1 = self.robotCardArray[i];
                if (model1.grade > model.grade) {
                    for (int j=0; j<self.robotCardArray.count; j++) {
                        if (canShow) {
                            break;
                        }
                        LongCardModel * model2 = self.robotCardArray[j];
                        if (model2.grade-model1.grade==1) {
                            for (int m=0; m<self.robotCardArray.count; m++) {
                                if (canShow) {
                                    break;
                                }
                                LongCardModel * model3 = self.robotCardArray[m];
                                if (model3.grade-model2.grade==1) {
                                    for (int n=0; n<self.robotCardArray.count; n++) {
                                        if (canShow) {
                                            break;
                                        }
                                        LongCardModel * model4 = self.robotCardArray[n];
                                        if (model4.grade-model3.grade==1) {
                                            for (int x=0; x<self.robotCardArray.count; x++) {
                                                if (canShow) {
                                                    break;
                                                }
                                                LongCardModel * model5 = self.robotCardArray[x];
                                                if (model5.grade-model4.grade==1 && model5.grade<=14) {
                                                    if (myShowCardsArray.count == 5) {
                                                        canShow = YES;

                                                        //更新桌上的牌
                                                        [self.robotZhuoShangNodeArray removeAllObjects];
                                                        [self.robotZhuoShangNodeArray addObject:self.robotNodeArray[i]];
                                                        [self.robotZhuoShangNodeArray addObject:self.robotNodeArray[j]];
                                                        [self.robotZhuoShangNodeArray addObject:self.robotNodeArray[m]];
                                                        [self.robotZhuoShangNodeArray addObject:self.robotNodeArray[n]];
                                                        [self.robotZhuoShangNodeArray addObject:self.robotNodeArray[x]];
                                                        //更新机器人上一轮出的牌
                                                        [self.prevShowCardArray removeAllObjects];
                                                        [self.prevShowCardArray addObject:self.robotCardArray[i]];
                                                        [self.prevShowCardArray addObject:self.robotCardArray[j]];
                                                        [self.prevShowCardArray addObject:self.robotCardArray[m]];
                                                        [self.prevShowCardArray addObject:self.robotCardArray[n]];
                                                        [self.prevShowCardArray addObject:self.robotCardArray[x]];
                                                        //移动robot要出的牌
                                                        [self moveRobotCardsWithNodeArray:self.robotZhuoShangNodeArray];
                                                        //更新机器人cardArray和nodeArray
                                                        [self.robotCardArray removeObjectsInArray:self.prevShowCardArray];
                                                        [self.robotNodeArray removeObjectsInArray:self.robotZhuoShangNodeArray];
                                                        //更新robot手牌布局
                                                        [self updateRobotNodeBuju];
                                                        break;
                                                    }
                                                    for (int y=0; y<self.robotCardArray.count; y++) {
                                                        if (canShow) {
                                                            break;
                                                        }
                                                        LongCardModel * model6 = self.robotCardArray[y];
                                                        if (model6.grade-model5.grade==1 && model6.grade<=14) {
                                                            if (myShowCardsArray.count == 6) {
                                                                canShow = YES;

                                                                //更新robot桌上的牌
                                                                [self.robotZhuoShangNodeArray removeAllObjects];
                                                                [self.robotZhuoShangNodeArray addObject:self.robotNodeArray[i]];
                                                                [self.robotZhuoShangNodeArray addObject:self.robotNodeArray[j]];
                                                                [self.robotZhuoShangNodeArray addObject:self.robotNodeArray[m]];
                                                                [self.robotZhuoShangNodeArray addObject:self.robotNodeArray[n]];
                                                                [self.robotZhuoShangNodeArray addObject:self.robotNodeArray[x]];
                                                                [self.robotZhuoShangNodeArray addObject:self.robotNodeArray[y]];
                                                                //更新robot上一轮出的牌
                                                                [self.prevShowCardArray removeAllObjects];
                                                                [self.prevShowCardArray addObject:self.robotCardArray[i]];
                                                                [self.prevShowCardArray addObject:self.robotCardArray[j]];
                                                                [self.prevShowCardArray addObject:self.robotCardArray[m]];
                                                                [self.prevShowCardArray addObject:self.robotCardArray[n]];
                                                                [self.prevShowCardArray addObject:self.robotCardArray[x]];
                                                                [self.prevShowCardArray addObject:self.robotCardArray[y]];
                                                                //移动robot要出的牌
                                                                [self moveRobotCardsWithNodeArray:self.robotZhuoShangNodeArray];
                                                                //更新robot cardArray和nodeArray
                                                                [self.robotCardArray removeObjectsInArray:self.prevShowCardArray];
                                                                [self.robotNodeArray removeObjectsInArray:self.robotZhuoShangNodeArray];
                                                                //更新robot手牌布局
                                                                [self updateRobotNodeBuju];
                                                                break;
                                                            }
                                                            for (int z=0; z<self.robotCardArray.count; z++) {
                                                                if (canShow) {
                                                                    break;
                                                                }
                                                                LongCardModel * model7 = self.robotCardArray[z];
                                                                if (model7.grade-model6.grade==1 && model7.grade<=14) {
                                                                    if (myShowCardsArray.count == 7) {
                                                                        canShow = YES;

                                                                        //更新robot桌上的牌
                                                                        [self.robotZhuoShangNodeArray removeAllObjects];
                                                                        [self.robotZhuoShangNodeArray addObject:self.robotNodeArray[i]];
                                                                        [self.robotZhuoShangNodeArray addObject:self.robotNodeArray[j]];
                                                                        [self.robotZhuoShangNodeArray addObject:self.robotNodeArray[m]];
                                                                        [self.robotZhuoShangNodeArray addObject:self.robotNodeArray[n]];
                                                                        [self.robotZhuoShangNodeArray addObject:self.robotNodeArray[x]];
                                                                        [self.robotZhuoShangNodeArray addObject:self.robotNodeArray[y]];
                                                                        [self.robotZhuoShangNodeArray addObject:self.robotNodeArray[z]];
                                                                        //更新robot上一轮出的牌
                                                                        [self.prevShowCardArray removeAllObjects];
                                                                        [self.prevShowCardArray addObject:self.robotCardArray[i]];
                                                                        [self.prevShowCardArray addObject:self.robotCardArray[j]];
                                                                        [self.prevShowCardArray addObject:self.robotCardArray[m]];
                                                                        [self.prevShowCardArray addObject:self.robotCardArray[n]];
                                                                        [self.prevShowCardArray addObject:self.robotCardArray[x]];
                                                                        [self.prevShowCardArray addObject:self.robotCardArray[y]];
                                                                        [self.prevShowCardArray addObject:self.robotCardArray[z]];
                                                                        //移动robot要出的牌
                                                                        [self moveRobotCardsWithNodeArray:self.robotZhuoShangNodeArray];
                                                                        //更新robot cardArray和nodeArray
                                                                        [self.robotCardArray removeObjectsInArray:self.prevShowCardArray];
                                                                        [self.robotNodeArray removeObjectsInArray:self.robotZhuoShangNodeArray];
                                                                        //更新robot手牌布局
                                                                        [self updateRobotNodeBuju];
                                                                        break;
                                                                    }
                                                                    for (int a=0; a<self.robotCardArray.count; a++) {
                                                                        if (canShow) {
                                                                            break;
                                                                        }
                                                                        LongCardModel * model8 = self.robotCardArray[a];
                                                                        if (model8.grade-model7.grade==1 && model8.grade<=14) {
                                                                            if (myShowCardsArray.count == 8) {
                                                                                canShow = YES;

                                                                                //更新robot桌上的牌
                                                                                [self.robotZhuoShangNodeArray removeAllObjects];
                                                                                [self.robotZhuoShangNodeArray addObject:self.robotNodeArray[i]];
                                                                                [self.robotZhuoShangNodeArray addObject:self.robotNodeArray[j]];
                                                                                [self.robotZhuoShangNodeArray addObject:self.robotNodeArray[m]];
                                                                                [self.robotZhuoShangNodeArray addObject:self.robotNodeArray[n]];
                                                                                [self.robotZhuoShangNodeArray addObject:self.robotNodeArray[x]];
                                                                                [self.robotZhuoShangNodeArray addObject:self.robotNodeArray[y]];
                                                                                [self.robotZhuoShangNodeArray addObject:self.robotNodeArray[z]];
                                                                                [self.robotZhuoShangNodeArray addObject:self.robotNodeArray[a]];
                                                                                //更新robot上一轮出的牌
                                                                                [self.prevShowCardArray removeAllObjects];
                                                                                [self.prevShowCardArray addObject:self.robotCardArray[i]];
                                                                                [self.prevShowCardArray addObject:self.robotCardArray[j]];
                                                                                [self.prevShowCardArray addObject:self.robotCardArray[m]];
                                                                                [self.prevShowCardArray addObject:self.robotCardArray[n]];
                                                                                [self.prevShowCardArray addObject:self.robotCardArray[x]];
                                                                                [self.prevShowCardArray addObject:self.robotCardArray[y]];
                                                                                [self.prevShowCardArray addObject:self.robotCardArray[z]];
                                                                                [self.prevShowCardArray addObject:self.robotCardArray[a]];
                                                                                //移动robot要出的牌
                                                                                [self moveRobotCardsWithNodeArray:self.robotZhuoShangNodeArray];
                                                                                //更新robot cardArray和nodeArray
                                                                                [self.robotCardArray removeObjectsInArray:self.prevShowCardArray];
                                                                                [self.robotNodeArray removeObjectsInArray:self.robotZhuoShangNodeArray];
                                                                                //更新robot手牌布局
                                                                                [self updateRobotNodeBuju];
                                                                                break;
                                                                            }
                                                                            for (int b=0; b<self.robotCardArray.count; b++) {
                                                                                if (canShow) {
                                                                                    break;
                                                                                }
                                                                                LongCardModel * model9 = self.robotCardArray[b];
                                                                                if (model9.grade-model8.grade==1 && model9.grade<=14) {
                                                                                    if (myShowCardsArray.count == 9) {
                                                                                        canShow = YES;
                                                                                        
                                                                                        //更新robot桌上的牌
                                                                                        [self.robotZhuoShangNodeArray removeAllObjects];
                                                                                        [self.robotZhuoShangNodeArray addObject:self.robotNodeArray[i]];
                                                                                        [self.robotZhuoShangNodeArray addObject:self.robotNodeArray[j]];
                                                                                        [self.robotZhuoShangNodeArray addObject:self.robotNodeArray[m]];
                                                                                        [self.robotZhuoShangNodeArray addObject:self.robotNodeArray[n]];
                                                                                        [self.robotZhuoShangNodeArray addObject:self.robotNodeArray[x]];
                                                                                        [self.robotZhuoShangNodeArray addObject:self.robotNodeArray[y]];
                                                                                        [self.robotZhuoShangNodeArray addObject:self.robotNodeArray[z]];
                                                                                        [self.robotZhuoShangNodeArray addObject:self.robotNodeArray[a]];
                                                                                        [self.robotZhuoShangNodeArray addObject:self.robotNodeArray[b]];
                                                                                        //更新robot上一轮出的牌
                                                                                        [self.prevShowCardArray removeAllObjects];
                                                                                        [self.prevShowCardArray addObject:self.robotCardArray[i]];
                                                                                        [self.prevShowCardArray addObject:self.robotCardArray[j]];
                                                                                        [self.prevShowCardArray addObject:self.robotCardArray[m]];
                                                                                        [self.prevShowCardArray addObject:self.robotCardArray[n]];
                                                                                        [self.prevShowCardArray addObject:self.robotCardArray[x]];
                                                                                        [self.prevShowCardArray addObject:self.robotCardArray[y]];
                                                                                        [self.prevShowCardArray addObject:self.robotCardArray[z]];
                                                                                        [self.prevShowCardArray addObject:self.robotCardArray[a]];
                                                                                        [self.prevShowCardArray addObject:self.robotCardArray[b]];
                                                                                        //移动robot要出的牌
                                                                                        [self moveRobotCardsWithNodeArray:self.robotZhuoShangNodeArray];
                                                                                        //更新robot cardArray和nodeArray
                                                                                        [self.robotCardArray removeObjectsInArray:self.prevShowCardArray];
                                                                                        [self.robotNodeArray removeObjectsInArray:self.robotZhuoShangNodeArray];
                                                                                        //更新robot手牌布局
                                                                                        [self updateRobotNodeBuju];
                                                                                        break;
                                                                                    }
                                                                                    for (int c=0; c<self.robotCardArray.count; c++) {
                                                                                        if (canShow) {
                                                                                            break;
                                                                                        }
                                                                                        LongCardModel * model10 = self.robotCardArray[c];
                                                                                        if (model10.grade-model9.grade==1 && model10.grade<=14) {
                                                                                            if (myShowCardsArray.count == 10) {
                                                                                                canShow = YES;

                                                                                                //更新robot桌上的牌
                                                                                                [self.robotZhuoShangNodeArray removeAllObjects];
                                                                                                [self.robotZhuoShangNodeArray addObject:self.robotNodeArray[i]];
                                                                                                [self.robotZhuoShangNodeArray addObject:self.robotNodeArray[j]];
                                                                                                [self.robotZhuoShangNodeArray addObject:self.robotNodeArray[m]];
                                                                                                [self.robotZhuoShangNodeArray addObject:self.robotNodeArray[n]];
                                                                                                [self.robotZhuoShangNodeArray addObject:self.robotNodeArray[x]];
                                                                                                [self.robotZhuoShangNodeArray addObject:self.robotNodeArray[y]];
                                                                                                [self.robotZhuoShangNodeArray addObject:self.robotNodeArray[z]];
                                                                                                [self.robotZhuoShangNodeArray addObject:self.robotNodeArray[a]];
                                                                                                [self.robotZhuoShangNodeArray addObject:self.robotNodeArray[b]];
                                                                                                [self.robotZhuoShangNodeArray addObject:self.robotNodeArray[c]];
                                                                                                //更新robot上一轮出的牌
                                                                                                [self.prevShowCardArray removeAllObjects];
                                                                                                [self.prevShowCardArray addObject:self.robotCardArray[i]];
                                                                                                [self.prevShowCardArray addObject:self.robotCardArray[j]];
                                                                                                [self.prevShowCardArray addObject:self.robotCardArray[m]];
                                                                                                [self.prevShowCardArray addObject:self.robotCardArray[n]];
                                                                                                [self.prevShowCardArray addObject:self.robotCardArray[x]];
                                                                                                [self.prevShowCardArray addObject:self.robotCardArray[y]];
                                                                                                [self.prevShowCardArray addObject:self.robotCardArray[z]];
                                                                                                [self.prevShowCardArray addObject:self.robotCardArray[a]];
                                                                                                [self.prevShowCardArray addObject:self.robotCardArray[b]];
                                                                                                [self.prevShowCardArray addObject:self.robotCardArray[c]];
                                                                                                //移走robot要出的牌
                                                                                                [self moveRobotCardsWithNodeArray:self.robotZhuoShangNodeArray];
                                                                                                //更新robot cardArray和nodeArray
                                                                                                [self.robotCardArray removeObjectsInArray:self.prevShowCardArray];
                                                                                                [self.robotNodeArray removeObjectsInArray:self.robotZhuoShangNodeArray];
                                                                                                //更新robot手牌布局
                                                                                                [self updateRobotNodeBuju];
                                                                                                break;
                                                                                            }
                                                                                            for (int d=0; d<self.robotCardArray.count; d++) {
                                                                                                if (canShow) {
                                                                                                    break;
                                                                                                }
                                                                                                LongCardModel * model11 = self.robotCardArray[d];
                                                                                                if (model11.grade-model10.grade==1 && model11.grade<=14) {
                                                                                                    if (myShowCardsArray.count == 11) {
                                                                                                        canShow = YES;

                                                                                                        //更新robot桌上的牌
                                                                                                        [self.robotZhuoShangNodeArray removeAllObjects];
                                                                                                        [self.robotZhuoShangNodeArray addObject:self.robotNodeArray[i]];
                                                                                                        [self.robotZhuoShangNodeArray addObject:self.robotNodeArray[j]];
                                                                                                        [self.robotZhuoShangNodeArray addObject:self.robotNodeArray[m]];
                                                                                                        [self.robotZhuoShangNodeArray addObject:self.robotNodeArray[n]];
                                                                                                        [self.robotZhuoShangNodeArray addObject:self.robotNodeArray[x]];
                                                                                                        [self.robotZhuoShangNodeArray addObject:self.robotNodeArray[y]];
                                                                                                        [self.robotZhuoShangNodeArray addObject:self.robotNodeArray[z]];
                                                                                                        [self.robotZhuoShangNodeArray addObject:self.robotNodeArray[a]];
                                                                                                        [self.robotZhuoShangNodeArray addObject:self.robotNodeArray[b]];
                                                                                                        [self.robotZhuoShangNodeArray addObject:self.robotNodeArray[c]];
                                                                                                        [self.robotZhuoShangNodeArray addObject:self.robotNodeArray[d]];
                                                                                                        //更新robot上一轮出的牌
                                                                                                        [self.prevShowCardArray removeAllObjects];
                                                                                                        [self.prevShowCardArray addObject:self.robotCardArray[i]];
                                                                                                        [self.prevShowCardArray addObject:self.robotCardArray[j]];
                                                                                                        [self.prevShowCardArray addObject:self.robotCardArray[m]];
                                                                                                        [self.prevShowCardArray addObject:self.robotCardArray[n]];
                                                                                                        [self.prevShowCardArray addObject:self.robotCardArray[x]];
                                                                                                        [self.prevShowCardArray addObject:self.robotCardArray[y]];
                                                                                                        [self.prevShowCardArray addObject:self.robotCardArray[z]];
                                                                                                        [self.prevShowCardArray addObject:self.robotCardArray[a]];
                                                                                                        [self.prevShowCardArray addObject:self.robotCardArray[b]];
                                                                                                        [self.prevShowCardArray addObject:self.robotCardArray[c]];
                                                                                                        [self.prevShowCardArray addObject:self.robotCardArray[d]];
                                                                                                        //移动robot要出的牌
                                                                                                        [self moveRobotCardsWithNodeArray:self.robotZhuoShangNodeArray];
                                                                                                        //更新robot cardArray和nodeArray
                                                                                                        [self.robotCardArray removeObjectsInArray:self.prevShowCardArray];
                                                                                                        [self.robotNodeArray removeObjectsInArray:self.robotZhuoShangNodeArray];
                                                                                                        //更新机器人手牌布局
                                                                                                        [self updateRobotNodeBuju];
                                                                                                        break;
                                                                                                    }
                                                                                                }
                                                                                            }
                                                                                        }
                                                                                    }
                                                                                }
                                                                            }
                                                                        }
                                                                    }
                                                                }
                                                            }
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }

            //是否有炸弹
            if (!canShow) {
                canShow = [self robotZhaDanGuanShang];
            }
            //是否有王炸
            if (!canShow) {
                canShow = [self robotWangZhaGuanShang];
            }
//            if (!canShow) {
//                NSLog(@"机器人要不起顺子");
//                [self.prevShowCardArray removeAllObjects];
//            }
            robotCanHit = canShow;
        }
            break;
        case CardsType_LianDui:
        {
            LongCardModel * model = myShowCardsArray[0];
            BOOL canShow = NO;
            for (int i = 0; i+1<self.robotCardArray.count; i++) {
                if (canShow) {
                    break;
                }
                LongCardModel * model1 = self.robotCardArray[i];
                LongCardModel * model2 = self.robotCardArray[i+1];
                if (model1.grade == model2.grade && model1.grade > model.grade){
                    for (int j = 0; j+1<self.robotCardArray.count; j++) {
                        if (canShow) {
                            break;
                        }
                        LongCardModel * model3 = self.robotCardArray[j];
                        LongCardModel * model4 = self.robotCardArray[j+1];
                        if (model3.grade == model4.grade && model3.grade - model1.grade == 1) {
                            for (int m = 0; m+1<self.robotCardArray.count; m++) {
                                if (canShow) {
                                    break;
                                }
                                LongCardModel * model5 = self.robotCardArray[m];
                                LongCardModel * model6 = self.robotCardArray[m+1];
                                if (model5.grade == model6.grade && model5.grade - model3.grade == 1){
                                    if (myShowCardsArray.count == 6) {
                                        canShow = YES;
                                        NSLog(@"管得上3连对");

                                        //更新robot桌上的牌
                                        [self.robotZhuoShangNodeArray removeAllObjects];
                                        [self.robotZhuoShangNodeArray addObjectsFromArray:[self.robotNodeArray subarrayWithRange:NSMakeRange(i, 2)]];
                                        [self.robotZhuoShangNodeArray addObjectsFromArray:[self.robotNodeArray subarrayWithRange:NSMakeRange(j, 2)]];
                                        [self.robotZhuoShangNodeArray addObjectsFromArray:[self.robotNodeArray subarrayWithRange:NSMakeRange(m, 2)]];
                                        //更新robot上一轮出的牌
                                        [self.prevShowCardArray removeAllObjects];
                                        [self.prevShowCardArray addObjectsFromArray:[self.robotCardArray subarrayWithRange:NSMakeRange(i, 2)]];
                                        [self.prevShowCardArray addObjectsFromArray:[self.robotCardArray subarrayWithRange:NSMakeRange(j, 2)]];
                                        [self.prevShowCardArray addObjectsFromArray:[self.robotCardArray subarrayWithRange:NSMakeRange(m, 2)]];
                                        //移动robot要出的牌
                                        [self moveRobotCardsWithNodeArray:self.robotZhuoShangNodeArray];
                                        //更新robot cardArray和nodeArray
                                        [self.robotCardArray removeObjectsInArray:self.prevShowCardArray];
                                        [self.robotNodeArray removeObjectsInArray:self.robotZhuoShangNodeArray];
                                        //更新robot手牌布局
                                        [self updateRobotNodeBuju];
                                        break;
                                    }
                                    for (int n=0; n+1<self.robotCardArray.count; n++) {
                                        if (canShow) {
                                            break;
                                        }
                                        LongCardModel * model7 = self.robotCardArray[n];
                                        LongCardModel * model8 = self.robotCardArray[n+1];
                                        if (model7.grade == model8.grade && model7.grade - model5.grade == 1){
                                            if (myShowCardsArray.count == 8) {
                                                canShow = YES;
                                                NSLog(@"管得上4连对");

                                                //更新robot桌上的牌
                                                [self.robotZhuoShangNodeArray removeAllObjects];
                                                [self.robotZhuoShangNodeArray addObjectsFromArray:[self.robotNodeArray subarrayWithRange:NSMakeRange(i, 2)]];
                                                [self.robotZhuoShangNodeArray addObjectsFromArray:[self.robotNodeArray subarrayWithRange:NSMakeRange(j, 2)]];
                                                [self.robotZhuoShangNodeArray addObjectsFromArray:[self.robotNodeArray subarrayWithRange:NSMakeRange(m, 2)]];
                                                [self.robotZhuoShangNodeArray addObjectsFromArray:[self.robotNodeArray subarrayWithRange:NSMakeRange(n, 2)]];
                                                //更新robot上一轮出的牌
                                                [self.prevShowCardArray removeAllObjects];
                                                [self.prevShowCardArray addObjectsFromArray:[self.robotCardArray subarrayWithRange:NSMakeRange(i, 2)]];
                                                [self.prevShowCardArray addObjectsFromArray:[self.robotCardArray subarrayWithRange:NSMakeRange(j, 2)]];
                                                [self.prevShowCardArray addObjectsFromArray:[self.robotCardArray subarrayWithRange:NSMakeRange(m, 2)]];
                                                [self.prevShowCardArray addObjectsFromArray:[self.robotCardArray subarrayWithRange:NSMakeRange(n, 2)]];
                                                //移动robot要出的牌
                                                [self moveRobotCardsWithNodeArray:self.robotZhuoShangNodeArray];
                                                //更新机器人cardArray和nodeArray
                                                [self.robotCardArray removeObjectsInArray:self.prevShowCardArray];
                                                [self.robotNodeArray removeObjectsInArray:self.robotZhuoShangNodeArray];
                                                //更新robot手牌布局
                                                [self updateRobotNodeBuju];
                                                break;
                                            }
                                            for (int a=0; a+1<self.robotCardArray.count; a++) {
                                                if (canShow) {
                                                    break;
                                                }
                                                LongCardModel * model9 = self.robotCardArray[a];
                                                LongCardModel * model10 = self.robotCardArray[a+1];
                                                if (model9.grade == model10.grade && model9.grade - model7.grade == 1){
                                                    if (myShowCardsArray.count == 10) {
                                                        canShow = YES;
                                                        NSLog(@"管得上5连对");

                                                        //更新robot桌上的牌
                                                        [self.robotZhuoShangNodeArray removeAllObjects];
                                                        [self.robotZhuoShangNodeArray addObjectsFromArray:[self.robotNodeArray subarrayWithRange:NSMakeRange(i, 2)]];
                                                        [self.robotZhuoShangNodeArray addObjectsFromArray:[self.robotNodeArray subarrayWithRange:NSMakeRange(j, 2)]];
                                                        [self.robotZhuoShangNodeArray addObjectsFromArray:[self.robotNodeArray subarrayWithRange:NSMakeRange(m, 2)]];
                                                        [self.robotZhuoShangNodeArray addObjectsFromArray:[self.robotNodeArray subarrayWithRange:NSMakeRange(n, 2)]];
                                                        [self.robotZhuoShangNodeArray addObjectsFromArray:[self.robotNodeArray subarrayWithRange:NSMakeRange(a, 2)]];
                                                        //更新robot上一轮出的牌
                                                        [self.prevShowCardArray removeAllObjects];
                                                        [self.prevShowCardArray addObjectsFromArray:[self.robotCardArray subarrayWithRange:NSMakeRange(i, 2)]];
                                                        [self.prevShowCardArray addObjectsFromArray:[self.robotCardArray subarrayWithRange:NSMakeRange(j, 2)]];
                                                        [self.prevShowCardArray addObjectsFromArray:[self.robotCardArray subarrayWithRange:NSMakeRange(m, 2)]];
                                                        [self.prevShowCardArray addObjectsFromArray:[self.robotCardArray subarrayWithRange:NSMakeRange(n, 2)]];
                                                        [self.prevShowCardArray addObjectsFromArray:[self.robotCardArray subarrayWithRange:NSMakeRange(a, 2)]];
                                                        //移动robot要出的牌
                                                        [self moveRobotCardsWithNodeArray:self.robotZhuoShangNodeArray];
                                                        //更新robot cardArray和nodeArray
                                                        [self.robotCardArray removeObjectsInArray:self.prevShowCardArray];
                                                        [self.robotNodeArray removeObjectsInArray:self.robotZhuoShangNodeArray];
                                                        //更新robot手牌布局
                                                        [self updateRobotNodeBuju];
                                                        break;
                                                    }
                                                    for (int b=0; b+1<self.robotCardArray.count; b++) {
                                                        if (canShow) {
                                                            break;
                                                        }
                                                        LongCardModel * model11 = self.robotCardArray[b];
                                                        LongCardModel * model12 = self.robotCardArray[b+1];
                                                        if (model11.grade == model12.grade && model11.grade - model9.grade == 1){
                                                            if (myShowCardsArray.count == 12) {
                                                                canShow = YES;
                                                                NSLog(@"管得上6连对");

                                                                //更新robot桌上的牌
                                                                [self.robotZhuoShangNodeArray removeAllObjects];
                                                                [self.robotZhuoShangNodeArray addObjectsFromArray:[self.robotNodeArray subarrayWithRange:NSMakeRange(i, 2)]];
                                                                [self.robotZhuoShangNodeArray addObjectsFromArray:[self.robotNodeArray subarrayWithRange:NSMakeRange(j, 2)]];
                                                                [self.robotZhuoShangNodeArray addObjectsFromArray:[self.robotNodeArray subarrayWithRange:NSMakeRange(m, 2)]];
                                                                [self.robotZhuoShangNodeArray addObjectsFromArray:[self.robotNodeArray subarrayWithRange:NSMakeRange(n, 2)]];
                                                                [self.robotZhuoShangNodeArray addObjectsFromArray:[self.robotNodeArray subarrayWithRange:NSMakeRange(a, 2)]];
                                                                [self.robotZhuoShangNodeArray addObjectsFromArray:[self.robotNodeArray subarrayWithRange:NSMakeRange(b, 2)]];
                                                                //更新robot上一轮出的牌
                                                                [self.prevShowCardArray removeAllObjects];
                                                                [self.prevShowCardArray addObjectsFromArray:[self.robotCardArray subarrayWithRange:NSMakeRange(i, 2)]];
                                                                [self.prevShowCardArray addObjectsFromArray:[self.robotCardArray subarrayWithRange:NSMakeRange(j, 2)]];
                                                                [self.prevShowCardArray addObjectsFromArray:[self.robotCardArray subarrayWithRange:NSMakeRange(m, 2)]];
                                                                [self.prevShowCardArray addObjectsFromArray:[self.robotCardArray subarrayWithRange:NSMakeRange(n, 2)]];
                                                                [self.prevShowCardArray addObjectsFromArray:[self.robotCardArray subarrayWithRange:NSMakeRange(a, 2)]];
                                                                [self.prevShowCardArray addObjectsFromArray:[self.robotCardArray subarrayWithRange:NSMakeRange(b, 2)]];
                                                                
                                                                //移动robot要出的牌
                                                                [self moveRobotCardsWithNodeArray:self.robotZhuoShangNodeArray];
                                                                //更新robot cardArray和nodeArray
                                                                [self.robotCardArray removeObjectsInArray:self.prevShowCardArray];
                                                                [self.robotNodeArray removeObjectsInArray:self.robotZhuoShangNodeArray];
                                                                //更新robot手牌布局
                                                                [self updateRobotNodeBuju];
                                                                break;
                                                            }
                                                            for (int c=0; c+1<self.robotCardArray.count; c++) {
                                                                if (canShow) {
                                                                    break;
                                                                }
                                                                LongCardModel * model13 = self.robotCardArray[c];
                                                                LongCardModel * model14 = self.robotCardArray[c+1];
                                                                if (model13.grade == model14.grade && model13.grade - model11.grade == 1){
                                                                    if (myShowCardsArray.count == 12) {
                                                                        canShow = YES;
                                                                        NSLog(@"管得上7连对");

                                                                        //更新robot桌上的牌
                                                                        [self.robotZhuoShangNodeArray removeAllObjects];
                                                                        [self.robotZhuoShangNodeArray addObjectsFromArray:[self.robotNodeArray subarrayWithRange:NSMakeRange(i, 2)]];
                                                                        [self.robotZhuoShangNodeArray addObjectsFromArray:[self.robotNodeArray subarrayWithRange:NSMakeRange(j, 2)]];
                                                                        [self.robotZhuoShangNodeArray addObjectsFromArray:[self.robotNodeArray subarrayWithRange:NSMakeRange(m, 2)]];
                                                                        [self.robotZhuoShangNodeArray addObjectsFromArray:[self.robotNodeArray subarrayWithRange:NSMakeRange(n, 2)]];
                                                                        [self.robotZhuoShangNodeArray addObjectsFromArray:[self.robotNodeArray subarrayWithRange:NSMakeRange(a, 2)]];
                                                                        [self.robotZhuoShangNodeArray addObjectsFromArray:[self.robotNodeArray subarrayWithRange:NSMakeRange(b, 2)]];
                                                                        [self.robotZhuoShangNodeArray addObjectsFromArray:[self.robotNodeArray subarrayWithRange:NSMakeRange(c, 2)]];
                                                                        //更新robot上一轮出的牌
                                                                        [self.prevShowCardArray removeAllObjects];
                                                                        [self.prevShowCardArray addObjectsFromArray:[self.robotCardArray subarrayWithRange:NSMakeRange(i, 2)]];
                                                                        [self.prevShowCardArray addObjectsFromArray:[self.robotCardArray subarrayWithRange:NSMakeRange(j, 2)]];
                                                                        [self.prevShowCardArray addObjectsFromArray:[self.robotCardArray subarrayWithRange:NSMakeRange(m, 2)]];
                                                                        [self.prevShowCardArray addObjectsFromArray:[self.robotCardArray subarrayWithRange:NSMakeRange(n, 2)]];
                                                                        [self.prevShowCardArray addObjectsFromArray:[self.robotCardArray subarrayWithRange:NSMakeRange(a, 2)]];
                                                                        [self.prevShowCardArray addObjectsFromArray:[self.robotCardArray subarrayWithRange:NSMakeRange(b, 2)]];
                                                                        [self.prevShowCardArray addObjectsFromArray:[self.robotCardArray subarrayWithRange:NSMakeRange(c, 2)]];
                                                                        
                                                                        //移动robot要出的牌
                                                                        [self moveRobotCardsWithNodeArray:self.robotZhuoShangNodeArray];
                                                                        //更新robot cardArray和nodeArray
                                                                        [self.robotCardArray removeObjectsInArray:self.prevShowCardArray];
                                                                        [self.robotNodeArray removeObjectsInArray:self.robotZhuoShangNodeArray];
                                                                        //更新robot手牌布局
                                                                        [self updateRobotNodeBuju];
                                                                        break;
                                                                    }
                                                                    for (int d=0; d+1<self.robotCardArray.count; d++) {
                                                                        LongCardModel * model15 = self.robotCardArray[d];
                                                                        LongCardModel * model16 = self.robotCardArray[d+1];
                                                                        if (model15.grade == model16.grade && model15.grade - model13.grade == 1){
                                                                            if (myShowCardsArray.count == 16) {
                                                                                canShow = YES;
                                                                                NSLog(@"管得上8连对");

                                                                                //更新robot桌上的牌
                                                                                [self.robotZhuoShangNodeArray removeAllObjects];
                                                                                [self.robotZhuoShangNodeArray addObjectsFromArray:[self.robotNodeArray subarrayWithRange:NSMakeRange(i, 2)]];
                                                                                [self.robotZhuoShangNodeArray addObjectsFromArray:[self.robotNodeArray subarrayWithRange:NSMakeRange(j, 2)]];
                                                                                [self.robotZhuoShangNodeArray addObjectsFromArray:[self.robotNodeArray subarrayWithRange:NSMakeRange(m, 2)]];
                                                                                [self.robotZhuoShangNodeArray addObjectsFromArray:[self.robotNodeArray subarrayWithRange:NSMakeRange(n, 2)]];
                                                                                [self.robotZhuoShangNodeArray addObjectsFromArray:[self.robotNodeArray subarrayWithRange:NSMakeRange(a, 2)]];
                                                                                [self.robotZhuoShangNodeArray addObjectsFromArray:[self.robotNodeArray subarrayWithRange:NSMakeRange(b, 2)]];
                                                                                [self.robotZhuoShangNodeArray addObjectsFromArray:[self.robotNodeArray subarrayWithRange:NSMakeRange(c, 2)]];
                                                                                [self.robotZhuoShangNodeArray addObjectsFromArray:[self.robotNodeArray subarrayWithRange:NSMakeRange(d, 2)]];
                                                                                //更新robot上一轮出的牌
                                                                                [self.prevShowCardArray removeAllObjects];
                                                                                [self.prevShowCardArray addObjectsFromArray:[self.robotCardArray subarrayWithRange:NSMakeRange(i, 2)]];
                                                                                [self.prevShowCardArray addObjectsFromArray:[self.robotCardArray subarrayWithRange:NSMakeRange(j, 2)]];
                                                                                [self.prevShowCardArray addObjectsFromArray:[self.robotCardArray subarrayWithRange:NSMakeRange(m, 2)]];
                                                                                [self.prevShowCardArray addObjectsFromArray:[self.robotCardArray subarrayWithRange:NSMakeRange(n, 2)]];
                                                                                [self.prevShowCardArray addObjectsFromArray:[self.robotCardArray subarrayWithRange:NSMakeRange(a, 2)]];
                                                                                [self.prevShowCardArray addObjectsFromArray:[self.robotCardArray subarrayWithRange:NSMakeRange(b, 2)]];
                                                                                [self.prevShowCardArray addObjectsFromArray:[self.robotCardArray subarrayWithRange:NSMakeRange(c, 2)]];
                                                                                [self.prevShowCardArray addObjectsFromArray:[self.robotCardArray subarrayWithRange:NSMakeRange(d, 2)]];
                                                                                
                                                                                //移动robot要出的牌
                                                                                [self moveRobotCardsWithNodeArray:self.robotZhuoShangNodeArray];
                                                                                //更新robot cardArray和nodeArray
                                                                                [self.robotCardArray removeObjectsInArray:self.prevShowCardArray];
                                                                                [self.robotNodeArray removeObjectsInArray:self.robotZhuoShangNodeArray];
                                                                                //更新robot手牌布局
                                                                                [self updateRobotNodeBuju];
                                                                                break;
                                                                            }
                                                                        }
                                                                    }
                                                                }
                                                            }
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
            
            //是否有炸弹
            if (!canShow) {
                canShow = [self robotZhaDanGuanShang];
            }
            //是否有王炸
            if (!canShow) {
                canShow = [self robotWangZhaGuanShang];
            }
//            if (!canShow) {
//                NSLog(@"机器人要不起连对");
//                [self.prevShowCardArray removeAllObjects];
//            }
            robotCanHit = canShow;
        }
            break;
        case CardsType_FeiJiBuDai:
        {
            BOOL canShow = NO;
            LongCardModel * model = myShowCardsArray[0];
            for (int i=0; i+5<self.robotCardArray.count; i++) {
                LongCardModel * model1 = self.robotCardArray[i];
                LongCardModel * model2 = self.robotCardArray[i+1];
                LongCardModel * model3 = self.robotCardArray[i+2];
                LongCardModel * model4 = self.robotCardArray[i+3];
                LongCardModel * model5 = self.robotCardArray[i+4];
                LongCardModel * model6 = self.robotCardArray[i+5];
                if (model1.grade==model2.grade && model1.grade==model3.grade && model4.grade==model5.grade && model4.grade==model6.grade && model4.grade-model3.grade==1 && model1.grade>model.grade) {
                    canShow = YES;

                    //更新robot桌上的牌
                    [self.robotZhuoShangNodeArray removeAllObjects];
                    [self.robotZhuoShangNodeArray addObjectsFromArray:[self.robotNodeArray subarrayWithRange:NSMakeRange(i, 6)]];
                    //更新robot上一轮出的牌
                    [self.prevShowCardArray removeAllObjects];
                    [self.prevShowCardArray addObjectsFromArray:[self.robotCardArray subarrayWithRange:NSMakeRange(i, 6)]];
                    //移动robot要出的牌
                    [self moveRobotCardsWithNodeArray:self.robotZhuoShangNodeArray];
                    //更新robot cardArray和nodeArray
                    [self.robotCardArray removeObjectsInArray:self.prevShowCardArray];
                    [self.robotNodeArray removeObjectsInArray:self.robotZhuoShangNodeArray];
                    //更新robot手牌布局
                    [self updateRobotNodeBuju];
                    break;
                }
            }
            //是否有炸弹
            if (!canShow) {
                canShow = [self robotZhaDanGuanShang];
            }
            //是否有王炸
            if (!canShow) {
                canShow = [self robotWangZhaGuanShang];
            }
//            if (!canShow) {
//                NSLog(@"机器人要不起飞机不带");
//                [self.prevShowCardArray removeAllObjects];
//            }
            robotCanHit = canShow;
        }
            break;
        case CardsType_FeiJiDaiDanZhang:
        {
            BOOL canShow = NO;
            LongCardModel * model = myShowCardsArray[2];
            for (int i = 0; i+5<self.robotCardArray.count; i++) {
                LongCardModel * model1 = self.robotCardArray[i];
                LongCardModel * model2 = self.robotCardArray[i+1];
                LongCardModel * model3 = self.robotCardArray[i+2];
                LongCardModel * model4 = self.robotCardArray[i+3];
                LongCardModel * model5 = self.robotCardArray[i+4];
                LongCardModel * model6 = self.robotCardArray[i+5];
                if (model1.grade==model2.grade && model1.grade==model3.grade && model4.grade==model5.grade && model4.grade==model6.grade && model1.grade>model.grade) {
                    if (self.robotCardArray.count>=8) {
                        canShow = YES;
                        if (i<=2) {
                            [self robotCardsAnimationWithIndex:i andWithRobotCardsNumber:8];
                        }else{
                            NSMutableArray * mutableNodeArray = [NSMutableArray arrayWithArray:[self.robotNodeArray subarrayWithRange:NSMakeRange(i, 6)]];
                            [mutableNodeArray insertObjects:[self.robotNodeArray subarrayWithRange:NSMakeRange(0, 2)] atIndexes: [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, 2)]];
                            
                            NSMutableArray * mutableCardArray = [NSMutableArray arrayWithArray:[self.robotCardArray subarrayWithRange:NSMakeRange(i, 6)]];
                            [mutableCardArray insertObjects:[self.robotCardArray subarrayWithRange:NSMakeRange(0, 2)] atIndexes: [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, 2)]];

                            [self.robotZhuoShangNodeArray replaceObjectsInRange:NSMakeRange(0, self.robotZhuoShangNodeArray.count) withObjectsFromArray:mutableNodeArray];
                            //移动robot要出的牌
                            [self moveRobotCardsWithNodeArray:mutableNodeArray];
                            //更新上一手robot出的牌
                            [self.prevShowCardArray replaceObjectsInRange:NSMakeRange(0, self.prevShowCardArray.count) withObjectsFromArray:mutableCardArray];
                            
                            [self.robotCardArray removeObjectsInArray:mutableCardArray];
                            [self.robotNodeArray removeObjectsInArray:mutableNodeArray];
                            
                            //更新robot手牌布局
                            [self updateRobotNodeBuju];
                            break;
                        }
                    }
                }
            }
            
            //是否有炸弹
            if (!canShow) {
                canShow = [self robotZhaDanGuanShang];
            }
            //是否有王炸
            if (!canShow) {
                canShow = [self robotWangZhaGuanShang];
            }
//            if (!canShow) {
//                NSLog(@"机器人要不起飞机不带");
//                [self.prevShowCardArray removeAllObjects];
//            }
            robotCanHit = canShow;
        }
            break;
        case CardsType_FeiJiDaiDuiZi:
        {
            BOOL canShow = NO;
            //是否有炸弹
            if (!canShow) {
                canShow = [self robotZhaDanGuanShang];
            }
            //是否有王炸
            if (!canShow) {
                canShow = [self robotWangZhaGuanShang];
            }
//            if (!canShow) {
//                NSLog(@"机器人要不起飞机带对子");
//                [self.prevShowCardArray removeAllObjects];
//            }
            robotCanHit = canShow;
        }
            break;
        case CardsType_SiDaiLiangDanZhang:
        {
            BOOL canShow = NO;
            LongCardModel * model = myShowCardsArray[2];
            for (int i = 0; i+3<self.robotCardArray.count; i++) {
                LongCardModel * model1 = self.robotCardArray[i];
                LongCardModel * model2 = self.robotCardArray[i+1];
                LongCardModel * model3 = self.robotCardArray[i+2];
                LongCardModel * model4 = self.robotCardArray[i+3];
                if (model1.grade==model2.grade && model1.grade==model3.grade && model1.grade==model4.grade && model1.grade>model.grade) {
                    if (self.robotCardArray.count>=6) {
                        canShow = YES;
                        if (i<=2) {
                            [self robotCardsAnimationWithIndex:i andWithRobotCardsNumber:6];
                        }else{
                            NSMutableArray * mutableNodeArray = [NSMutableArray arrayWithArray:[self.robotNodeArray subarrayWithRange:NSMakeRange(i, 4)]];
                            [mutableNodeArray insertObjects:[self.robotNodeArray subarrayWithRange:NSMakeRange(0, 2)] atIndexes: [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, 2)]];
                            
                            NSMutableArray * mutableCardArray = [NSMutableArray arrayWithArray:[self.robotCardArray subarrayWithRange:NSMakeRange(i, 4)]];
                            [mutableCardArray insertObjects:[self.robotCardArray subarrayWithRange:NSMakeRange(0, 2)] atIndexes: [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, 2)]];

                            [self.robotZhuoShangNodeArray replaceObjectsInRange:NSMakeRange(0, self.robotZhuoShangNodeArray.count) withObjectsFromArray:mutableNodeArray];
                            //移动robot要出的牌
                            [self moveRobotCardsWithNodeArray:mutableNodeArray];
                            //更新上一手robot出的牌
                            [self.prevShowCardArray replaceObjectsInRange:NSMakeRange(0, self.prevShowCardArray.count) withObjectsFromArray:mutableCardArray];
                            
                            [self.robotCardArray removeObjectsInArray:mutableCardArray];
                            [self.robotNodeArray removeObjectsInArray:mutableNodeArray];
                            
                            //更新robot手牌布局
                            [self updateRobotNodeBuju];
                            break;
                        }
                    }
                }
            }
            
            //是否有炸弹
            if (!canShow) {
                canShow = [self robotZhaDanGuanShang];
            }
            //是否有王炸
            if (!canShow) {
                canShow = [self robotWangZhaGuanShang];
            }
//            if (!canShow) {
//                NSLog(@"机器人要不起四带两单张");
//                [self.prevShowCardArray removeAllObjects];
//            }
            robotCanHit = canShow;
        }
            break;
        case CardsType_SiDaiLiangDuiZi:
        {
            BOOL canShow = NO;
            //是否有炸弹
            if (!canShow) {
                canShow = [self robotZhaDanGuanShang];
            }
            //是否有王炸
            if (!canShow) {
                canShow = [self robotWangZhaGuanShang];
            }
//            if (!canShow) {
//                NSLog(@"机器人要不起四带两对");
//                [self.prevShowCardArray removeAllObjects];
//            }
            robotCanHit = canShow;
        }
            break;
            
        default:
            break;
    }
    
    if (self.robotCardArray.count == 0) {
        //闯关失败
        self.loseJieSuanView.hidden = NO;
        self.userInteractionEnabled = NO;
        [self.yaoBuQiNode removeFromParent];
        if (![DDGET_CACHE(DDZ_SET_GameMusic) isEqualToString:@"GBYXYX"]){
            [[DDZBackgroundMusic shareBackgroundMusic] gameLoseMusicPlay];
        }
        
        return;
    }
    
    if (robotCanHit) {
        //显示出牌、不出或者要不起
        if ([self myCardCanHitRobotShowCard:self.prevShowCardArray]) {
            //我的牌能管上
            self.chuPaiNode.hidden = NO;
            self.buChuNode.hidden = NO;
            self.yaoBuQiNode.hidden = YES;
        }else{
            self.chuPaiNode.hidden = YES;
            self.buChuNode.hidden = YES;
            self.yaoBuQiNode.hidden = NO;
        }
        
        if (![DDGET_CACHE(DDZ_SET_GameMusic) isEqualToString:@"GBYXYX"]){
            if (self.robotZhuoShangNodeArray.count>1) {
                [[DDZBackgroundMusic shareBackgroundMusic] duoZhangMusicPlay];
            }else{
                [[DDZBackgroundMusic shareBackgroundMusic] danZhangMusicPlay];
            }
        }
    }else{
        //显示出牌
        NSLog(@"机器人要不起");
        if (![DDGET_CACHE(DDZ_SET_GameMusic) isEqualToString:@"GBYXYX"]){
            [[DDZBackgroundMusic shareBackgroundMusic] buYaoMusicPlay];
        }
        [self.prevShowCardArray removeAllObjects];
        self.chuPaiNode.hidden = NO;
        self.buChuNode.hidden = YES;
        self.yaoBuQiNode.hidden = YES;
    }
}



#pragma mark - get
-(SKSpriteNode *)backgroundNode
{
    if (!_backgroundNode) {
        _backgroundNode = [[SKSpriteNode alloc] initWithTexture:[SKTexture textureWithImageNamed:IS_IPhoneX_All?@"game_bg_x":@"game_bg"]];
        _backgroundNode.name = @"backgroud";
        _backgroundNode.size = CGSizeMake(self.size.width, self.size.height);
        _backgroundNode.position = CGPointMake(_backgroundNode.size.width/2, _backgroundNode.size.height/2);
    }
    return _backgroundNode;
}

-(SKAudioNode *)gameAudioNode
{
    if (!_gameAudioNode) {
        _gameAudioNode = [[SKAudioNode alloc] initWithFileNamed:@"game_backgroundMusic.caf"];
        SKAction * action = [SKAction play];
        [_gameAudioNode runAction:action];
    }
    return _gameAudioNode;
}

-(SKAudioNode *)choiceCardNode
{
    if (!_choiceCardNode) {
        _choiceCardNode = [[SKAudioNode alloc] initWithFileNamed:@"game_choiceCard"];
        //_choiceCardNode.autoplayLooped = NO;
        SKAction * action = [SKAction play];
        [_choiceCardNode runAction:action];
    }
    return _choiceCardNode;
}

-(SKSpriteNode *)nongMingNode
{
    if (!_nongMingNode) {
        NSString * imageName = [NSString stringWithFormat:@"nongMing_%@",DDGET_CACHE(DDZ_CURRENT_GRADE)?:@"1"];
        _nongMingNode = [[SKSpriteNode alloc] initWithTexture:[SKTexture textureWithImageNamed:imageName]];
        _nongMingNode.size = CGSizeMake(220/2, 366/2);
        _nongMingNode.position = CGPointMake(Auto_Width(7)+220/4, Auto_Height(50)+366/4);
    }
    return _nongMingNode;
}

-(SKSpriteNode *)diZhuNode
{
    if (!_diZhuNode) {
        _diZhuNode = [[SKSpriteNode alloc] initWithTexture:[SKTexture textureWithImageNamed:@"diZhu"]];
        _diZhuNode.size = CGSizeMake(205/2, 270/2);
        _diZhuNode.position = CGPointMake(KScreenWidth-Auto_Width(2)-205/4, self.size.height-Auto_Height(144/2)-270/4-DDTabBar_TopHeight);
    }
    return _diZhuNode;
}

-(SKSpriteNode *)chuPaiNode
{
    if (!_chuPaiNode) {
        _chuPaiNode = [[SKSpriteNode alloc] initWithTexture:[SKTexture textureWithImageNamed:@"chuPai_button"]];
        _chuPaiNode.name = @"chuPai";
        _chuPaiNode.size = CGSizeMake(91, 49);
        _chuPaiNode.position = CGPointMake(Auto_Width(285/2+30/2)+91+91/2, Auto_Height(20+40)+BIGCARDHEIGHT+49/2);
    }
    return _chuPaiNode;
}

-(SKSpriteNode *)buChuNode
{
    if (!_buChuNode) {
        _buChuNode = [[SKSpriteNode alloc] initWithTexture:[SKTexture textureWithImageNamed:@"buChu_button"]];
        _buChuNode.name = @"buChu";
        _buChuNode.size = CGSizeMake(91, 49);
        _buChuNode.position = CGPointMake(Auto_Width(285/2)+91/2, Auto_Height(20+40)+BIGCARDHEIGHT+49/2);
    }
    return _buChuNode;
}

-(SKSpriteNode *)yaoBuQiNode
{
    if (!_yaoBuQiNode) {
        _yaoBuQiNode = [[SKSpriteNode alloc] initWithTexture:[SKTexture textureWithImageNamed:@"yaoBuQi_button"]];
        _yaoBuQiNode.name = @"buChu";
        _yaoBuQiNode.size = CGSizeMake(91, 49);
        _yaoBuQiNode.position = CGPointMake(Auto_Width(285/2)+91/2, Auto_Height(20+40)+BIGCARDHEIGHT+49/2);
        [self addChild:_yaoBuQiNode];
    }
    return _yaoBuQiNode;
}

-(SKSpriteNode *)backNode
{
    if (!_backNode) {
        _backNode = [[SKSpriteNode alloc] initWithTexture:[SKTexture textureWithImageNamed:@"game_back"]];
        _backNode.name = @"fanHui";
        _backNode.size = CGSizeMake(87/2, 76/2);
        _backNode.position = CGPointMake(87/4, KScreenHeight-Auto_Height(21)-76/4);
    }
    return _backNode;
}

-(SKSpriteNode *)settingNode
{
    if (!_settingNode) {
        _settingNode = [[SKSpriteNode alloc] initWithTexture:[SKTexture textureWithImageNamed:@"game_setting"]];
        _settingNode.name = @"setting";
        _settingNode.size = CGSizeMake(76/2, 76/2);
        _settingNode.position = CGPointMake(87/2+Auto_Width(10)+76/4, KScreenHeight-Auto_Height(21)-76/4);
    }
    return _settingNode;
}

-(SKSpriteNode *)moneyNode
{
    if (!_moneyNode) {
        _moneyNode = [[SKSpriteNode alloc] initWithTexture:[SKTexture textureWithImageNamed:@"money_button"]];
        _moneyNode.name = @"money";
        _moneyNode.size = CGSizeMake(180/2, 52/2);
        _moneyNode.position = CGPointMake(KScreenWidth-Auto_Width(10)-180/4, KScreenHeight-Auto_Height(52/2)-52/4);
    }
    return _moneyNode;
}

-(SKLabelNode *)moneyValueLabelNode
{
    if (!_moneyValueLabelNode) {
        _moneyValueLabelNode = [[SKLabelNode alloc] init];
        _moneyValueLabelNode.text = DDGET_CACHE(DDZ_USER_MONEY);
        _moneyValueLabelNode.verticalAlignmentMode = SKLabelVerticalAlignmentModeCenter;
        _moneyValueLabelNode.fontSize = 13;
        _moneyValueLabelNode.color = [SKColor whiteColor];
        _moneyValueLabelNode.position = CGPointMake(KScreenWidth-180/4, self.moneyNode.position.y);
    }
    return _moneyValueLabelNode;
}

-(UILabel *)moneyValueLabel
{
    if (!_moneyValueLabel) {
        _moneyValueLabel = [[UILabel alloc] initWithFrame:CGRectMake(KScreenWidth-Auto_Width(10)-180/4,Auto_Height(52/2), 100, 52/2)];
        _moneyValueLabel.textAlignment = NSTextAlignmentLeft;
        _moneyValueLabel.text = DDGET_CACHE(DDZ_USER_MONEY);
        _moneyValueLabel.font = kFont(13);
        _moneyValueLabel.textColor = UIColorFromRGB(0xffffff);
        [self.view addSubview:_moneyValueLabel];
    }
    return _moneyValueLabel;
}


-(DDZJieSuanView *)winJieSuanView
{
    if (!_winJieSuanView) {
        _winJieSuanView = [[DDZJieSuanView alloc] init];
        _winJieSuanView.guanLabel.text = [NSString stringWithFormat:@"第%ld關",[AppDelegate shareDelegate].paipuNumber+1];
        DDWeakSelf;
        _winJieSuanView.clickLeftButtonBlock = ^{
            [[MusicPlayObj initClient] playBgMusic];
            weakSelf.exitTheSceneBlock();
            [weakSelf whenOutOfGame];
        };
        _winJieSuanView.clickRightButtonBlock = ^{
            [[MusicPlayObj initClient] playBgMusic];
            weakSelf.exitTheSceneBlock();
            [weakSelf whenOutOfGame];
        };
        [self.view addSubview:_winJieSuanView];
        [_winJieSuanView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
    }
    return _winJieSuanView;
}

-(DDZJieSuanView *)loseJieSuanView
{
    if (!_loseJieSuanView) {
        _loseJieSuanView = [[DDZJieSuanView alloc] init];
        [_loseJieSuanView.rightButton setImage:DDImageName(@"Rechallenge") forState:UIControlStateNormal];
        _loseJieSuanView.juanChouImageView.image = DDImageName(@"juanchou_lose");
        _loseJieSuanView.winAnimationImageView.hidden = YES;
        _loseJieSuanView.loseAnimationImageView.hidden = NO;
        _loseJieSuanView.guanLabel.textColor = UIColorFromRGB(0x616161);
        _loseJieSuanView.guanLabel.text = [NSString stringWithFormat:@"第%ld關",[AppDelegate shareDelegate].paipuNumber+1];
        DDWeakSelf;
        _loseJieSuanView.clickLeftButtonBlock = ^{
            [[MusicPlayObj initClient] playBgMusic];
            weakSelf.exitTheSceneBlock();
            [weakSelf whenOutOfGame];
        };
        _loseJieSuanView.clickRightButtonBlock = ^{
            [[MusicPlayObj initClient] playBgMusic];
            weakSelf.exitTheSceneBlock();
            [weakSelf whenOutOfGame];
        };
        [self.view addSubview:_loseJieSuanView];
        [_loseJieSuanView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
    }
    return _loseJieSuanView;
}

-(SKSpriteNode *)gameBeginNode
{
    if (!_gameBeginNode) {
        _gameBeginNode = [[SKSpriteNode alloc] init];
        _gameBeginNode.size = CGSizeMake(KScreenWidth, 4*KScreenWidth/15);
        _gameBeginNode.position = self.backgroundNode.position;
        
        NSArray * array = @[[SKTexture textureWithImageNamed:@"gameBegin_1"],[SKTexture textureWithImageNamed:@"gameBegin_2"],[SKTexture textureWithImageNamed:@"gameBegin_3"],[SKTexture textureWithImageNamed:@"gameBegin_4"],[SKTexture textureWithImageNamed:@"gameBegin_5"],[SKTexture textureWithImageNamed:@"gameBegin_6"],[SKTexture textureWithImageNamed:@"gameBegin_7"],[SKTexture textureWithImageNamed:@"gameBegin_8"],[SKTexture textureWithImageNamed:@"gameBegin_9"],[SKTexture textureWithImageNamed:@"gameBegin_10"],[SKTexture textureWithImageNamed:@"gameBegin_11"],[SKTexture textureWithImageNamed:@"gameBegin_12"],[SKTexture textureWithImageNamed:@"gameBegin_13"],[SKTexture textureWithImageNamed:@"gameBegin_14"],[SKTexture textureWithImageNamed:@"gameBegin_15"],[SKTexture textureWithImageNamed:@"gameBegin_16"],[SKTexture textureWithImageNamed:@"gameBegin_17"],[SKTexture textureWithImageNamed:@"gameBegin_18"],[SKTexture textureWithImageNamed:@"gameBegin_19"],[SKTexture textureWithImageNamed:@"gameBegin_20"],[SKTexture textureWithImageNamed:@"gameBegin_21"],[SKTexture textureWithImageNamed:@"gameBegin_22"],[SKTexture textureWithImageNamed:@"gameBegin_23"],[SKTexture textureWithImageNamed:@"gameBegin_24"]];
        SKAction * animationAction = [SKAction animateWithTextures:array timePerFrame:1.5/24];
        
//        [_gameBeginNode runAction:animationAction];
        DDWeakSelf
        [_gameBeginNode runAction:animationAction completion:^{
            [weakSelf.gameBeginNode removeFromParent];
            [weakSelf fapai];
        }];
    }
    return _gameBeginNode;
}

-(NSMutableArray *)myNodeArray
{
    if (!_myNodeArray) {
        _myNodeArray = [NSMutableArray array];
    }
    return _myNodeArray;
}

-(NSMutableArray *)robotNodeArray
{
    if (!_robotNodeArray) {
        _robotNodeArray = [NSMutableArray array];
    }
    return _robotNodeArray;
}

-(NSMutableArray *)myWillShowCardArray
{
    if (!_myWillShowCardArray) {
        _myWillShowCardArray = [NSMutableArray array];
    }
    return _myWillShowCardArray;
}

-(NSMutableArray *)myWillShowNodeArray
{
    if (!_myWillShowNodeArray) {
        _myWillShowNodeArray = [NSMutableArray array];
    }
    return _myWillShowNodeArray;
}

-(NSMutableArray *)prevShowCardArray
{
    if (!_prevShowCardArray) {
        _prevShowCardArray = [NSMutableArray array];
    }
    return _prevShowCardArray;
}

-(NSMutableArray *)myZhuoShangNodeArray
{
    if (!_myZhuoShangNodeArray) {
        _myZhuoShangNodeArray = [NSMutableArray array];
    }
    return _myZhuoShangNodeArray;
}

-(NSMutableArray *)robotZhuoShangNodeArray
{
    if (!_robotZhuoShangNodeArray) {
        _robotZhuoShangNodeArray = [NSMutableArray array];
    }
    return _robotZhuoShangNodeArray;
}

-(DDPopupView *)popupView
{
    if (!_popupView) {
        _popupView = [[DDPopupView alloc] initWithFrame:self.view.bounds];
        [self.view addSubview:_popupView];
    }
    return _popupView;
}

//以上是单个动作的SKAction，同样可以通过下面两个函数将多个单一动作整合成复合动作SKAction
//+ (SKAction *)sequence:(NSArray *)actions;
//+ (SKAction *)group:(NSArray *)actions；
//入参是N多个Action，sequence:函数是串行的来执行数组中的所有Action，group:函数是并行的来执行。通过以上这些我们就可以做各种复杂的动画了。
//scaleTo是在原精灵上做的比例拉伸，scaleBy是在当前精灵的比例上拉伸
//MoveTo：(x, y) → (x1, y1),MoveBy：(x, y) → (x + x1, y + y1)
@end
