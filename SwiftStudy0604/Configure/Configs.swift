//
//  Configs.swift
//  SwiftStudy0604
//
//  Created by wanglishuai on 2019/6/26.
//  Copyright © 2019 King. All rights reserved.
//

import UIKit

struct Configs {
    
    
    struct Dimensions {
        //屏宽
        static let screenWidth: CGFloat = UIScreen.main.bounds.size.width
        //屏高
        static let screenHeight: CGFloat = UIScreen.main.bounds.size.height
        //状态栏高度
        static let statusBarHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height
        //导航栏高度
        static let naviBarHeight: CGFloat = 44
        //导航栏加状态栏高度
        static let topHeight: CGFloat = statusBarHeight + naviBarHeight

    }
    
}

