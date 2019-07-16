//
//  RealmViewController.swift
//  SwiftStudy0604
//
//  Created by wanglishuai on 2019/7/16.
//  Copyright © 2019 King. All rights reserved.
//

import UIKit

class RealmViewController: UIViewController {

    lazy var tableView:UITableView = {
        let table = UITableView(frame: CGRect(x: 0, y: 64, width: self.view.frame.size.width, height: self.view.frame.size.height-88), style: .plain)
        table.backgroundColor = #colorLiteral(red: 0.937254902, green: 0.937254902, blue: 0.9568627451, alpha: 1)
        table.delegate = self
        table.dataSource = self
        table.register(UITableViewCell.self, forCellReuseIdentifier: CELLID)
        table.tableFooterView = UIView()
        return table
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Realm 数据库使用"


    }
    

    
}

// MARK: UITableViewDataSource  UITableViewDelegate
extension RealmViewController: UITableViewDataSource,UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CELLID, for: indexPath)
        cell.textLabel?.text = "这是 --- \(indexPath.row)行"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print("你点击了第\(indexPath.row)个cell")
        
    }
    
}
