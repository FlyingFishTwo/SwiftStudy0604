//
//  WGTableViewHeadView.swift
//  SwiftStudy0604
//
//  Created by wanglishuai on 2019/7/16.
//  Copyright © 2019 King. All rights reserved.
//

import Foundation
import UIKit


var wg_orininalFrame = "wg_orininalFrame"
var wg_imageView = "wg_imageView"
//let WG_CONTENYOFFSET = "WG_CONTENYOFFSET"

extension UITableView {
    /*
     // 参数1: 源对象
     // 参数2: 关键字: 关键字是一个void类型的指针. 每一个关联的关键字都需要时唯一的, 所以, 一般都会定义成静态变量来作为关键字
     // 参数3: 关联的对象
     // 参数4: 策略: 表示相关的对象是通过赋值, 保留引用还是复制的方式进行关联的, 或者这种关联是原子性还是非原子性, 关联策略是通过使用宏定义常量来表示的
     objc_setAssociatedObject(id object, const void *key, id value, objc_AssociationPolicy policy)
     
     */
    
    // public: 表示全局共享, 并且能被继承
    public func wg_setHeaderView(frame: CGRect, image: UIImage?) {
        
        // 创建关联(frame)
        objc_setAssociatedObject(self, &wg_orininalFrame, frame, .OBJC_ASSOCIATION_RETAIN)
        
        // 创建headerView
        let header = UIView.init(frame: frame)
        self.tableHeaderView = header
        
        // 背景图片
        let bgImg = UIImageView.init(frame: frame)
        bgImg.image = image
        bgImg.contentMode = .scaleAspectFill
        self.insertSubview(bgImg, at: 0)
        
        // 创建关联(image)
        objc_setAssociatedObject(self, &wg_imageView, bgImg, .OBJC_ASSOCIATION_RETAIN)
        
        // KVC监听(注意:字符串必须是contentOffset)
        self.addObserver(self, forKeyPath: "contentOffset", options: .new, context: nil)
    }
    
    // 只要有新值变化就会调用该方法
    open override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        // 获取关联的对象
        let orginal = objc_getAssociatedObject(self, &wg_orininalFrame) as? CGRect
        let img = objc_getAssociatedObject(self, &wg_imageView) as? UIImageView
        
        // 偏移量
        let offset = self.contentOffset.y
        if offset < 0 {
            
            img?.frame = CGRect.init(x: offset, y: offset, width: (orginal?.size.width)!-2*offset, height: (orginal?.size.height)!-offset)
        }else{
            img?.frame = orginal!
        }
    }
}


