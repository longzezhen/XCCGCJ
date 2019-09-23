//
//  DDZBackgroundMusic.h
//  DDZCJ
//
//  Created by df on 2019/9/18.
//  Copyright © 2019 df. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVKit/AVKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface DDZBackgroundMusic : NSObject
+(DDZBackgroundMusic *)shareBackgroundMusic;
@property (nonatomic,strong)AVAudioPlayer * lobbyBgPlayer;
@property (nonatomic,strong)AVAudioPlayer * gameBgPlayer;
@property (nonatomic,strong)AVAudioPlayer * gameWinPlayer;
@property (nonatomic,strong)AVAudioPlayer * gameLosePlayer;
@property (nonatomic,strong)AVAudioPlayer * choiceCardPlayer;
@property (nonatomic,strong)AVAudioPlayer * danZhangPlayer;
@property (nonatomic,strong)AVAudioPlayer * duoZhangPlayer;
@property (nonatomic,strong)AVAudioPlayer * buYaoPlayer;
@property (nonatomic,strong)AVAudioPlayer * clickPlayer;
//大厅背景
-(void)lobbyBackgroundMusicPlay;
-(void)lobbyBackgroundMusicStop;
//游戏背景
-(void)gameBackgroundMusicPlay;
-(void)gameBackgroundMusicStop;
//游戏过关
-(void)gameWinMusicPlay;
-(void)gameWinMusicStop;
//游戏失败
-(void)gameLoseMusicPlay;
-(void)gameLoseMusicStop;
//选牌
-(void)choiceCardMusicPlay;
//出单张
-(void)danZhangMusicPlay;
//出多张
-(void)duoZhangMusicPlay;
//不要
-(void)buYaoMusicPlay;
//点击按钮的声音
-(void)clickMusicPlay;
@end

NS_ASSUME_NONNULL_END
