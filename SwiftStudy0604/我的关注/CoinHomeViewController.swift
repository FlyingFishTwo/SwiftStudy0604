//
//  CoinHomeViewController.swift
//  SwiftStudy0604
//
//  Created by wanglishuai on 2019/6/30.
//  Copyright © 2019 King. All rights reserved.
//

import UIKit

import CommonCrypto
import RxSwift
import RxCocoa


let CoinHomeViewTableViewCell_Id = "CoinHomeViewTableViewCell_Id"

class CoinHomeViewController: Base_ViewController {
    
    var concerns = [MyConcern]()
    
    
    lazy var tableView :UITableView = {
       let table = UITableView(frame: CGRect(x: 0, y: 0, width: Configs.Dimensions.screenWidth, height: Configs.Dimensions.screenHeight), style: .plain)
        table.register(CoinView_Cell.self, forCellReuseIdentifier: CoinHomeViewTableViewCell_Id)
        table.delegate = self
        table.dataSource = self
        table.tableFooterView = UIView()
        table.rowHeight = 140.0
        table.backgroundColor = UIColor.clear
        table.separatorStyle = .none
        return table
    }()
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        view.addSubview(tableView)
        
        getMyfollowData(device_id: "6096495334")
        
        
    }
    
    
    
}

extension CoinHomeViewController:NetWorkToolsProtocol {
    //获取数据  刷新
    func getMyfollowData(device_id:String) {
        NetWorkTools.loadMyConcern(device_id: device_id) { (myConcerns) in
            CWLog(myConcerns)
            self.concerns = myConcerns
//            let indexSet = NSIndexSet(index: 0)
//            self.tableView.reloadSections(indexSet as IndexSet, with: .automatic)
            self.tableView.reloadData()
        }
        
        
    }
    
}


extension CoinHomeViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CoinHomeViewTableViewCell_Id, for: indexPath) as! CoinView_Cell
        
        cell.myConcerns = concerns

        return cell
    }
    
    
    
}
