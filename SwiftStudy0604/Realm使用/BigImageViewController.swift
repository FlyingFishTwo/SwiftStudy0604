//
//  BigImageViewController.swift
//  SwiftStudy0604
//
//  Created by wanglishuai on 2019/7/20.
//  Copyright © 2019 King. All rights reserved.
//

import UIKit
import SnapKit
import ETNavBarTransparent



let NavigationBarHight = 64.0
let ImageHight = 200.0

let cell_ID = "cell_ID"


class BigImageViewController: Base_ViewController {

    var tableView: UITableView!
    var zoomImageView: UIImageView?
    var circleView: UIImageView!
    var nameLabel: UILabel!
    var changeHeaderBtn: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "平滑过渡"

        self.navBarBgAlpha = 0
        self.navBarTintColor = .red

        addTableView()
        
    }
    
    
}

// MARK: tableView 代理协议方法
extension BigImageViewController : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cell_ID, for: indexPath)
        cell.textLabel?.text = String(format: "第-%ld-天 ", indexPath.row)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: 设置偏移量  修改背景图片的缩放
extension BigImageViewController  {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //根据实际选择 加不加上NavigationBarHigth(44,64 或者没有导航条)
        let y = scrollView.contentOffset.y
        if y < CGFloat(-ImageHight) {
            guard var frame = zoomImageView?.frame else {
                return
            }
            frame.origin.y = y
            frame.size.height = -y
            zoomImageView?.frame = frame
            navBarBgAlpha = 1
            navBarTintColor = UIColor.defaultNavBarTintColor

        }else{
            navBarBgAlpha = 0
            navBarTintColor = .red

        }

    }
}


// MARK:  添加 tableView
extension BigImageViewController  {
    
    func addTableView() {
        //1.初始化_tableView  不要使用懒加载   否则跳转来到本界面的时候可能顶部图片会向上偏移
        tableView = UITableView(frame: view.bounds, style: .plain)
        //2.设置代理
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cell_ID)
        //3.设置contentInset属性（上左下右 的值）
        tableView.contentInset = UIEdgeInsets(top: 288, left: 0, bottom: 0, right: 0)
        
        zoomImageView = UIImageView(image: UIImage(named: "headerImage"))
        zoomImageView?.frame = CGRect(x: 0, y: CGFloat(-ImageHight), width: view.frame.size.width, height: CGFloat(ImageHight))
        //核心就是这句代码!
        //UIViewContentModeScaleAspectFill高度改变,宽度也会改变
        //不设置那将只会被纵向拉伸
        zoomImageView?.contentMode = .scaleAspectFill
        //6.设置autoresizesSubviews让子类自动布局
        zoomImageView?.autoresizesSubviews = true
        zoomImageView?.isUserInteractionEnabled = true
        
        //头像
        circleView = UIImageView(frame: CGRect(x: Int((zoomImageView?.frame.midX)!-25), y: Int(ImageHight/2+25), width: 50, height: 50))
        circleView.backgroundColor = UIColor.red
        circleView.layer.cornerRadius = 7.5
        circleView.image = UIImage(named: "headerImage")
        circleView.clipsToBounds = true
        circleView.autoresizingMask = .flexibleTopMargin //自动布局，自适应顶部
        
        //昵称
        nameLabel = UILabel(frame: CGRect(x: Int(16), y: Int(circleView.frame.maxY), width: 280, height: 20))
        nameLabel.textColor = UIColor.white
        nameLabel.text = "@king"
        nameLabel.autoresizingMask = .flexibleTopMargin //自动布局，自适应顶部
        
        //修改头像按钮
        changeHeaderBtn = UIButton(type: .custom)
        changeHeaderBtn.backgroundColor = #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)
        changeHeaderBtn.frame = CGRect(x: Int(nameLabel.frame.minX), y: Int(nameLabel.frame.maxY+10), width: 70, height: 30)
        changeHeaderBtn.addTarget(self, action: #selector(buttonClick), for: .touchUpInside)
        changeHeaderBtn.setTitle("修改头像", for: .normal)
        changeHeaderBtn.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        changeHeaderBtn.clipsToBounds = true
        changeHeaderBtn.layer.cornerRadius = 5
        changeHeaderBtn.autoresizingMask = .flexibleTopMargin //自动布局，自适应顶部
        
        
        //4.添加tableView
        view.addSubview(tableView)
        tableView.addSubview(zoomImageView!)
        zoomImageView?.addSubview(circleView)
        zoomImageView?.addSubview(nameLabel)
        zoomImageView?.addSubview(changeHeaderBtn)
        
        // 布局约束
        circleView.snp.makeConstraints { (make) in
            make.center.equalTo(zoomImageView!)
            make.size.equalTo(CGSize(width: 50, height: 50))
        }
        
        nameLabel.snp.makeConstraints { (make) in
            make.right.equalTo(circleView.snp.centerX).offset(-16)
            make.top.equalTo(circleView.snp.bottom).offset(10)
        }
        changeHeaderBtn.snp.makeConstraints { (make) in
            make.left.equalTo(circleView.snp.centerX).offset(16)
            make.top.equalTo(nameLabel)
            make.width.equalTo(changeHeaderBtn.width+5)
        }
        
        //解决tableView  在nav 遮挡的时候 还会透明的显示问题;
        edgesForExtendedLayout = []
    }
    
    @objc func buttonClick() {
        
        print("修改")
    }

}

