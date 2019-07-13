//
//  KingModel.swift
//  SwiftStudy0604
//
//  Created by wanglishuai on 2019/7/12.
//  Copyright © 2019 King. All rights reserved.
//

import Foundation
import HandyJSON
import SwiftyJSON

struct KingModel:HandyJSON {
    init() {}
    
//
//    "title": "第一个",
//    "content": "在Xcode中使用UILabel控件显示单行文本非常简单便捷，可一旦遇到需要使用多行文本时则显得稍显无力。如果你不想使用UITextView，其实UILabel也可实现，而且只需多加两行代码哦。",
//    "username": "利哥",
//    "time": "2012.03.22",
//    "imageURL": "https://ww1.sinaimg.cn/large/0065oQSqly1ftdtot8zd3j30ju0pt137.jpg",
//    "images" : [
//    ]

    
    var title: String?
    var content: String?
    var username: String?
    var time: String?
    var imageURL: String?
    var isUnflod: Bool? = false

    var images: Array<String>?
    
    init(jsonData: JSON) {
        
        title = jsonData["title"].stringValue
        content = jsonData["content"].stringValue
        username = jsonData["username"].stringValue
        time = jsonData["time"].stringValue
        imageURL = jsonData["imageURL"].stringValue
        isUnflod = jsonData["isUnflod"].boolValue

        images = jsonData["images"].arrayObject as? Array<String>
        
    }
    
}
