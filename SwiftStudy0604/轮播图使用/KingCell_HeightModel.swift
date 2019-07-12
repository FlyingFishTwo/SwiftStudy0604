//
//  KingCell_HeightModel.swift
//  SwiftStudy0604
//
//  Created by wanglishuai on 2019/7/12.
//  Copyright © 2019 King. All rights reserved.
//

import Foundation

struct KingCell_HeightModel {
    
    var model: KingModel?
    
    var headImageViewRect: CGRect!
    var usernameLabelRect: CGRect!
    var timeLabelRect: CGRect!
    var titleLabelRect: CGRect!
    var contentLabelRect: CGRect!
    var collectionVRect: CGRect!

    
    var cellHeight: CGFloat?
    
    init(model:KingModel) {
        self.model = model
        
        let margin: CGFloat = 15
        guard model.imageURL != nil else {
            headImageViewRect = CGRect.zero
            return
        }
//        guard model.images?.count == 0 else {
//            return
//        }
        
        // headerImageView的坐标
        let headImage_X: CGFloat = 15
        let headImage_Y: CGFloat = 15
        let headImage_W: CGFloat = 100
        let headImage_H: CGFloat = 100
        headImageViewRect = CGRect(x: headImage_X, y: headImage_Y, width: headImage_W, height: headImage_H)

        // usernameLabel 的坐标
//        let username_X: CGFloat = headImageViewRect.maxX + margin
//        let username_Y: CGFloat = headImageViewRect.minY + 5
//        let username_W: CGFloat = Configs.Dimensions.screenWidth - username_X - margin
//        guard let userName = model.username else { return  }
//        let username_H = userName.king_getHeightWithString(string: userName, width: username_W)
//        usernameLabelRect = CGRect(x: username_X, y: username_Y, width: username_W, height: username_H)

        
        // titleLabel 的坐标
//        let title_X: CGFloat = usernameLabelRect.minX
//        let title_Y: CGFloat = usernameLabelRect.maxY + 10
//        let title_W: CGFloat = Configs.Dimensions.screenWidth - username_X - margin
//        guard let titleM = model.title else { return  }
//        let title_H = titleM.king_getHeightWithString(string: titleM, width: title_W)
//        titleLabelRect = CGRect(x: title_X, y: title_Y, width: title_W, height: title_H)

        // timeLabel 的坐标
//        let time_X: CGFloat = titleLabelRect.minX
//        let time_Y: CGFloat = titleLabelRect.maxY + 10
//        let time_W: CGFloat = Configs.Dimensions.screenWidth - username_X - margin
//        guard let timeM = model.title else { return  }
//        let time_H = timeM.king_getHeightWithString(string: timeM, width: time_W)
//        timeLabelRect = CGRect(x: time_X, y: time_Y, width: time_W, height: time_H)

        // contentLabel 的坐标
        let contentLabel_X: CGFloat = headImageViewRect.minX
        let contentLabel_Y: CGFloat = headImageViewRect.maxY + 10
        let contentLabel_W: CGFloat = Configs.Dimensions.screenWidth - contentLabel_X*2
        guard let contentM = model.content else { return  }
        let contentLabel_H = contentM.king_getHeightWithString(string: contentM, width: contentLabel_W)
        contentLabelRect = CGRect(x: contentLabel_X, y: contentLabel_Y, width: contentLabel_W, height: contentLabel_H)

        
        
        
        // collection的坐标
        let collection_X: CGFloat = headImageViewRect.minX
        let collection_Y: CGFloat = contentLabelRect.maxY + 10
        let collection_W: CGFloat = Configs.Dimensions.screenWidth - headImageViewRect.minX*2
        let collection_H: CGFloat = collection_W
        
        
        if model.images?.count == 1 {
            collectionVRect = CGRect(x: collection_X, y: collection_Y, width: collection_W, height: collection_H)
        }else if model.images?.count == 2{
            collectionVRect = CGRect(x: collection_X, y: collection_Y, width: collection_W, height: (collection_H - Configs.Dimensions.minimum_Spacing)/2)

        }else if model.images?.count == 3{
            collectionVRect = CGRect(x: collection_X, y: collection_Y, width: collection_W, height: (collection_H - Configs.Dimensions.minimum_Spacing*2)/3)
            
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
            
        }
        else{
            collectionVRect = CGRect.zero
        }


        
        cellHeight = collectionVRect.maxY + margin


        
    }
    
    
    
}
