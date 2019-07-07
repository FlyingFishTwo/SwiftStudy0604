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

class ListBase_Cell: UITableViewCell {
    
    var imageSize:CGSize?
    var imageNew :UIImage?

    var welfaModel:WelfareModel?{
        didSet{
            
            bigImageView.kf.setImage(with: URL(string: (welfaModel?.url!)!))
            
            // 根据图片的url得到一个 image
            let url : URL = URL.init(string: welfaModel!.url!)!
            // 初始化url图片
            let data : NSData! = NSData(contentsOf: url)
            //转为data类型
            if data != nil {
                //判断data不为空，这里是因为swift对类型要求很严，如果未空的话，会崩溃
                imageNew = UIImage.init(data: data as Data, scale: 1)
                //赋值图片
                
            }else{
                // 否则就赋值默认图片
                
            }
            
            CWLog(imageNew)
           
            //根据图片的宽度 d返回一个新的UIImage
            
            let newImage:UIImage = UIImage.resizeImage(image: imageNew!,newWidth:Configs.Dimensions.screenWidth - 30.0)

            leftLabel.text = welfaModel?.desc
            rightLabel.text = welfaModel?.type
            addUIWithHeight(height: newImage.size.height)
      }
    }
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none

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
    
    func addUIWithHeight(height:CGFloat) {
        
        self.addSubview(bigImageView)
        self.addSubview(leftLabel)
        self.addSubview(rightLabel)

        bigImageView.snp.makeConstraints {
            $0.left.top.equalTo(self).offset(15)
            $0.right.equalTo(self).offset(-15)
            $0.height.equalTo(height)
        }
        
        leftLabel.snp.makeConstraints {
            $0.left.equalTo(bigImageView)
            $0.right.equalTo(bigImageView.snp_centerX).offset(-15)
            $0.top.equalTo(bigImageView.snp_bottom).offset(10)
            $0.height.equalTo(30)
            $0.bottom.equalTo(self.snp_bottom).offset(-15)
        }
        rightLabel.snp.makeConstraints {
            $0.right.equalTo(bigImageView)
            $0.top.equalTo(leftLabel)
            $0.left.equalTo(bigImageView.snp_centerX).offset(15)
            $0.height.equalTo(leftLabel)
        }
        
    }
    
    

}



