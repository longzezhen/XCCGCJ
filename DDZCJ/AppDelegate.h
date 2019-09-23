//
//  AppDelegate.h
//  DDZCJ
//
//  Created by df on 2019/8/30.
//  Copyright © 2019 df. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, assign) NSInteger paipuNumber;
@property (nonatomic, assign) NSInteger gradeNum;
@property (nonatomic, assign) BOOL isInGame;
+(AppDelegate *)shareDelegate;
@end

