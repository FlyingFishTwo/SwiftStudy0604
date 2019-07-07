//
//  MoyaConfig.swift
//  SwiftStudy0604
//
//  Created by wanglishuai on 2019/7/5.
//  Copyright © 2019 King. All rights reserved.
//

import UIKit
import Moya
import Result

class RequestLoadingPlugin: PluginType {
    
    var HUD:MBProgressHUD = MBProgressHUD.init()
    
    func willSend(_ request: RequestType, target: TargetType) {
        print("开始请求")
        
        if let keyViewController = UIApplication.shared.keyWindow?.rootViewController {
            
            HUD.mode = MBProgressHUDMode.indeterminate
            HUD.bezelView.color = UIColor.lightGray
            HUD.removeFromSuperViewOnHide = true
            HUD.backgroundView.style = .solidColor
            HUD = MBProgressHUD.showAdded(to: keyViewController.view, animated: true)
            
        }
    }
    
    func didReceive(_ result: Result<Response, MoyaError>, target: TargetType) {
        print("结束请求")
        HUD.hide(animated: true, afterDelay: 0)
        
        guard case Result.failure(_) = result else {
            return
        }
        /// 请求失败
        let errorReason: String = (result.error?.errorDescription)!
        print("请求失败: \(errorReason)")
        /// 没网 "The Internet connection appears to be offline."
        /// 连接不到服务器 "Could not connect to the server."
        var tip = "请求失败!"
        if errorReason.contains("The Internet connection appears to be offline") {
            tip = "网络不给力,请检查您的网络"
        }
        if errorReason.contains("Could not connect to the server") {
            tip = "无法连接服务器"
        }
        /// 使用tip文字 进行提示

    }
}



// 项目中如果有Token  在这里惊醒配置，然后添加到请求头
class AuthPlugin: PluginType {
    //令牌字符串
    let token: String = ""
    //准备发起请求
    func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
        var request = request
        //将token添加到请求头中
        request.addValue(token, forHTTPHeaderField: "Authorization")
        return request

        }

}
