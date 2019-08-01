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
    var items : [KingModel]
    
}

extension KingSection :SectionModelType {
    typealias Item = KingModel
    init(original: KingSection, items: [KingSection.Item]) {
        self = original
        self.items = items
    }
}

