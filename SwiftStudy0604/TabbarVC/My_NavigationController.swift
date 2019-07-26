//
//  My_NavigationController.swift
//  SwiftStudy0604
//
//  Created by wanglishuai on 2019/7/24.
//  Copyright © 2019 King. All rights reserved.
//

import UIKit

class My_NavigationController: UINavigationController,UINavigationControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        let navigationBar = UINavigationBar.appearance()

        //导航栏背景颜色
        navigationBar.isTranslucent = false
        navigationBar.barTintColor =  UIColor.white
        //导航标题文字
        navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor : UIColor.black,
            NSAttributedString.Key.font : UIFont.systemFont(ofSize: 17)
        ]
        navigationBar.setBackgroundImage(UIImage(named: "navigation_background"), for: .default)
        
        //添加侧滑返回
        fullScreenSideslipBacktotheSuperiorMenu()

    }
    
    //重写push方法
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if self.viewControllers.count > 0 {
            
            viewController.hidesBottomBarWhenPushed = true
            //这里将返回的方法交给  viewController   这样可以重写返回方法
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "lefterbackicon_titlebar_24x24_"), style: .plain, target: viewController, action: #selector(navigationBack))
    
        }
        //是否开启动画由传入决定，不会造成冲突
        super.pushViewController(viewController, animated: animated)
    }
    

    

    /// 返回上一控制器  这里不做方法实现，方法的实现交给 Base_ViewController  来做以后继承自Base_ViewController的控制器可以重写返回方法
    @objc private func navigationBack() {}

}

// MARK: 全屏侧滑返回上级菜单
extension My_NavigationController {
    func fullScreenSideslipBacktotheSuperiorMenu() {
        //1.获取系统的Pop手势
        guard let systemGes = interactivePopGestureRecognizer else { return }
        //2.获取手势添加到的View中
        guard  let gesView = systemGes.view else { return }
        let targets = systemGes.value(forKey: "_targets") as? [NSObject]
        guard let targetObjc = targets?.first else { return }
        //取出target
        guard let target = targetObjc.value(forKey: "target") else { return }
        //取出action
        let action = Selector(("handleNavigationTransition:"))
        // 创建自己的pan手势
        let panGes = UIPanGestureRecognizer()
        gesView.addGestureRecognizer(panGes)
        panGes.addTarget(target, action: action)
    }
}

/***
 iOS开发中用系统的导航栏，有时需要在点击返回按钮时处理一些业务，这时就需要重写返回按钮的事件。目前找到的方案都不太理想，例如iOS重写系统中的UINavigationController返回按钮的事件，过于复杂。于是试着解决这个问题。
 
 self.navigationItem.backBarButtonItem=[[UIBarButtonItem alloc] initWithImage:@"navi_back" style:UIBarButtonItemStylePlain target:self action:@selector(goBack:)];
 这个方法不走goBack:方法，似乎apple默认了一个事件，而不能通过设置backBarButtonItem修改，不可行。
 
 self.navigationItem.hidesBackButton = YES;
 self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc] initWithImage:@"navi_back"
 target:self
 action:@selector(goBack:)];
 self.navigationItem.leftItemsSupplementBackButton = YES;
 通过隐藏返回按钮，设置leftBarButtonItem可以完美解决这个问题，并且更简单些。
 
 ---------------------
 作者：stlwtr
 来源：CSDN
 原文：https://blog.csdn.net/yanglishuan/article/details/52486954
 版权声明：本文为博主原创文章，转载请附上博文链接！
 **/
