//
//  CacheModel.swift
//  SwiftStudy0604
//
//  Created by wanglishuai on 2019/7/8.
//  Copyright © 2019 King. All rights reserved.
//

import Foundation
import HandyJSON
import SwiftyJSON


struct CacheModel :HandyJSON {
    
    var title:String?
    var content:String?
    var username:String?
    var time:String?
    var imageURL:String?
    
    init() {
        
    }
    
    init(jsonData: JSON) {
        title = jsonData["title"].stringValue
        content = jsonData["content"].stringValue
        username = jsonData["username"].stringValue
        time = jsonData["time"].stringValue
        imageURL = jsonData["imageURL"].stringValue
        
        
        
    }
    
}



/*
 "title": "Team member - sunnyxx",
 "content": "Working at Baidu, Zhidao iOS team, weibo: @我就叫Sunny怎么了",
 "username": "sunnyxx",
 "time": "2015.04.11",
 "imageURL": "https://ww1.sinaimg.cn/large/0065oQSqly1g2hekfwnd7j30sg0x4djy.jpg"
 */
