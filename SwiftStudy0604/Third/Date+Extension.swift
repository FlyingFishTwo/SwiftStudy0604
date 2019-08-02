//
//  Date+Extension.swift
//  SwiftStudy0604
//
//  Created by wanglishuai on 2019/8/2.
//  Copyright © 2019 King. All rights reserved.
//

import Foundation

struct Date {
    
    //将UTC日期字符串转为本地时间字符串
    //输入的UTC日期格式  yyyy-MM-dd'T'HH:mm:ss.SSSZ
    static func getLocalDateFormateUTCDate(_ utcDate: String?) -> String? {
        let dateFormatter = DateFormatter()
        //输入格式  2018-11-06T08:20:43.656Z  "yyyy-MM-dd'T'HH:mm:ss.SSSXXX"
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SZ"
        let localTimeZone = NSTimeZone.local as NSTimeZone
        dateFormatter.timeZone = localTimeZone as TimeZone
        
        let dateFormatted = dateFormatter.date(from: utcDate ?? "")
        //输出格式
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        var dateString: String? = nil
        if let dateFormatted = dateFormatted {
            dateString = dateFormatter.string(from: dateFormatted)
        }
        return dateString
    }

    
}
