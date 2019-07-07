//
//  KL_DynamicNineCell.swift
//  SwiftStudy0604
//
//  Created by wanglishuai on 2019/7/6.
//  Copyright © 2019 King. All rights reserved.
//


import UIKit
import Kingfisher
import Reusable
import IBAnimatable

//声明一个枚举，用来区分点击的是那一个按钮
enum DynamicNineButtonType {
    case attentionButton_Type // 关注按钮
    case fabulousButton_Type  // 点赞按钮
    case commentButton_Type   // 评论按钮
    case forwardButton_Type   // 转发按钮
}


let screenwidth = Configs.Dimensions.screenWidth

class KL_DynamicNineCell: UITableViewCell,NibReusable {
    
    var tapImageBlock: ((Int, String) -> Void)?
    
    //声明闭包 传点击按钮的枚举值
    typealias DynamicClourse = (DynamicNineButtonType) -> ()
    var dynamicButtonclourse : DynamicClourse?
    
    var images = [String](){
        didSet{
            
            if images.count == 0 {
                imageBackViewHeight.constant = 0
            }
            if images.count == 1 {
                
                let height = screenwidth - 30
                
                imageBackViewHeight.constant = height
                collectionLayout.itemSize = CGSize(width: height, height: height)
                collectionLayout.minimumLineSpacing = 0
                collectionLayout.minimumInteritemSpacing = 0
                
            }
            
            if images.count == 2 {
                let height = (screenwidth - 3 - 30)/2
                imageBackViewHeight.constant = height
                collectionLayout.itemSize = CGSize(width: height, height: height)
                collectionLayout.minimumLineSpacing = 0
                collectionLayout.minimumInteritemSpacing = 3
            }
            
            if images.count == 3 {
                let height = (screenwidth - 6 - 30)/3
                imageBackViewHeight.constant = height
                collectionLayout.itemSize = CGSize(width: height, height: height)
                collectionLayout.minimumLineSpacing = 0
                collectionLayout.minimumInteritemSpacing = 3
            }
            if images.count == 4 {
                
                let height = (screenwidth - 6 - 30)/2
                
                imageBackViewHeight.constant = height * 2 + 3
                collectionLayout.itemSize = CGSize(width: height, height: height)
                collectionLayout.minimumLineSpacing = 3
                collectionLayout.minimumInteritemSpacing = 3
            }
            if images.count > 4 && images.count < 7 {
                
                let height = (screenwidth - 6 - 30)/3
                
                imageBackViewHeight.constant = height * 2 + 3
                
                collectionLayout.itemSize = CGSize(width: height, height: height)
                collectionLayout.minimumLineSpacing = 3
                collectionLayout.minimumInteritemSpacing = 3
            }

            if images.count >= 7 {
                let height = (screenwidth - 6 - 30)/3
                
                imageBackViewHeight.constant = height * 3 + 6
                
                collectionLayout.itemSize = CGSize(width: height, height: height)
                collectionLayout.minimumLineSpacing = 3
                collectionLayout.minimumInteritemSpacing = 3
            }
            collectionView.reloadData()
        }
    }

    @IBOutlet weak var headerImageView: UIImageView!{
        didSet{
            headerImageView.layer.cornerRadius = 22
        }
    }
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var sloganLabel: UILabel!
    @IBOutlet weak var attentionButton: UIButton!{
        didSet{
//            attentionButton.layer.cornerRadius = 15
        }
    }
    
    @IBOutlet weak var contentLable: UILabel!
    @IBOutlet weak var imageBackViewHeight: NSLayoutConstraint!
    @IBOutlet weak var collectionView: UICollectionView!{
        didSet{
            collectionView.register(cellType: KL_ImageCell.self)
            collectionView.dataSource = self
            collectionView.delegate = self
            
        }
    }
    
    @IBOutlet weak var collectionLayout: UICollectionViewFlowLayout!
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBAction func attentionButtonAction(_ sender: AnimatableButton) {
//        CWLog("关注")
        dynamicButtonclourse!(DynamicNineButtonType.attentionButton_Type)
    }

    //点赞 Action
    @IBAction func fabulousAction(_ sender: UIButton) {
        CWLog("点赞")
        dynamicButtonclourse!(DynamicNineButtonType.fabulousButton_Type)
    }
    //评论
    @IBAction func commentAction(_ sender: UIButton) {
        CWLog("评论")
        dynamicButtonclourse!(DynamicNineButtonType.commentButton_Type)
    }
    //转发
    @IBAction func forwardAction(_ sender: UIButton) {
        CWLog("转发")
        dynamicButtonclourse!(DynamicNineButtonType.forwardButton_Type)
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

extension KL_DynamicNineCell: UICollectionViewDataSource, UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if let tapImageBlock = self.tapImageBlock{
            tapImageBlock(indexPath.item, self.images[indexPath.item])
        }
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: KL_ImageCell.self)

        let url = self.images[indexPath.item]
        
//        cell.imageView.setImageWith(URL.init(string: url), placeholder: nil)
        cell.imageView.kf.setImage(with: URL(string: url))

        return cell
        
    }
}
