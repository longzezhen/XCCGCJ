//
//  AppDelegate.m
//  DDZCJ
//
//  Created by df on 2019/8/30.
//  Copyright © 2019 df. All rights reserved.
//

#import "AppDelegate.h"
#import "LongFirstViewController.h"
#import "DDHomeController.h"
#import "DDZBackgroundMusic.h"
@interface AppDelegate ()

@end

@implementation AppDelegate
+ (AppDelegate *)shareDelegate{
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.paipuNumber = 0;
    self.gradeNum = 1;
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [UIApplication sharedApplication].statusBarHidden = YES;

    LongFirstViewController * vc = [LongFirstViewController new];
    [self.window setRootViewController:vc];
    [self.window makeKeyAndVisible];

    if (![DDGET_CACHE(DDZ_SET_BgMusic) isEqualToString:@"GBBJYY"]) {
        [[DDZBackgroundMusic shareBackgroundMusic] lobbyBackgroundMusicPlay];

    }
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
//    NSLog(@"---------------   applicationWillResignActive");
    [DDZN_C postNotificationName:@"stopAnimation" object:nil];
    
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
//    NSLog(@"---------------   applicationDidEnterBackground");
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
//    NSLog(@"---------------   applicationWillEnterForeground");
    [DDZN_C postNotificationName:@"refreshAnimation" object:nil];
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
//    NSLog(@"---------------   applicationDidBecomeActive");
    
    if (DDGET_CACHE(DDZ_ISEXIT)) {
        NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
        //    NSLog(@"之前时间：%@", [userDefault objectForKey:@"nowDate"]);//之前存储的时间
        //    NSLog(@"现在时间%@",[NSDate date]);//现在的时间
        NSDate *now = [NSDate date];
        NSDate *agoDate = [userDefault objectForKey:@"nowDate"];
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        
        NSString *ageDateString = [dateFormatter stringFromDate:agoDate];
        NSString *nowDateString = [dateFormatter stringFromDate:now];
        //    NSLog(@"日期比较：之前：%@ 现在：%@",ageDateString,nowDateString);
        
        if ([ageDateString isEqualToString:nowDateString]) {
            //        NSLog(@"一天就显示一次");
//            NSLog(@"   --------------------- 不允许送钱  ");
        }else{
            // 需要执行的方法写在这里
//            NSLog(@"   +++++++ 允许送 15 ");
            NSDate *nowDate = [NSDate date];
            NSUserDefaults *dataUser = [NSUserDefaults standardUserDefaults];
            [dataUser setObject:nowDate forKey:@"nowDate"];
            [dataUser synchronize];
            
            //每天送15
            NSString *currentMoney = DDGET_CACHE(DDZ_USER_MONEY);
            currentMoney = [NSString stringWithFormat:@"%d",[currentMoney integerValue]+[Song_Money integerValue]];
            
            DDSET_CACHE(currentMoney, DDZ_USER_MONEY);
            
        }
    }
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.

//    NSLog(@"---------------   applicationWillTerminate");
}


@end
