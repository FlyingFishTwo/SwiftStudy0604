//
//  All_Cell.swift
//  SwiftStudy0604
//
//  Created by wanglishuai on 2019/7/10.
//  Copyright © 2019 King. All rights reserved.
//

import UIKit
import Reusable
import SnapKit
import Kingfisher


let height_Collection = 140


class All_Cell: UITableViewCell,Reusable {
    
    var images = [String]()

    
    var all_Model : WelfareModel?{
        didSet{
            whoLabel.text = all_Model?.who
            creatTimeLabel.text = all_Model?.createdAt
            publishedLabel.text = all_Model?.publishedAt
            descLabel.text = all_Model?.desc
            
            guard all_Model?.images != nil else {
                return
            }
            images = all_Model?.images ?? [""]

            collectionView.reloadData()
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        add_UI()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    lazy var whoLabel:UILabel = {
       let who = UILabel()
        who.text = "ALL"
        return who
    }()
    
    lazy var creatTimeLabel:UILabel = {
        let creatTime = UILabel()
        return creatTime
    }()

    lazy var publishedLabel:UILabel = {
        let who = UILabel()
        return who
    }()
    lazy var descLabel:UILabel = {
        let desc = UILabel()
        desc.numberOfLines = 0
        return desc
    }()
    lazy var lineView:UIView = {
        let line = UIView()
        line.backgroundColor = UIColor.lightGray
        return line
    }()
    
    lazy var collectionView:UICollectionView = {
        let collection = UICollectionView(frame: CGRect.zero, collectionViewLayout: AllCollectionLayout())
        collection.delegate = self
        collection.dataSource = self
        collection.register(cellType: Slide_Item.self)
        collection.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        return collection
    }()


    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}

extension All_Cell {
    
    func add_UI() {
        
        contentView.addSubview(whoLabel)
        contentView.addSubview(creatTimeLabel)
        contentView.addSubview(publishedLabel)
        contentView.addSubview(descLabel)
        contentView.addSubview(lineView)
        contentView.addSubview(collectionView)
        
        whoLabel.snp.makeConstraints {
            $0.left.top.equalTo(contentView).offset(15)
        }

        creatTimeLabel.snp.makeConstraints {
            $0.left.equalTo(whoLabel)
            $0.top.equalTo(whoLabel.snp.bottom).offset(5)
        }
        publishedLabel.snp.makeConstraints {
            $0.left.equalTo(creatTimeLabel)
            $0.top.equalTo(creatTimeLabel.snp.bottom).offset(5)
        }

        descLabel.snp.makeConstraints {
            $0.left.equalTo(publishedLabel)
            $0.right.equalTo(contentView.snp.right).offset(-15)
            $0.top.equalTo(publishedLabel.snp.bottom).offset(5)
        }
        collectionView.snp.makeConstraints { (make) in
            make.left.equalTo(whoLabel)
            make.right.equalTo(contentView)
            make.top.equalTo(descLabel.snp.bottom).offset(10)
            make.height.equalTo(height_Collection)
            make.bottom.equalTo(lineView.snp.top).offset(-15)
        }

        lineView.snp.makeConstraints {
            $0.left.equalTo(whoLabel)
            $0.right.equalTo(contentView.snp.right)
            $0.bottom.equalTo(contentView.snp.bottom)
            $0.height.equalTo(1)
        }


    }
    
    
    
}

extension All_Cell :UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item:Slide_Item = collectionView.dequeueReusableCell(for: indexPath, cellType: Slide_Item.self)
        
        item.backgroundColor = UIColor.brown
        let string = images[indexPath.item]
        
        item.imageV.kf.setImage(with: URL(string: string))
        
        return item
    }
    
    
    
}


class AllCollectionLayout: UICollectionViewFlowLayout {

    override func prepare() {
        // cell大小
        itemSize = CGSize(width: 70, height: height_Collection)
        //横向间距
        minimumLineSpacing = 10
        //纵向间距
        minimumInteritemSpacing = 10
        //cell 上下左右的间距
        sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        //设置水平滚动
        scrollDirection = .horizontal
    }

}

