//
//  DDZBackgroundMusic.m
//  DDZCJ
//
//  Created by df on 2019/9/18.
//  Copyright © 2019 df. All rights reserved.
//

#import "DDZBackgroundMusic.h"

@implementation DDZBackgroundMusic
+(DDZBackgroundMusic *)shareBackgroundMusic
{
    static DDZBackgroundMusic * backgroundMusic = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        backgroundMusic = [[DDZBackgroundMusic alloc] init];
    });
    return backgroundMusic;
}

#pragma mark - private
-(void)lobbyBackgroundMusicPlay
{
    [self.lobbyBgPlayer play];
}
-(void)lobbyBackgroundMusicStop
{
    [self.lobbyBgPlayer stop];
}
-(void)gameBackgroundMusicPlay
{
    [self.gameBgPlayer play];
}
-(void)gameBackgroundMusicStop
{
    [self.gameBgPlayer stop];
}
-(void)gameWinMusicPlay
{
    [self.gameWinPlayer play];
}
-(void)gameWinMusicStop
{
    [self.gameWinPlayer stop];
}
-(void)gameLoseMusicPlay
{
    [self.gameLosePlayer play];
}
-(void)gameLoseMusicStop
{
    [self.gameLosePlayer stop];
}


//选牌
-(void)choiceCardMusicPlay
{
    [self.choiceCardPlayer play];
}
//单张
-(void)danZhangMusicPlay
{
    [self.danZhangPlayer play];
}
//多张
-(void)duoZhangMusicPlay
{
    [self.duoZhangPlayer play];
}
//要不起
-(void)buYaoMusicPlay
{
    [self.buYaoPlayer play];
}

-(void)clickMusicPlay
{
    [self.clickPlayer play];
}

#pragma mark - get
-(AVAudioPlayer *)lobbyBgPlayer
{
    if (!_lobbyBgPlayer) {
        NSURL * url = [[NSBundle mainBundle] URLForResource:@"lobby_bgMusic" withExtension:@"caf"];
        _lobbyBgPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
        _lobbyBgPlayer.numberOfLoops = -1;
    }
    return _lobbyBgPlayer;
}

-(AVAudioPlayer *)gameBgPlayer
{
    if (!_gameBgPlayer) {
        NSURL * url = [[NSBundle mainBundle] URLForResource:@"game_backgroundMusic" withExtension:@"caf"];
        _gameBgPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
        _gameBgPlayer.numberOfLoops = -1;
    }
    return _gameBgPlayer;
}

-(AVAudioPlayer *)gameWinPlayer
{
    if (!_gameWinPlayer) {
        NSURL * url = [[NSBundle mainBundle] URLForResource:@"game_succeed" withExtension:@"caf"];
        _gameWinPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    }
    return _gameWinPlayer;
}

-(AVAudioPlayer *)gameLosePlayer
{
    if (!_gameLosePlayer) {
        NSURL * url = [[NSBundle mainBundle] URLForResource:@"game_fail" withExtension:@"caf"];
        _gameLosePlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    }
    return _gameLosePlayer;
}

-(AVAudioPlayer *)choiceCardPlayer
{
    if (!_choiceCardPlayer) {
        NSURL * url = [[NSBundle mainBundle] URLForResource:@"game_choiceCard" withExtension:@"caf"];
        _choiceCardPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    }
    return _choiceCardPlayer;
}

-(AVAudioPlayer *)danZhangPlayer
{
    if (!_danZhangPlayer) {
        NSURL * url = [[NSBundle mainBundle] URLForResource:@"game_danzhang" withExtension:@"caf"];
        _danZhangPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    }
    return _danZhangPlayer;
}

-(AVAudioPlayer *)duoZhangPlayer
{
    if (!_duoZhangPlayer) {
        NSURL * url = [[NSBundle mainBundle] URLForResource:@"game_duozhang" withExtension:@"caf"];
        _duoZhangPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    }
    return _duoZhangPlayer;
}

-(AVAudioPlayer *)buYaoPlayer
{
    if (!_buYaoPlayer) {
        NSURL * url = [[NSBundle mainBundle] URLForResource:@"game_buyao" withExtension:@"caf"];
        _buYaoPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    }
    return _buYaoPlayer;
}

-(AVAudioPlayer *)clickPlayer
{
    if (!_clickPlayer) {
        NSURL * url = [[NSBundle mainBundle] URLForResource:@"game_click" withExtension:@"caf"];
        _clickPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    }
    return _clickPlayer;
}
@end
