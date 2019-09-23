//
//  LongDDZScene.h
//  GameTest
//
//  Created by df on 2019/8/26.
//  Copyright © 2019 df. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface LongDDZScene : SKScene
@property (nonatomic,copy) void (^exitTheSceneBlock)(void);

@end

NS_ASSUME_NONNULL_END
