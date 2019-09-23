//
//
//
//
//  Created by df on 2019/9/21.
//  Copyright © 2019 dub. All rights reserved.
//

#import "XZGameScene.h"
@interface XZGameScene()
@property (nonatomic,strong)SKSpriteNode * backNode;
@end
@implementation XZGameScene
-(instancetype)initWithSize:(CGSize)size
{
    if (self = [super initWithSize:size]) {
        [self addChild:self.backNode];
    }
    return self;
}

#pragma mark - action
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
}

#pragma mark - get
-(SKSpriteNode *)backNode
{
    if (!_backNode) {
//        _backNode = [SKSpriteNode spriteNodeWithImageNamed:@"diamond_mall_bg的副本"];
        _backNode = [[SKSpriteNode alloc] initWithTexture:[SKTexture textureWithImageNamed:@"diamond_mall_bg的副本"]];
        _backNode.name = @"backgroud";
        _backNode.size = CGSizeMake(self.size.width, self.size.height);
        _backNode.position = CGPointMake(_backNode.size.width/2, _backNode.size.height/2);
    }
    return _backNode;
}

@end
