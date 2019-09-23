//
//  DDPopupView.h
//  DDZCJ
//
//  Created by jjj on 2019/9/11.
//  Copyright © 2019 df. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^ DDPopupViewBlock)(BOOL isSuc);

typedef void(^ DDPopupGameHKBlock)(NSString *moneyStr);

@interface DDPopupView : UIView

- (void) addFeedBackViewBlock:(DDPopupViewBlock)commitBlock;

- (void) addGameShopWithBlock:(DDPopupGameHKBlock)block;

- (void) addGameSetWithBlock:(DDPopupViewBlock)block;

//挑战界面的提示弹框
-(void)addChallengeTipsText:(NSString *)text block:(DDPopupViewBlock)block;

-(void)challengeTipsWithGradeNum:(NSInteger)gradeNum block:(DDPopupViewBlock)block;

-(void)addTipsTest:(NSString *)text block:(DDPopupViewBlock)block;

-(void)addXieyiWithBlock:(DDPopupViewBlock)block;

@end

NS_ASSUME_NONNULL_END
