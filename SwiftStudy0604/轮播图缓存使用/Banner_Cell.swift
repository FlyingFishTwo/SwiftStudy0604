//
//  Banner_Cell.swift
//  SwiftStudy0604
//
//  Created by wanglishuai on 2019/7/12.
//  Copyright © 2019 King. All rights reserved.
//

import UIKit
import Reusable
import Then
import Kingfisher
import SnapKit
import SVProgressHUD


protocol  CloseClickBtnDelegate :NSObjectProtocol{
    //按钮点击方法
    func clickWithCell(cell:Banner_Cell)
    
}

class Banner_Cell: UITableViewCell,Reusable,HJImageBrowserDelegate {
    
    ///声明代理
    weak var delegate : CloseClickBtnDelegate?
    
    var king :KingCell_HeightModel?{
        didSet{
            //数据赋值
            headImageV.kf.setImage(with: URL(string: king?.model?.imageURL ?? ""))
            userNameLabel.text = king?.model?.username
            titleLabel.text = king?.model?.title
            timeLabel.text = king?.model?.time
            contentLabel.text = king?.model?.content
            
            //设置超过规定的行数 隐藏按钮
            if king?.isMoreThanOneLine == false {
                closureBtn.isHidden = false
            }else{
                closureBtn.isHidden = true
            }
            //设置关闭展开按钮
            if king?.model?.isOpen == false {
                closureBtn.setTitle("展开", for: .normal)
            }else{
                closureBtn.setTitle("闭合", for: .normal)
            }

            //坐标赋值
            headImageV.frame = king?.headImageViewRect ?? CGRect.zero
            //头像切圆角要在这里确定了大小之后设置，否则用此方法切圆角无效
            headImageV.setMutiBorderRoundingCorners(headImageV, corner: 10, rect: headImageV.bounds)

            titleLabel.frame = king?.titleLabelRect ?? CGRect.zero
            contentLabel.frame = king?.contentLabelRect ?? CGRect.zero

            //计算 CollectionView  item 的大小 和间距
            collectionView.frame = king?.collectionVRect ?? CGRect.zero
            flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)

            if king?.model?.images?.count == 0 {
                flowLayout.itemSize = CGSize(width: 0, height: 0)
            }else if king?.model?.images?.count == 1{
                flowLayout.itemSize = CGSize(width: collectionView.frame.height, height: collectionView.frame.height)
                flowLayout.minimumLineSpacing = 0
            }else if king?.model?.images?.count == 2{
                let height = collectionView.frame.height
                flowLayout.itemSize = CGSize(width: height, height: height)
//                flowLayout.minimumLineSpacing = 0
                flowLayout.minimumInteritemSpacing = Configs.Dimensions.minimum_Spacing
            }else if king?.model?.images?.count == 3{
                let height = collectionView.frame.height
                flowLayout.itemSize = CGSize(width: height, height: height)
                //                flowLayout.minimumLineSpacing = 0
                flowLayout.minimumInteritemSpacing = Configs.Dimensions.minimum_Spacing
            }else if king?.model?.images?.count == 4{
                let height = collectionView.frame.height
                flowLayout.itemSize = CGSize(width: (height - Configs.Dimensions.minimum_Spacing*2)/2,
                                             height: (height - Configs.Dimensions.minimum_Spacing*2)/2)
                flowLayout.minimumLineSpacing = Configs.Dimensions.minimum_Spacing
                flowLayout.minimumInteritemSpacing = Configs.Dimensions.minimum_Spacing
            }else if king?.model?.images?.count == 5 || king?.model?.images?.count == 6 {
                let height = collectionView.frame.height
                flowLayout.itemSize = CGSize(width: (height - Configs.Dimensions.minimum_Spacing)/2,
                                             height: (height - Configs.Dimensions.minimum_Spacing)/2)
                flowLayout.minimumLineSpacing = Configs.Dimensions.minimum_Spacing
                flowLayout.minimumInteritemSpacing = Configs.Dimensions.minimum_Spacing
                
            }else if (king?.model?.images!.count)! >= 7{
                let height = collectionView.frame.height
                flowLayout.itemSize = CGSize(width: (height - Configs.Dimensions.minimum_Spacing*2)/3,
                                             height: (height - Configs.Dimensions.minimum_Spacing*2)/3)
                flowLayout.minimumLineSpacing = Configs.Dimensions.minimum_Spacing
                flowLayout.minimumInteritemSpacing = Configs.Dimensions.minimum_Spacing
            }
            
            collectionView.reloadData()
        }
    }

    
    
    lazy var flowLayout = UICollectionViewFlowLayout()
    
    
    //标题
    lazy var titleLabel = UILabel().then {
        $0.font = UIFont(name: Configs.Dimensions.wordRegular, size: 13.0)
        $0.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        $0.textAlignment = .left
//        $0.backgroundColor = UIColor.lightGray

    }
    //用户名
    lazy var userNameLabel = UILabel().then {
        $0.font = UIFont(name: Configs.Dimensions.wordRegular, size: 13.0)
        $0.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        $0.textAlignment = .left
//        $0.backgroundColor = UIColor.lightGray
    }
    //时间
    lazy var timeLabel = UILabel().then {
        $0.font = UIFont(name: Configs.Dimensions.wordRegular, size: 13.0)
        $0.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        $0.textAlignment = .left
//        $0.backgroundColor = UIColor.lightGray

    }
    //文本
    lazy var contentLabel = UILabel().then {
        $0.font = UIFont(name: Configs.Dimensions.wordRegular, size: 13.0)
        $0.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        $0.textAlignment = .left
        $0.numberOfLines = 0
//        $0.backgroundColor = #colorLiteral(red: 0.8705882353, green: 0.8705882353, blue: 0.8705882353, alpha: 1)
    }
    //头像
    lazy var headImageV = UIImageView().then{
        $0.backgroundColor = UIColor.lightGray
    }
    

    //文本折叠按钮
    lazy var closureBtn = UIButton().then({
        $0.setTitle("展开", for: .normal)
        $0.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        $0.titleLabel?.font = UIFont(name: Configs.Dimensions.wordRegular, size: 13.0)
        $0.backgroundColor = #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 5
        //折叠按钮的点击方法
        $0.addTarget(self, action: #selector(buttonClick(event:)), for: .touchUpInside)
    })
    
    @objc func buttonClick(event:UIButton) {
        guard let cusDelegate = delegate else {
            return
        }
        cusDelegate.clickWithCell(cell: self)
    }

    //懒加载图片
    lazy var collectionView :UICollectionView = {
        let collection = UICollectionView(frame: CGRect(x: 0, y: 100, width: Configs.Dimensions.screenWidth, height: 100),
                                                        collectionViewLayout: flowLayout)
        collection.delegate = self
        collection.dataSource = self
        collection.backgroundColor = .white
        collection.register(cellType: King_FriendsCircleItem.self)
        return collection
    }()

    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        add_Label_HeaderImageView()
        
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

}

// 点击放大 遵循HJImageBrowserDelegate
extension Banner_Cell :UICollectionViewDataSource,UICollectionViewDelegate{
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return king?.model?.images?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item:King_FriendsCircleItem = collectionView.dequeueReusableCell(for: indexPath, cellType: King_FriendsCircleItem.self)
        
        item.imageV.kf.setImage(with: URL(string: (king?.model?.images![indexPath.item])!), placeholder: nil, options: nil, progressBlock: { (receivedSize, totalSize) in
            let progress = Float(receivedSize) / Float(totalSize)
            SVProgressHUD.showProgress(progress)
            SVProgressHUD.setBackgroundColor(.clear)
            SVProgressHUD.setForegroundColor(UIColor.white)
        }) { (image, error, cacheType, url) in
            SVProgressHUD.dismiss()
        }

        return item
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let bview = HJImageBrowser()
        bview.delegate = self
        bview.bottomView = collectionView
        bview.indexImage = indexPath.item
        bview.defaultImage = getColorImageWithColor()
        bview.arrayImage = king?.model?.images
        bview.show()
    }
    
    //HJImageBrowser 的代理方法
    func getTheThumbnailImage(_ indexRow: Int) -> UIImage {
        // 这个代理返回的是 占位图片 ！！！！！！！！
        return getColorImageWithColor() 
    }

    
    
}


// 添加控件
extension Banner_Cell {
    func add_Label_HeaderImageView() {
        contentView.addSubview(headImageV)
        contentView.addSubview(userNameLabel)
        contentView.addSubview(timeLabel)
        contentView.addSubview(titleLabel)
        contentView.addSubview(contentLabel)
        contentView.addSubview(collectionView)
        contentView.addSubview(closureBtn)
        
        userNameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(headImageV.snp.right).offset(15)
            make.top.equalTo(headImageV.snp.top).offset(5)
        }
        timeLabel.snp.makeConstraints { (make) in
            make.left.equalTo(userNameLabel.snp.right).offset(10.0)
            make.top.equalTo(userNameLabel)
        }

        closureBtn.snp.makeConstraints { (make) in
            make.right.equalTo(contentView).offset(-15)
            make.bottom.equalTo(titleLabel)
            make.size.equalTo(CGSize(width: 50, height: 30))
        }
    }
}


