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
    var isOpen:Bool = false

    var images: Array<String>?
    
    init(jsonData: JSON) {
        
        title = jsonData["title"].stringValue
        content = jsonData["content"].stringValue
        username = jsonData["username"].stringValue
        time = jsonData["time"].stringValue
        imageURL = jsonData["imageURL"].stringValue
//        isOpen = jsonData["isOpen"].boolValue

        images = jsonData["images"].arrayObject as? Array<String>
        
    }
    
}



/*结构体动态绑定属性*******/
struct NSObjcCategoriesKeys {
    static var targetVaulekey : String = "targetVaulekey"
}

// static var targetVaulekey : String = "targetVaulekey"
extension NSObject {
    var targetVaule: String? {
        set(newValue) {
            objc_setAssociatedObject(self, &NSObjcCategoriesKeys.targetVaulekey, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
            // objc_setAssociatedObject(self, &targetVaulekey, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
        get {
            return  objc_getAssociatedObject(self, &NSObjcCategoriesKeys.targetVaulekey) as? String
            //  return  objc_getAssociatedObject(self, &targetVaulekey) as? String
        }
    }
}


