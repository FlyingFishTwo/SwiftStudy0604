//
//  DynamicNinePalaceLatticeVC.swift
//  SwiftStudy0604
//
//  Created by wanglishuai on 2019/7/6.
//  Copyright © 2019 King. All rights reserved.
//

import UIKit
//import Reusable


class DynamicNinePalaceLatticeVC: UIViewController {
    
    //模拟数据
    lazy var dataArr = {() -> [[String]] in
        let imageurl = "https://ss0.bdstatic.com/94oJfD_bAAcT8t7mm9GUKT-xh_/timg?image&quality=100&size=b4000_4000&sec=1524808538&di=76f435ac59c559e9076c682dace288ee&src=http://imgsrc.baidu.com/imgad/pic/item/8601a18b87d6277fde06cb1b22381f30e924fcf9.jpg"
        var darr = [[String]]()
        darr.append([])
        for i in 1...9 {
            var temp = [String]()
            for _ in 1...i{
                temp.append(imageurl)
            }
            darr.append(temp)
        }
        return darr
    }()
    

    lazy var tableView:UITableView = {
       let table = UITableView(frame: CGRect(x: 0, y: 0, width: Configs.Dimensions.screenWidth, height: Configs.Dimensions.screenHeight), style: .plain )
        table.delegate = self
        table.dataSource = self
        table.register(UINib.init(nibName: "KL_DynamicNineCell", bundle: nil)   , forCellReuseIdentifier: "KL_DynamicNineCell")
        table.register(cellType: KL_DynamicNineCell.self)
        table.tableFooterView = UIView()
        table.rowHeight = UITableView.automaticDimension
        table.estimatedRowHeight = 100
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        title = "动态九宫格"
        view.addSubview(tableView)
        
    }
    

}


extension DynamicNinePalaceLatticeVC :UITableViewDataSource,UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:KL_DynamicNineCell = tableView.dequeueReusableCell(for: indexPath, cellType: KL_DynamicNineCell.self)
        cell.images = dataArr[indexPath.row]
        
        cell.tapImageBlock = {(index , imageUrl) in
            CWLog("点击了第\(index)张图片，图片链接是\(imageUrl)")
        }
        
        buttonClickWithCell(cell)

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

//cell上按钮点击的方法
extension DynamicNinePalaceLatticeVC {
    private func buttonClickWithCell(_ cell:KL_DynamicNineCell) {
        cell.dynamicButtonclourse = {(_ type:DynamicNineButtonType) in
            if type == DynamicNineButtonType.attentionButton_Type {
                CWLog("点击了关注")
                
            }else if type == DynamicNineButtonType.fabulousButton_Type {
                CWLog("点击了点赞按钮")
                
            }else if type == DynamicNineButtonType.commentButton_Type {
                CWLog("点击了评论按钮")
                
            }else if type == DynamicNineButtonType.forwardButton_Type {
                CWLog("点击了转发按钮")
                
            }
        }
    }
}
