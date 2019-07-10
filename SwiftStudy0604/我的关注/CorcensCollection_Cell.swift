//
//  CorcensCollection_Cell.swift
//  SwiftStudy0604
//
//  Created by wanglishuai on 2019/7/1.
//  Copyright © 2019 King. All rights reserved.
//

import UIKit
import Kingfisher


class CorcensCollection_Cell: UICollectionViewCell {
    
    var myConcern :MyConcern?{
        didSet{
            headIcon.kf.setImage(with: URL(string: myConcern!.icon!))
            nameLabel.text = myConcern!.name
        }
    }

    lazy var headIcon:UIImageView = {
       let head = UIImageView()
        head.clipsToBounds = true
        head.layer.cornerRadius = 30.0
        return head
    }()
    
    lazy var nameLabel :UILabel = {
       let nameL = UILabel()
        nameL.font = UIFont.systemFont(ofSize: 10.0)
        nameL.textAlignment = .center
        return nameL
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(headIcon)
        addSubview(nameLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


extension CorcensCollection_Cell {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        headIcon.snp.makeConstraints { (make) in
            make.left.top.right.equalTo(self)
            make.height.equalTo(self.snp_width)
        }
        nameLabel.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(self)
            make.top.equalTo(headIcon.snp_bottom).offset(10.0)
        }
    }
    
}
