//
//  Huoshan_Cell.swift
//  SwiftStudy0604
//
//  Created by wanglishuai on 2019/8/2.
//  Copyright © 2019 King. All rights reserved.
//

import UIKit
import Reusable
import Then
import SnapKit

class Huoshan_Cell: UITableViewCell , Reusable{
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        add_LayoutUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    lazy var bigImageV:UIImageView =  {
       let imageV = UIImageView()
//        imageV.backgroundColor = UIColor.brown
        return imageV
    }()
    lazy var desLabel = UILabel().then { (lab) in
//        lab.backgroundColor = UIColor.brown
        lab.numberOfLines = 0
    }
    lazy var fromLabel = UILabel().then { (lab) in
//        lab.backgroundColor = UIColor.brown
        lab.numberOfLines = 0
    }

    lazy var lineView:UIView = UIView().then{
        $0.backgroundColor = UIColor.lightGray
    }

}

extension Huoshan_Cell {
    func add_LayoutUI() {
        contentView.addSubview(desLabel)
        contentView.addSubview(fromLabel)
        contentView.addSubview(bigImageV)
        contentView.addSubview(lineView)

        bigImageV.snp.makeConstraints { (make) in
            make.top.left.equalTo(contentView).offset(15)
            make.bottom.equalTo(contentView.snp.bottom).offset(-15)
            make.width.equalTo(240)
        }
        desLabel.snp.makeConstraints { (make) in
            make.left.equalTo(bigImageV.snp.right).offset(10.0)
            make.right.equalTo(contentView).offset(-15)
            make.top.equalTo(bigImageV)
        }
        fromLabel.snp.makeConstraints { (make) in
            make.left.equalTo(desLabel)
            make.top.equalTo(desLabel.snp.bottom).offset(15)
            make.right.equalTo(desLabel)
        }
        lineView.snp.makeConstraints { (make) in
            make.left.equalTo(bigImageV)
            make.bottom.right.equalTo(contentView)
            make.height.equalTo(0.5)
        }
        
    }
}

extension Huoshan_Cell {
    static func cellHeigh() -> CGFloat {
        return 240
    }
}
