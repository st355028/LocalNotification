//
//  AppDelegate.m
//  LocalNotify
//
//  Created by MinYeh on 2016/8/27.
//  Copyright © 2016年 MINYEH. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    UIUserNotificationSettings * setting = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert | UIUserNotificationTypeSound | UIUserNotificationTypeBadge categories:nil];
    
    [[UIApplication sharedApplication]registerUserNotificationSettings:setting];
    
    [self callLocalNotification];
    
    return YES;
}

//創造通知物件實體 
-(void)callLocalNotification{
    
    UILocalNotification * localNotification = [UILocalNotification new];
    //設定提示時間
    localNotification.fireDate = [[NSDate alloc]initWithTimeIntervalSinceNow:5];
    //設定提示訊息
    localNotification.alertBody = @"It is my first localNotification !!!!";
    //設定提示音效
    localNotification.soundName = UILocalNotificationDefaultSoundName;
    //設定userInfo
    localNotification.userInfo = @{@"info":@"顯示的內容放這"};
    
    [[UIApplication sharedApplication]scheduleLocalNotification:localNotification];
}

//收到通知時
-(void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification{
    
    if(application.applicationState == UIApplicationStateActive){
        
        //通知在程式內時
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"通知！" message:notification.alertBody preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction * ignore = [UIAlertAction actionWithTitle:@"Ignore" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"Ignore");
        }];
        
        UIAlertAction * viewAction = [UIAlertAction actionWithTitle:@"查看通知內容" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            [self takeActionWithLocalNotification:notification];
        }];
        
        [alert addAction:ignore];
        [alert addAction:viewAction];
        
        [self.window.rootViewController presentViewController:alert animated:true completion:nil];
        
        
    }else{
        //通知在程式外被點擊時
        [self takeActionWithLocalNotification:notification];
    }
}


#pragma mark  通知被點擊時執行
-(void) takeActionWithLocalNotification:(UILocalNotification *)localNotification{
//    NSNumber * notification_id = localNotification.userInfo[@"id"];

    NSString * info = localNotification.userInfo[@"info"];
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"Action takend" message:[NSString stringWithFormat:@"%@",info] preferredStyle:UIAlertControllerStyleAlert];
    
    [self.window.rootViewController presentViewController:alert animated:true completion:nil];
    
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
