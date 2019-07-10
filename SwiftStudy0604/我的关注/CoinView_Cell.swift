//
//  CoinView_Cell.swift
//  SwiftStudy0604
//
//  Created by wanglishuai on 2019/7/1.
//  Copyright © 2019 King. All rights reserved.
//

import UIKit


let coinCollectionCellID = "coinCollectionCellID"


class CoinView_Cell: UITableViewCell {
    
    
    var myConcerns = [MyConcern](){
        didSet{
            collectionVieww.reloadData()
        }
    }

    
    lazy var collectionVieww :UICollectionView = {
       let collection = UICollectionView(frame: CGRect(x: 0, y: 0, width: Configs.Dimensions.screenWidth, height: 130), collectionViewLayout: MyConcernLayout())
        collection.register(CorcensCollection_Cell.self, forCellWithReuseIdentifier: coinCollectionCellID)
        collection.delegate = self
        collection.dataSource = self
        collection.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        return collection
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(collectionVieww)
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

class MyConcernLayout: UICollectionViewFlowLayout {
    
    override func prepare() {
        // cell大小
        itemSize = CGSize(width: 60, height: 100)
        //横向间距
        minimumLineSpacing = 10
        //纵向间距
        minimumInteritemSpacing = 10
        //cell 上下左右的间距
        sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        //设置水平滚动
        scrollDirection = .horizontal
    }
    
}


extension CoinView_Cell:UICollectionViewDelegate,UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return myConcerns.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = collectionView.dequeueReusableCell(withReuseIdentifier: coinCollectionCellID, for: indexPath) as! CorcensCollection_Cell
        item.myConcern = myConcerns[indexPath.item]
        return item
    }
    
}
