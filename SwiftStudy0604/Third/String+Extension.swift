//
//  String+Extension.swift
//  SwiftStudy0604
//
//  Created by wanglishuai on 2019/6/30.
//  Copyright © 2019 King. All rights reserved.
//

import Foundation


extension String {
    // base64编码
    func toBase64() -> String? {
        if let data = self.data(using: .utf8) {
            return data.base64EncodedString()
        }
        return nil
    }
    
    // base64解码
    func fromBase64() -> String? {
        if let data = Data(base64Encoded: self) {
            return String(data: data, encoding: .utf8)
        }
        return nil
    }
}

//转为3DES加密串之后传给后台或者接口后台返回参数的时候是base64位的，base64进行http请求的时候不能识别"/"、"+"、"="等特殊字符，需要转换一下
extension String{
    //向后台传值的时候
    func urlBase64EncodedString() -> String {
        let first = self.replacingOccurrences(of: "/", with: "_")
        let second = first.replacingOccurrences(of: "+", with: "-")
        let third = second.replacingOccurrences(of: "=", with: "")
        return third
    }
    //接收后台返回的值的时候
    func urlBase64DecodedString() -> String {
        let first = NSMutableString(string: self)
        let mod4:Int = first.length % 4
        print(first.length)
        if(mod4>0){
            var str = "===="
            let start1 = str.index(str.startIndex, offsetBy: 0)
//            str = str.substring(from: start1)
            str = String(str[..<start1]) // = str.substring(to: index) In Swift 3
            


            let end1 = str.index(str.startIndex, offsetBy: 4-mod4)
            let sub5 = str.substring(to: end1)            
            
            first.append(sub5)
        }
        let second = first.replacingOccurrences(of: "_", with: "/")
        let third = second.replacingOccurrences(of: "-", with: "+")
        return third
    }
}



