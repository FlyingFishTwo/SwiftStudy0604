//
//  UIView+Extension.swift
//  SwiftStudy0604
//
//  Created by wanglishuai on 2019/7/9.
//  Copyright © 2019 King. All rights reserved.
//

import UIKit


extension UIView {
    /**
     * 设置uiview 的任意圆角
     **/
    func setMutiBorderRoundingCorners(_ view:UIView,corner:CGFloat,rect:CGRect) {
//        let rect = CGRect(x: 0, y: 0, width: 50, height: 50)
        let maskPath = UIBezierPath.init(roundedRect: rect,
                                         byRoundingCorners: [UIRectCorner.allCorners],
                                         cornerRadii: CGSize(width: corner, height: corner))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = rect
        maskLayer.path = maskPath.cgPath
        view.layer.mask = maskLayer
    }

    //边框
    func SetBorderWithView(_ view:UIView,top:Bool,left:Bool,bottom:Bool,right:Bool,width:CGFloat,color:UIColor) {
        if top {
            let layer = CALayer()
            layer.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: width)
            layer.backgroundColor = color.cgColor
            view.layer.addSublayer(layer)
        }
        
        if left {
            let layer = CALayer()
            layer.frame = CGRect(x: 0, y: 0, width: width, height: view.frame.size.height)
            layer.backgroundColor = color.cgColor
            view.layer.addSublayer(layer)
        }
        
        if bottom {
            let layer = CALayer()
            layer.frame = CGRect(x: 0, y: view.frame.size.height - width, width: width, height: width)
            layer.backgroundColor = color.cgColor
            view.layer.addSublayer(layer)
        }
        
        if right {
            let layer = CALayer()
            layer.frame = CGRect(x: view.frame.size.width - width, y: 0, width: width, height: view.frame.size.height)
            layer.backgroundColor = color.cgColor
            view.layer.addSublayer(layer)
        }
    }
    
    
    
    

    
}





