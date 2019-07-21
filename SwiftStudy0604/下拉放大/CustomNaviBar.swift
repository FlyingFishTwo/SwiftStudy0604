//
//  CustomNaviBar.swift
//  study001-导航栏背景随滑动渐变，往上缩小，往下放大效果
//
//  Created by wanglishuai on 2019/7/16.
//  Copyright © 2019 King. All rights reserved.
//

let Screen_Width = UIScreen.main.bounds.size.width
let Screen_Height = UIScreen.main.bounds.size.height
let StateBar_Height = UIApplication.shared.statusBarFrame.height

let CustomHeight : CGFloat = 30

import UIKit


enum NavButtonItemType {
    case leftButtonNavType
    case rightButtonNavType
}

typealias ButtonClickNavClosure = (NavButtonItemType)->()


class CustomNaviBar: UIView {
    
    var navButtonClosure : ButtonClickNavClosure?
    
    var leftBtn : UIButton!
    var rightBtn : UIButton!
    var titleLabel : UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.frame = frame

        self.backgroundColor = UIColor.clear
        
        self.leftBtn = UIButton.init(type: .custom)
        self.leftBtn.frame = CGRect.init(x: 16, y: StateBar_Height+10, width: CustomHeight, height: CustomHeight)
        self.leftBtn.setImage(UIImage.init(named: "button-返回"), for: .normal)
        self.addSubview(self.leftBtn)
        
        self.rightBtn = UIButton.init(type: .custom)
        rightBtn.setImage(UIImage.init(named: "mine-setting-iconN"), for: .normal)
        self.rightBtn.frame = CGRect.init(x: Screen_Width-15-CustomHeight, y: StateBar_Height+10, width: CustomHeight, height: CustomHeight)
        self.addSubview(self.rightBtn)
        
        self.titleLabel = UILabel.init(frame: CGRect.init(x: Screen_Width/2-50, y: StateBar_Height+10, width: 100, height: CustomHeight))
        self.titleLabel.text = "测试标题"
        self.titleLabel.textAlignment = .center
        self.titleLabel.font = UIFont.systemFont(ofSize: 15)
        self.titleLabel.textColor = UIColor.white
        self.addSubview(self.titleLabel)
        
        leftBtn.addTarget(self, action: #selector(buttonNavClick(event:)), for: .touchUpInside)
        rightBtn.addTarget(self, action: #selector(buttonNavClick(event:)), for: .touchUpInside)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    @objc func buttonNavClick(event:UIButton) {
        if event.isEqual(leftBtn) {
            self.navButtonClosure!(NavButtonItemType.leftButtonNavType)
        }else if event.isEqual(rightBtn){
            self.navButtonClosure!(NavButtonItemType.rightButtonNavType)
        }
        
    }
    
}
