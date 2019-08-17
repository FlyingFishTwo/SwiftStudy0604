//
//  AppDelegate.swift
//  SwiftStudy0604
//
//  Created by wanglishuai on 2019/6/4.
//  Copyright © 2019 King. All rights reserved.
//



import UIKit
import IQKeyboardManagerSwift
import SwiftyBeaver


let log = SwiftyBeaver.self

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // 初始化
        KingProgressHUD.initLXFProgressHUD()

        configureWithSwiftyBeaver()
        
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true

//        window = UIWindow(frame: UIScreen.main.bounds)
//        window?.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
//        let nav = UINavigationController(rootViewController: ViewController())
//        window?.rootViewController = nav
//        window?.makeKeyAndVisible()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        window?.rootViewController = MyTabBarController()
        window?.makeKeyAndVisible()

        
        
        
        return true
    }
    
    func configureWithSwiftyBeaver() {
        //添加log目的,最少一项
        
        // Xcode控制台日志
        let console = ConsoleDestination()
        // 默认swiftybeaver.log文件日志
        let file = FileDestination()
        // cloud平台配置
        let cloud = SBPlatformDestination(appID: "foo", appSecret: "bar", encryptionKey: "123")
        
        
        // 使用自定义格式输出短时间、日志级别、信息
        // console.format = "$DHH:mm:ss$d $L $M"
        // 或者使用 console.format = "$J" 输出JSON格式
        
        //添加配置到SwiftyBeaver
        log.addDestination(console)
        log.addDestination(file)
        log.addDestination(cloud)
        
        //日志具有不同重要性
        log.verbose("not so important")                 // 优先级 1, VERBOSE   紫色
        log.debug("something to debug")                 // 优先级 2, DEBUG     绿色
        log.info("a nice information")                  // 优先级 3, INFO      蓝色
        log.warning("oh no, that won’t be good")        // 优先级 4, WARNING   黄色
        log.error("ouch, an error did occur!")          // 优先级 5, ERROR     红色
        
        //支持类型: 字符串,数字,日期,等等
        log.verbose(123)
        log.info(-123.45678)
        log.warning(Date())
        log.error(["I", "like", "logs!"])
        log.error(["name": "Mr Beaver", "address": "7 Beaver Lodge"])
        
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

