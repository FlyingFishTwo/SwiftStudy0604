//
//  ListBase_Cell.swift
//  SwiftStudy0604
//
//  Created by wanglishuai on 2019/6/27.
//  Copyright © 2019 King. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher
import Reusable

class ListBase_Cell: UITableViewCell,Reusable {
    
    var imageSize:CGSize?
    var imageNew :UIImage?

    var welfaModel:WelfareModel?{
        didSet{
            if let url = URL(string: welfaModel?.url ?? "") {
                bigImageView.kf.setImage(with: url)
            }
            leftLabel.text = welfaModel?.desc
            rightLabel.text = welfaModel?.type
        }
    }
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        addUIWithHeight()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var bigImageView:UIImageView = {
       let imageV = UIImageView()
//        imageV.backgroundColor = UIColor.brown
        imageV.contentMode = UIView.ContentMode.scaleAspectFit
        return imageV
    }()
    
    lazy var leftLabel:UILabel = {
        let left = UILabel()
        return left
    }()
    lazy var rightLabel:UILabel = {
        let right = UILabel()
        right.textAlignment = .right
        return right
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    
}


extension ListBase_Cell {
    
    func addUIWithHeight() {
        
        contentView.addSubview(bigImageView)
        contentView.addSubview(leftLabel)
        contentView.addSubview(rightLabel)

        bigImageView.snp.makeConstraints {
            $0.left.top.equalTo(contentView).offset(15)
            $0.right.equalTo(contentView).offset(-15)
            $0.height.equalTo(400)
        }
        
        leftLabel.snp.makeConstraints {
            $0.left.equalTo(bigImageView)
            $0.right.equalTo(bigImageView.snp_centerX).offset(-15)
            $0.top.equalTo(bigImageView.snp_bottom).offset(10)
            $0.height.equalTo(30)
            $0.bottom.equalTo(contentView.snp_bottom).offset(-15)
        }
        rightLabel.snp.makeConstraints {
            $0.right.equalTo(bigImageView)
            $0.top.equalTo(leftLabel)
            $0.left.equalTo(bigImageView.snp_centerX).offset(15)
            $0.height.equalTo(leftLabel)
        }
        
    }
    
    

}



