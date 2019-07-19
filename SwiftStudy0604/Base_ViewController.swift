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
    

        navigationController?.navigationBar.isTranslucent = false

        
    }
    

    
}

extension Base_ViewController {
    override var preferredStatusBarStyle: UIStatusBarStyle {
//        guard let select = selectedViewController else { return .lightContent }
//        return select.preferredStatusBarStyle
        return .`default`
    }
}
