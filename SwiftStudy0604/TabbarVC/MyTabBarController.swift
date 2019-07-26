//
//  MyTabBarController.swift
//  News
//
//  Created by JYB on 2019/5/9.
//  Copyright © 2019 JYB. All rights reserved.
//

import UIKit

class MyTabBarController: UITabBarController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tabbar = UITabBar.appearance()
        tabbar.tintColor = UIColor(red: 245/255.0, green: 90/255.0, blue: 93/255.0, alpha: 1.0)
        
        addChildControllers()
        
    }
    
    
    //添加自控制器
    func addChildControllers() {
        
        setChild(Home_ViewController(), title: "首页", imageName: "home_tabbar_32x32_", seletedImageName: "home_tabbar_press_32x32_")
        setChild(Video_ViewController(), title: "视频", imageName: "video_tabbar_32x32_", seletedImageName: "video_tabbar_press_32x32_")
        setChild(Huoshan_ViewController(), title: "小视频", imageName: "huoshan_tabbar_32x32_", seletedImageName: "huoshan_tabbar_press_32x32_")
        setChild(BigImageViewController(), title: "我的", imageName: "mine_tabbar_32x32_", seletedImageName: "mine_tabbar_press_32x32_")
        
        //tabbar 是readonly 属性，不能直接修改。利用KVC把 readonly属性权限改过来
        setValue(MyTabBar(), forKey: "tabBar")
    }
    
    
    //初始化子控制器
    func setChild(_ childController: UIViewController,title:String,imageName:String,seletedImageName:String) {
        
        //设置tabbar文字和图片
        childController.title = title
        childController.tabBarItem.image = UIImage(named: imageName)
        childController.tabBarItem.selectedImage = UIImage(named: seletedImageName)
        //3.添加导航控制器为 TabBarController 的子控制器
        let navVC = My_NavigationController(rootViewController: childController)
//        navVC.navigationItem.title = title
        addChild(navVC)
        
    }
    
    
    
}
