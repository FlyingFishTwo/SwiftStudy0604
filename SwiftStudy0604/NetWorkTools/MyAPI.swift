//
//  MyAPI.swift
//  SwiftStudy0604
//
//  Created by wanglishuai on 2019/6/24.
//  Copyright © 2019 King. All rights reserved.
//

import Foundation
import Moya
import Alamofire
import Result
import RxSwift
import RxCocoa


let base_url = "https://is.snssdk.com"



// MARK: - 设置请求超时时间
let requestClosure = { (endpoint: Endpoint, done: @escaping MoyaProvider<MyAPI>.RequestResultClosure) in
    do {
        var request: URLRequest = try endpoint.urlRequest()
        request.timeoutInterval = 10    //设置请求超时时间
        done(.success(request))
    } catch  {
        print("错误了 \(error)")
    }
}

//状态栏的指示器
let networkPlugin = NetworkActivityPlugin { (type,MyApi) in
    switch type {
    case .began:
        /// 状态栏转圈
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    case .ended:
        /// 状态栏停止转圈
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
}



//初始化 MoyaProvider 包含请求超时，指示器插件，令牌
let NetworkProvider = MoyaProvider<MyAPI>(requestClosure: requestClosure , plugins: [RequestLoadingPlugin(),networkPlugin,AuthPlugin()])

//let NetworkProvider = MoyaProvider<MyAPI>()  // 最简单的初始化，如果不需要指示器可以用这种方法
//let provider = MoyaProvider<MultiTarget>() 如果有多少个 TargetType 我们就  MultiTarget



#if DEBUG
let Using_URL = "" //测试地址
#else
let Using_URL = "" //正式地址
#endif

enum MyAPI {
    
    enum LXFNetworkCategory: String {
        case all     = "all"
        case android = "Android"
        case ios     = "iOS"
        case welfare = "福利"
    }
    case data(type: LXFNetworkCategory, size:Int, index:Int)

    
    case demo2(name: String)
    case mkmjRequest(device_id:String)
    
}


//通过扩展遵循协议 : 当一个类型已经符合了某个协议中的所有要求，却还没有声明遵循该协议时，可以通过空扩展体的扩展来遵循该协议：
//从现在起，targetTypeDemo的实例可以作为 TargetType 类型使用：
extension MyAPI : TargetType {
    // 请求服务器的根路径
//    var baseURL: URL { return URL.init(string: base_url)! }
    
    // 如果有的接口BASEURL不一样，可以使用以下方式
    var baseURL: URL {
        switch self {
        case .demo2:
            return (URL.init(string: "https://httpbin.org"))!
        case .data(_,_,_):
            return URL(string: "http://gank.io/api/data/")!
        default:
            return URL.init(string: base_url)!
        }
    }
    // 每个API对应的具体路径
    var path: String {
        switch self {
        case .demo2(name: _):
            return "/post"
        case .mkmjRequest(device_id: _):
            return "/concern/v2/follow/my_follow/"
            
        case .data(let type, let size, let index):
            return "\(type.rawValue)/\(size)/\(index)"
        }
    }
    // 各个接口的请求方式，get或post
    var method: Moya.Method {
        switch self {
        case .demo2:
            return .post
        case .mkmjRequest:
            return .post
        case .data(_,_,_):
            return .get
        }
    }
    // 请求是否携带参数，如果需要参数，就做如demo2和demo3的设置
    var task: Task {
        switch self {
        case let .demo2(name): // 带有参数,注意前面的let
            return .requestParameters(parameters: ["name" : name], encoding: URLEncoding.default)
            
        case let .mkmjRequest(device_id):
            return .requestParameters(parameters: ["device_id":device_id], encoding: URLEncoding.default)
        case .data(type: _, size: _, index: _):
            return .requestPlain
        }
        
        //关于上传文件的网络操作，可以在 task 参数中返回 .uploadCompositeMultipart 这个枚举值。
        
    }
    // 单元测试使用
    var sampleData: Data {
        return "".data(using: String.Encoding.utf8)!
    }
    // 请求头
    var headers: [String : String]? {
        return ["Content-Type" : "application/json; charset=utf-8"]
    }
    
}


//let King_NetTool = MoyaProvider<MyAPI>()

