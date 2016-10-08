//
//  AppDelegate.swift
//  Inke-Swift
//
//  Created by Lumo on 16/10/2.
//  Copyright © 2016年 LM. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        application.statusBarStyle = .LightContent

        window = UIWindow(frame: ScreenFrame)

        let isLogin = NSUserDefaults.standardUserDefaults().boolForKey(LoginOrNotKey)
        if isLogin {
            window?.rootViewController = CustomTabBarController()
        } else {
            window?.rootViewController = LoginViewController()
        }
        
        window?.makeKeyAndVisible()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(logined), name: LoginNotification, object: nil)
        return true
    }
    
    @objc private func logined() {
        let tabBarController = CustomTabBarController()
        window?.rootViewController = tabBarController
    }
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
}

// 自定义log
func LMLog<T>(messaeg:T,file:String = #file,method: String=#function,line: Int=#line) {
    
    #if LM_DEBUG // 调试  Swift中没有宏定义。只能通过自己在Building Setting的Custom Flags里添加-D LM_DEBUG
        print("\((file as NSString).lastPathComponent)-[\(line)]-[\(method)]\n\t[\(messaeg)]")
    #else // 发布
        
    #endif
    
}


