//
//  GameViewController.m
//  DDZCJ
//
//  Created by df on 2019/8/30.
//  Copyright © 2019 df. All rights reserved.
//

#import "GameViewController.h"
#import "LongDDZScene.h"
#import "DDZBackgroundMusic.h"

@interface GameViewController()
@property (nonatomic,strong)SKView * sceneView;
@end

@implementation GameViewController
-(void)dealloc
{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [[DDZBackgroundMusic shareBackgroundMusic] lobbyBackgroundMusicStop];
    [AppDelegate shareDelegate].isInGame = YES;
    LongDDZScene * scene = [LongDDZScene sceneWithSize:CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height)];
    DDWeakSelf;
        scene.exitTheSceneBlock = ^{
            [weakSelf dismissViewControllerAnimated:YES completion:nil];
            [AppDelegate shareDelegate].isInGame = NO;
        };
    scene.scaleMode = SKSceneScaleModeAspectFill;
    [self.sceneView presentScene:scene];
}

- (BOOL)shouldAutorotate {
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskAll;
    }
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

#pragma mark - sceneView
-(SKView *)sceneView
{
    if (!_sceneView) {
        _sceneView = (SKView *)self.view;
//        _sceneView.showsFPS = true;
//        _sceneView.showsQuadCount = true;
//        _sceneView.showsFields = true;
//        _sceneView.showsPhysics = true;
//        _sceneView.showsDrawCount = true;
//        _sceneView.showsNodeCount = true;
    }
    return _sceneView;
}

@end
