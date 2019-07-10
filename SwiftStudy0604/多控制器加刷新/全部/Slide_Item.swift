//
//  Slide_Item.swift
//  SwiftStudy0604
//
//  Created by wanglishuai on 2019/7/10.
//  Copyright © 2019 King. All rights reserved.
//

import UIKit
import Reusable
import SnapKit

class Slide_Item: UICollectionViewCell ,Reusable{

    
    lazy var imageV:UIImageView = {
       let V_image = UIImageView()
        return V_image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageV)
        
        imageV.snp.makeConstraints {
            $0.top.left.bottom.right.equalTo(contentView)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
