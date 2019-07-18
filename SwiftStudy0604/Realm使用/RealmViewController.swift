//
//  RealmViewController.swift
//  SwiftStudy0604
//
//  Created by wanglishuai on 2019/7/16.
//  Copyright © 2019 King. All rights reserved.
//

import UIKit
import RealmSwift

class RealmViewController: UIViewController {

    
    //保存从数据库中查询出来的结果集
    var consumeItems: Results<Todo>?

    //使用默认的数据库
    let realm = try! Realm()

    lazy var tableView:UITableView = {
        let table = UITableView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height-88), style: .plain)
        table.backgroundColor = #colorLiteral(red: 0.937254902, green: 0.937254902, blue: 0.9568627451, alpha: 1)
        table.delegate = self
        table.dataSource = self
        table.register(UITableViewCell.self, forCellReuseIdentifier: CELLID)
        table.tableFooterView = UIView()
        return table
    }()
    
    lazy var rightItem = UIBarButtonItem(title: "添加", style: .plain, target: self, action: #selector(addData))

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "数据库Realm操作"
        view.addSubview(tableView)
        edgesForExtendedLayout = UIRectEdge(rawValue: UIRectEdge.left.rawValue | UIRectEdge.bottom.rawValue | UIRectEdge.right.rawValue);
        navigationItem.rightBarButtonItem = rightItem
        
        CWLog(Realm.Configuration.defaultConfiguration.fileURL)
        
        //查询所有的消费记录
        consumeItems = realm.objects(Todo.self)

        
        //2. 添加数据
        //查询所有的消费记录
        //已经有记录的话就不插入了
        guard consumeItems?.count == 0 else { return }
        



        
    }
    

    
}

// MARK: UITableViewDataSource  UITableViewDelegate
extension RealmViewController: UITableViewDataSource,UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let consumeItems = consumeItems {
            return consumeItems.count
        }
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CELLID, for: indexPath)
        
        let item = self.consumeItems![indexPath.row]
        cell.textLabel?.text = item.name
        cell.detailTextLabel?.text = "\(item.age)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print("你点击了第\(indexPath.row)个cell")
        
    }
    
    //设置哪些行可以编辑
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    // 设置单元格的编辑的样式
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deletedAction = UITableViewRowAction(style: .default, title: "删除") { (action, indexPath) in
            print("删除点击了")
            if let consumeItems = self.consumeItems {
            let todo = consumeItems[indexPath.row]
                try? self.realm.write {
                    self.realm.delete(todo)
                }
            }
            tableView.reloadData()
        }
        deletedAction.backgroundColor = UIColor.red
        let shareAction = UITableViewRowAction(style: .default, title: "修改") { (action, indexPath) in
            print("修改点击了")
            if let consumeItems = self.consumeItems {
                let todo = consumeItems[indexPath.row]
                try? self.realm.write {
                    todo.name = "iphone + \(indexPath.row)"
                }
            }
            tableView.reloadData()
        }
        shareAction.backgroundColor = UIColor.brown
        return [deletedAction, shareAction]
    }
    
    
}



extension RealmViewController {
    @objc func addData() {
        
        //创建对象
        let type2 = Todo()
        type2.name = "iPhone"
        type2.age = 99
        
        //写入数据库
        try? realm.write {
            realm.add(type2)
        }
        tableView.reloadData()
        
    }
}
