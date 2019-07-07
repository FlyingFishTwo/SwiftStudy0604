//
//  Internet.swift
//  SwiftStudy0604
//
//  Created by wanglishuai on 2019/6/26.
//  Copyright © 2019 King. All rights reserved.
//

import Foundation
import HandyJSON
import ObjectMapper
import SwiftyJSON

struct Internet:HandyJSON,Mappable {
    init() {
        
    }
    
    init?(map: Map) {
    }
    
    var origin: String = ""
    var url: String = ""
    var Connection: String = ""
    var Host: String = ""
    var Agent: String = ""
    
    
    mutating func mapping(map: Map) {
        origin      <- map["origin"]
        url         <- map["url"]
        Connection  <- map["headers.Connection"]
        Host        <- map["headers.Host"]
        Agent       <- map["headers.User-Agent"]
    }

}


struct MyConcern :HandyJSON {
    
    //结构体里的变量可以设为可选值
    var name: String?
    var url: String?
    var total_count: String?
    var description: String?
    var time: String?
    var type: String?
    var icon: String?
    var userid: String?
    var is_verify: Bool?
    var media_id: String?
    var tips: Bool?
    var id: Int?
    var user_auth_info: String?
    
    var userAuthInfo : User_Auth_Info? {
        return User_Auth_Info.deserialize(from: user_auth_info)
    }
    
    
}
struct User_Auth_Info :HandyJSON {
    
    var auth_type:Int?
    var auth_info:String?
    
    
}

struct WelfareModel:HandyJSON {
    init() {
        
    }
    
    
    var desc: String?
    var createdAt: String?
    var used:Int?
    var url: String?
    var _id: String?
    var who: String?
    var source: String?
    var publishedAt: String?
    var type: String?
    
    init(jsonData: JSON) {
        
        desc = jsonData["desc"].stringValue
        createdAt = jsonData["createdAt"].stringValue
        used = jsonData["used"].intValue
        url = jsonData["url"].stringValue
        _id = jsonData["_id"].stringValue
        who = jsonData["who"].stringValue
        source = jsonData["source"].stringValue
        publishedAt = jsonData["publishedAt"].stringValue
        type = jsonData["type"].stringValue

    }

}

//desc = "10-13",
//createdAt = "2017-10-12T07:32:28.644Z",
//used = 1,
//url = "http://7xi8d6.com1.z0.glb.clouddn.com/20171012073213_p4H630_joycechu_syc_12_10_2017_7_32_7_433.jpeg",
//_id = "59deaa0c421aa90fe7253583",
//who = "daimajia",
//source = "chrome",
//publishedAt = "2017-10-17T13:10:43.731Z",
//type = "福利",
