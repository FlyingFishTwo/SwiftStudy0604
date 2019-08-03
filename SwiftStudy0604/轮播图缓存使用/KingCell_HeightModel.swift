//
//  KingCell_HeightModel.swift
//  SwiftStudy0604
//
//  Created by wanglishuai on 2019/7/12.
//  Copyright © 2019 King. All rights reserved.
//

import Foundation

struct KingCell_HeightModel {
    
    var model: KingModel? {
        didSet {
            configRect()
        }
    }
    var headImageViewRect: CGRect!
    var usernameLabelRect: CGRect!
    var timeLabelRect: CGRect!
    var titleLabelRect: CGRect!
    var contentLabelRect: CGRect!
    var collectionVRect: CGRect!
    
    // 声明闭合的行数   大于行数的文本可以展开闭合
    var lineCount: Int = 3

    
    var cellHeight: CGFloat?
    
    // 是否大过闭合的时候的行数
    var isMoreThanOneLine: Bool?

    init(model:KingModel) {
        self.model = model
        configRect()
    }
    
    mutating func configRect() {
        
        guard let model = self.model else {
            return
        }
        
        let margin: CGFloat = 15
        guard model.imageURL != nil else {
            headImageViewRect = CGRect.zero
            return
        }
        
        // headerImageView的坐标
        let headImage_X: CGFloat = 15
        let headImage_Y: CGFloat = 15
        let headImage_W: CGFloat = 50
        let headImage_H: CGFloat = 50
        headImageViewRect = CGRect(x: headImage_X, y: headImage_Y, width: headImage_W, height: headImage_H)
        
        /*******************************************
         如果只是缓存高度，和高度无关的其他控件可以使用自动布局   *************************************************/
        
        // usernameLabel 的坐标   这里的坐标只是为了方便下面的计算，不做 cell 里的usernameLabel 的赋值操作
        let username_X: CGFloat = headImageViewRect.maxX + margin
        let username_Y: CGFloat = headImageViewRect.minY + 5
        let username_W: CGFloat = Configs.Dimensions.screenWidth - username_X - margin
        guard let userName = model.username else { return  }
        let username_H = userName.king_getHeightWithString(string: userName, width: username_W)
        usernameLabelRect = CGRect(x: username_X, y: username_Y, width: username_W, height: username_H)
        
        //titleLabel 的坐标
        let title_X: CGFloat = usernameLabelRect.minX
        let title_Y: CGFloat = usernameLabelRect.maxY + 10
        let title_W: CGFloat = Configs.Dimensions.screenWidth - username_X - margin
        guard let titleM = model.title else { return  }
        let title_H = titleM.king_getHeightWithString(string: titleM, width: title_W)
        titleLabelRect = CGRect(x: title_X, y: title_Y, width: title_W, height: title_H)
        
        // contentLabel 的坐标
        let contentLabel_X: CGFloat = usernameLabelRect.minX
        let contentLabel_Y: CGFloat = headImageViewRect.maxY + 10
        let contentLabel_W: CGFloat = Configs.Dimensions.screenWidth - contentLabel_X - margin
        guard let contentM = model.content else { return  }
        
        // 展开的时候的高度
        var contentLabel_H = contentM.king_getHeightWithString(string: contentM, width: contentLabel_W)
        // 闭合的时候的高度
        let onelineH = "".king_getHeightWithString(string: "", width: contentLabel_W)
        
        if model.isOpen == false {
            if contentLabel_H >= CGFloat(lineCount) * onelineH {
                contentLabel_H =  CGFloat(lineCount) * onelineH
                isMoreThanOneLine = false
            }else{
                contentLabel_H = contentM.king_getHeightWithString(string: contentM, width: contentLabel_W)
                isMoreThanOneLine = true
            }
        }else{
            contentLabel_H = contentM.king_getHeightWithString(string: contentM, width: contentLabel_W)
        }
        
        contentLabelRect = CGRect(x: contentLabel_X, y: contentLabel_Y, width: contentLabel_W, height: contentLabel_H)
        
        
        
        // collection的坐标
        let collection_X: CGFloat = usernameLabelRect.minX
        let collection_Y: CGFloat = contentLabelRect.maxY + 10
        
        let collection_W: CGFloat = Configs.Dimensions.screenWidth - headImageViewRect.minX - usernameLabelRect.minX*2 //  需求中可以计算图片实际大小
        let collection_H: CGFloat = collection_W
        
        if model.images?.count == 1 {
            collectionVRect = CGRect(x: collection_X,
                                     y: collection_Y,
                                     width: collection_W,
                                     height: collection_H)
        }else if model.images?.count == 2{
            collectionVRect = CGRect(x: collection_X,
                                     y: collection_Y,
                                     width: collection_W,
                                     height: (collection_H - Configs.Dimensions.minimum_Spacing)/2)
        }else if model.images?.count == 3{
            collectionVRect = CGRect(x: collection_X,
                                     y: collection_Y,
                                     width: collection_W,
                                     height: (collection_H - Configs.Dimensions.minimum_Spacing*2)/3)
        }else if model.images?.count == 4{
            collectionVRect = CGRect(x: collection_X,
                                     y: collection_Y,
                                     width: collection_W,
                                     height: (collection_H + Configs.Dimensions.minimum_Spacing))
        }else if model.images?.count == 5 || model.images?.count == 6 {
            let itemSize_W = (collection_H - Configs.Dimensions.minimum_Spacing * 2)/3
            collectionVRect = CGRect(x: collection_X,
                                     y: collection_Y,
                                     width: collection_W,
                                     height: itemSize_W * 2 + Configs.Dimensions.minimum_Spacing)
        }else if model.images!.count >= 7  {
            collectionVRect = CGRect(x: collection_X,
                                     y: collection_Y,
                                     width: collection_W,
                                     height: collection_H)
        }else{
            collectionVRect = CGRect.zero
        }
        
        // 如果  model.images的数量为0
        if collectionVRect == CGRect.zero {
            cellHeight = contentLabelRect.maxY + 10
            
            //如果文本为空 则从 headImageViewRect 的 maxY 算起总行高
            if contentM.isEmpty == true {
                cellHeight = headImageViewRect.maxY + margin
            }
        }else{
            cellHeight = collectionVRect.maxY + margin
        }
        
        
        
    }
    
    
}
