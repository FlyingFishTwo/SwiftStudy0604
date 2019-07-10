//
//  Cache_Cell.swift
//  SwiftStudy0604
//
//  Created by wanglishuai on 2019/7/8.
//  Copyright © 2019 King. All rights reserved.
//

import UIKit
import Reusable
import Kingfisher
import SnapKit

class Cache_Cell: UITableViewCell,Reusable {
    
// 如果要缓存高度就不要用原来的数据模型，数据源模型添加的是缓存高度的模型，这里做一些修改
//    var cacheM:CacheModel?{
//        didSet{
//            titleLabel.text = cacheM?.title
//            contentLabel.text = cacheM?.content
//            usernameLabel.text = cacheM?.username
//            timeLabel.text = cacheM?.time
//            headIcon.kf.setImage(with: URL(string: cacheM!.imageURL!))
//        }
//    }
    
    // 数据模型赋值
    var cellLayout: CalculatedHeight_Model? {
        didSet{
            //数据s赋值
            guard cellLayout?.model?.imageURL != nil else { return }
            headIcon.kf.setImage(with: URL(string: (cellLayout?.model!.imageURL!)!))
            usernameLabel.text = cellLayout?.model?.username
            titleLabel.text = cellLayout?.model?.title
            timeLabel.text = cellLayout?.model?.time
            contentLabel.text = cellLayout?.model?.content

            
            //模型坐标赋值
            headIcon.frame = cellLayout!.headImageViewRect
            usernameLabel.frame = cellLayout!.usernameLabelRect
            titleLabel.frame = cellLayout!.titleLabelRect
            timeLabel.frame = cellLayout!.timeLabelRect
            contentLabel.frame = cellLayout!.contentLabelRect

            
        }
    }
    
    lazy var headIcon:UIImageView = {
        let head = UIImageView()
        head.backgroundColor = UIColor.green
        head.layer.cornerRadius = 10
        head.clipsToBounds = true
        return head
    }()
    
    lazy var titleLabel:UILabel = {
        let title = UILabel()
        title.textAlignment = .left
        title.textColor = #colorLiteral(red: 0.4756349325, green: 0.4756467342, blue: 0.4756404161, alpha: 1)
        title.font = UIFont.systemFont(ofSize: 13.0)

        return title
    }()
    
    lazy var contentLabel:UILabel = {
        let content = UILabel()
        content.textAlignment = .left
        content.numberOfLines = 0
        content.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
//        content.backgroundColor = #colorLiteral(red: 0.5058823824, green: 0.3372549117, blue: 0.06666667014, alpha: 1)
        content.font = UIFont.systemFont(ofSize: 13.0)
        content.lineBreakMode = NSLineBreakMode.byWordWrapping

        content.sizeToFit()
        return content
    }()
    lazy var usernameLabel:UILabel = {
        let username = UILabel()
        username.textAlignment = .left
        username.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        username.font = UIFont.systemFont(ofSize: 13.0)

        return username
    }()
    lazy var timeLabel:UILabel = {
        let time = UILabel()
        time.textAlignment = .left
        time.font = UIFont.systemFont(ofSize: 13.0)
        return time
    }()

    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addUI()
//        layoutWith_UI()

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}

extension Cache_Cell {
    private func addUI() {
        
        contentView.addSubview(headIcon)
        contentView.addSubview(usernameLabel)
        contentView.addSubview(titleLabel)
        contentView.addSubview(timeLabel)
        contentView.addSubview(contentLabel)

    }
    
    
    func layoutWith_UI() {
        usernameLabel.snp.makeConstraints { (make) in
            make.top.left.equalTo(self)
        }
    }
}


