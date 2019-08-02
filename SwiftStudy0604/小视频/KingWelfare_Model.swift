//
//  KingModel.swift
//  SwiftStudy0604
//
//  Created by wanglishuai on 2019/8/1.
//  Copyright © 2019 King. All rights reserved.
//

import Foundation
import ObjectMapper
import RxDataSources


struct KingWelfare_Model : Mappable {
    
    var _id         = ""
    var createdAt   = ""
    var desc        = ""
    var publishedAt = ""
    var source      = ""
    var type        = ""
    var url         = ""
    var used        = ""
    var who         = ""
    /// 计算型属性  “敌不动我不动”
    var createdAtString:String?{
        return Date.getLocalDateFormateUTCDate(createdAt)
    }
    

    
    init?(map: Map) { }
    
    mutating func mapping(map: Map) {
        
        _id         <- map["_id"]
        createdAt   <- map["createdAt"]
        desc        <- map["desc"]
        publishedAt <- map["publishedAt"]
        source      <- map["source"]
        type        <- map["type"]
        url         <- map["url"]
        used        <- map["used"]
        who         <- map["who"]
    }

    
}


// MARK: SectionModel

struct KingSection {
    var items : [KingWelfare_Model]
    
}

extension KingSection :SectionModelType {
    typealias Item = KingWelfare_Model
    init(original: KingSection, items: [KingSection.Item]) {
        self = original
        self.items = items
    }
}

