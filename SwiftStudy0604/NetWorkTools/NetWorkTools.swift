//
//  NetWorkProtocol.swift
//  SwiftStudy0604
//
//  Created by wanglishuai on 2019/6/26.
//  Copyright © 2019 King. All rights reserved.
//

import Foundation
import SwiftyJSON
import RxSwift
import RxCocoa

let API_DES_KEY = "IaRt5201"

protocol NetWorkToolsProtocol {
    
    //测试用
    static func testRequest()

    //获取我的关注的数据
    static func loadMyConcern(device_id:String,completeHandle:@escaping (_ con_Array:[MyConcern]) -> ())
    
    static func KL_GetDataWithRequest(type: MyAPI.LXFNetworkCategory, size:Int, index:Int,completeHandle:@escaping (_ welfareArray:[WelfareModel])->())

    static func Coin_HomeData()
    
    
}

struct NetWorkTools : NetWorkToolsProtocol {

}




extension NetWorkToolsProtocol {
    
    //MultiTarget   多个target的时候的请求
//    provider.request(MultiTarget(DouBan.channels)) { result in
//    }
    
    //测试数据  (没有调用)
    static func testRequest() {
        NetworkProvider.request(.demo2(name: "userName")) { (result) in
            switch result {
            case let .success(moyaResponse):
                 let data = try? moyaResponse.mapJSON()
                 CWLog(data)
            case let .failure(error):
                print(error.localizedDescription)
            }
            print("result = \(result.description)")
        }
    }
    
    //获取我的关注的数据
    static func loadMyConcern(device_id:String,completeHandle:@escaping (_ con_Array:[MyConcern]) -> ()) {
        NetworkProvider.request(.mkmjRequest(device_id: device_id)) { (result) in
            switch result {
            case let .success(moyaResponse):
                let data = try? moyaResponse.mapJSON()  // 获取到的数据
                let json = JSON(data as Any)
                guard json ["message"] == "success" else {
                    return
                }
                CWLog(json)
                if let datas = json["data"].arrayObject {
                    var concerns = [MyConcern]()
                    for data in datas {
                        let myConcern = MyConcern.deserialize(from: data as? NSDictionary)
                        concerns.append(myConcern!)
                    }
                    completeHandle(concerns)
                }
            case let .failure(error):
                print(error.localizedDescription)
            }            
        }
    }
    
    //获取福利数据
    static func KL_GetDataWithRequest(type: MyAPI.LXFNetworkCategory, size:Int, index:Int,completeHandle:@escaping (_ welfareArray:[WelfareModel])->()) {

        
        NetworkProvider.request(.data(type: type, size: size, index: index)) { (result) in
            RequestLoadingPlugin().HUD.hide(animated: true, afterDelay: 0)

            switch result {
            case let .success(moyaResponse):
                let data = try? moyaResponse.mapJSON()  // 获取到的数据
                CWLog(data)
                let json = JSON(data as Any)
                guard json ["error"] != 0 else {
                    return
                }

                //使用 SwiftyJSON 解析
//                let json = JSON.init(data as Any)
//                CWLog(json)

                if let datas = json["results"].arrayObject {
                    CWLog(datas)
                    var welfareArray = [WelfareModel]()
                    for data in datas {
                        let welfareData = WelfareModel.deserialize(from: data as? NSDictionary)
                        welfareArray.append(welfareData!)
                    }
                    //将数据源回调出去
                    completeHandle(welfareArray)
                }
            case let .failure(error):
                RequestLoadingPlugin().HUD.hide(animated: true, afterDelay: 0)
                print(error.localizedDescription)
            }

        }
        
    }
    
    
    static func Coin_HomeData(){
        
        
        
    }
    
    
}
