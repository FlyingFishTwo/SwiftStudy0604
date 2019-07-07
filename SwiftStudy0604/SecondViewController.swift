//
//  SecondViewController.swift
//  SwiftStudy0604
//
//  Created by wanglishuai on 2019/6/19.
//  Copyright © 2019 King. All rights reserved.
//

import UIKit


// 声明协议
protocol Back_ViewDelegate: NSObjectProtocol {
    //设置协议方法
    func returnValue(text:String)
    
}




enum clouseSecondType {
    case stringType
    case floatType
}

class SecondViewController: UIViewController {
    //声明闭包  字符串作为参数
    typealias nameClouse = (_ nameString:String)->()
    var callBackString : nameClouse?
    
    //声明闭包  Float  作为参数
    typealias valueBlock = (Float)->()
    var returnPrice: valueBlock?
    
    //声明闭包  枚举值  作为参数
    typealias secondClouse = (clouseSecondType)->()?
    var typePrice: secondClouse?

    var titleString = "1"
    
    ///声明代理
    weak var delegate: Back_ViewDelegate?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)
        
        titleString = "0"
        
       
    }
    
}

extension SecondViewController {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //调用该闭包"

//        self.callBackString!("123")
//        self.returnPrice!(1232.21123)

//        if titleString == "1" {
//            self.typePrice!(clouseSecondType.stringType)
//        }else{
//            self.typePrice!(clouseSecondType.floatType)
//        }
        
        
        ///这里代理传值
        delegate?.returnValue(text: "4230980uforejfiojer")
        self.navigationController?.popViewController(animated: true)


    }
    
    

}
