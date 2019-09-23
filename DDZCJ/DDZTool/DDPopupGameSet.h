//
//  DDPopupGameSet.h
//  DDZCJ
//
//  Created by jjj on 2019/9/17.
//  Copyright © 2019 df. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^ DDPopupGameSetBlock)(void);

@interface DDPopupGameSet : NSObject

+(DDPopupGameSet *)initClient;
-(void)showGameSetViewBlock:(DDPopupGameSetBlock)block;

@end

NS_ASSUME_NONNULL_END
