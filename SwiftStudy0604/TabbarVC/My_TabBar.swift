//
//  My_TabBar.swift
//  SwiftStudy0604
//
//  Created by wanglishuai on 2019/7/24.
//  Copyright © 2019 King. All rights reserved.
//

import UIKit

class MyTabBar: UITabBar {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(publishButton)
    }
    // private 绝对私有。除了在当前类中可以访问之外，其他任何类或者该类的扩展都不能访问
    // fileprivate 文件私有 可以在当前类的文件中访问。其他都不能访问
    
    // Open 在任何类文件都可以访问
    // internal  默认。也可以不写
    private lazy var publishButton : UIButton = {
        let button = UIButton(type: .custom)
        button.setBackgroundImage(UIImage(named: "feed_publish_44x44_"), for: .normal)
        button.setBackgroundImage(UIImage(named: "feed_publish_close_44x44_"), for: .selected)
        button.sizeToFit()
        button.addTarget(self, action: #selector(buttonClick(event:)), for: .touchUpInside)

        return button
    }()
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func buttonClick(event:UIButton) {
//        CWLog(event.imageView?.image)
        CWLog("点击了中间按钮")
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // 当前tabbar的宽度和高度
        let width = frame.width
        let height = frame.height
        
        publishButton.center = CGPoint(x: width*0.5, y: height*0.5-17)
        
        //设置其他按钮的frame
        let buttonW = width * 0.2
        let buttonH = 49.0    //这里要适配的
        let buttonY = 0
        var index = 0
        
        for (button) in subviews {
            
            if !button.isKind(of: NSClassFromString("UITabBarButton")!){ continue }
            let buttonX = buttonW * (index > 1 ? CGFloat(index + 1) : CGFloat(index))
            
            button.frame = CGRect(x: buttonX, y: CGFloat(buttonY), width: buttonW, height: CGFloat(buttonH))
            index += 1
        }
        
        
    }
    
    
}
