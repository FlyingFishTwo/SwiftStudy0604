//
//  Base_ViewController.swift
//  SwiftStudy0604
//
//  Created by wanglishuai on 2019/7/18.
//  Copyright © 2019 King. All rights reserved.
//

import UIKit

class Base_ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        if #available(iOS 11.0, *) {
            UIScrollView.appearance().contentInsetAdjustmentBehavior = .never
        } else {
            self.automaticallyAdjustsScrollViewInsets = false
        }
        
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
//        edgesForExtendedLayout = []



        
    }
    
    //返回上一级界面
    @objc func navigationBack(){
        self.navigationController?.popViewController(animated: true)
    }

    
}
