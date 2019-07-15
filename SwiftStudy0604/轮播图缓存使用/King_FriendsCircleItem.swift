//
//  King_FriendsCircleItem.swift
//  SwiftStudy0604
//
//  Created by wanglishuai on 2019/7/12.
//  Copyright © 2019 King. All rights reserved.
//

import UIKit
import Reusable
import Then
import SnapKit
import Kingfisher

class King_FriendsCircleItem: UICollectionViewCell,Reusable {

    
    lazy var imageV = UIImageView().then {
        $0.backgroundColor = .lightGray
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = UIColor.brown
        contentView.addSubview(imageV)
        
        imageV.snp.makeConstraints {
            // 边距 距离父视图 上下左右都是  10
            $0.edges.equalToSuperview()
        }
        

        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    
    
}
