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

        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        // tableView 从导航栏以下开始
        self.edgesForExtendedLayout = UIRectEdge(rawValue: UIRectEdge.left.rawValue | UIRectEdge.bottom.rawValue | UIRectEdge.right.rawValue);
        


    }
    

    
}
