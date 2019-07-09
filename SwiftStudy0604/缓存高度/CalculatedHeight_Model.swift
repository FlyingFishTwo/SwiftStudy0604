//
//  CalculatedHeight_Model.swift
//  SwiftStudy0604
//
//  Created by wanglishuai on 2019/7/9.
//  Copyright © 2019 King. All rights reserved.
//

import Foundation


struct CalculatedHeight_Model {
    
    var model: CacheModel?

    var titleLabelRect: CGRect!
    var contentLabelRect: CGRect!
    var headImageViewRect: CGRect!
    var usernameLabelRect: CGRect!
    var timeLabelRect: CGRect!

    var cellHeight: CGFloat?

    init(model:CacheModel) {
        self.model = model
        
        let margin: CGFloat = 15
        guard model.imageURL != nil else {
            headImageViewRect = CGRect.zero
            return
        }
        // headerImageView的坐标
        let headImage_X: CGFloat = 15
        let headImage_Y: CGFloat = 15
        let headImage_W: CGFloat = 100
        let headImage_H: CGFloat = 100
        headImageViewRect = CGRect(x: headImage_X, y: headImage_Y, width: headImage_W, height: headImage_H)

        //usernameLabel 的坐标
        let username_X: CGFloat = headImageViewRect.maxX + 10
        let username_Y: CGFloat = headImageViewRect.minY + 5
        let username_W = Configs.Dimensions.screenWidth - headImageViewRect.maxX - 30
        guard let modelUserName = model.username else { return  }
        let username_H = modelUserName.stringHeightWidth(fontSize: 13.0, width: username_W)
        usernameLabelRect = CGRect(x: username_X, y: username_Y, width: username_W, height: username_H+10)

        //titleLabel 的坐标
        let titleLabel_X: CGFloat = username_X
        let titleLabel_Y: CGFloat = usernameLabelRect.maxY + 10
        let titleLabel_W = usernameLabelRect.width
        guard let titleLabelName = model.title else { return  }
        let titleLabel_H = titleLabelName.stringHeightWidth(fontSize: 13.0, width: titleLabel_W)
        titleLabelRect = CGRect(x: titleLabel_X, y: titleLabel_Y, width: titleLabel_W, height: titleLabel_H)

        
        //timeLabel 的坐标
        let timeLabel_X: CGFloat = titleLabel_X
        let timeLabel_Y: CGFloat = titleLabelRect.maxY + 10
        let timeLabel_W = titleLabelRect.width
        guard let timeLabellName = model.time else { return  }
        let timeLabel_H = timeLabellName.stringHeightWidth(fontSize: 13.0, width: timeLabel_W)
        timeLabelRect = CGRect(x: timeLabel_X, y: timeLabel_Y, width: timeLabel_W, height: timeLabel_H)

        
        //contentLabelRect 的坐标
        let contentLabel_X: CGFloat = headImageViewRect.minX
        let contentLabel_Y: CGFloat = headImageViewRect.maxY + 10
        let contentLabel_W = Configs.Dimensions.screenWidth - 30
        guard let contentLabellM = model.content else { return  }
        let contentLabel_H = contentLabellM.stringHeightWidth(fontSize: 13.0, width: contentLabel_W)
        contentLabelRect = CGRect(x: contentLabel_X, y: contentLabel_Y, width: contentLabel_W, height: contentLabel_H)


        if model.content?.isEmpty == true {
            cellHeight = headImageViewRect.maxY + margin
        }else {
            cellHeight = contentLabelRect.maxY + margin - 5
        }
        
    }
    
    
    
    

    
}



/*
 "title": "Team member - sunnyxx",
 "content": "Working at Baidu, Zhidao iOS team, weibo: @我就叫Sunny怎么了",
 "username": "sunnyxx",
 "time": "2015.04.11",
 "imageURL": "https://ww1.sinaimg.cn/large/0065oQSqly1g2hekfwnd7j30sg0x4djy.jpg"
 */
