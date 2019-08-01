//
//  Service.swift
//  SwiftStudy0604
//
//  Created by wanglishuai on 2019/7/31.
//  Copyright © 2019 King. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift


struct ValidationService {
    // 单例类模式
    static let instance = ValidationService()
    
    init() { }
    
    let minCharactersCount = 6

    //验证用户名
    func validateUsername(username:String) -> Observable<ResultVaile> {
        if username.count == 0 {
            return .just(.empty)
        }
        if username.count < minCharactersCount {
            return .just(.Faile(message: "号码长度至少6个字符"))
        }
        if usernameValid(username) {
            return .just(.Faile(message: "账户已经存在"))
        }
        return .just(.OK(message: "用户名可用"))
    }
    
    //验证密码
    func validatePassword(password:String) -> ResultVaile {
        if password.count == 0 {
            return .empty
        }
        if password.count < minCharactersCount {
            return .Faile(message: "密码长度至少6个字符")
        }
        return .OK(message: "密码可用")
    }
    
    // MARK: 验证密码和重复密码
    func validateRepeatedPassword(password:String ,repeatedPasswordword:String) -> ResultVaile {
        if repeatedPasswordword.count == 0 {
            return .empty
        }
        if repeatedPasswordword == password {
            return .OK(message: "密码可用")
        }
        return .Faile(message: "两次密码不一致")
    }

    // MARK: 点击注册时的验证
    func register(username:String,password:String) -> Observable<ResultVaile> {
        let userDic = [username:password]
        let filePath = NSHomeDirectory() + "/Documents/users.plist"
        if (userDic as NSDictionary).write(toFile: filePath, atomically: true) {
            return .just(.OK(message: "注册成功"))
        }
        return .just(.Faile(message: "注册失败"))
    }

}

// MARK: 从沙盒获取用户名
extension ValidationService {
    func usernameValid(_ username: String) -> Bool {
        let filePath = NSHomeDirectory() + "/Documents/users.plist"
        let userDic = NSDictionary(contentsOfFile: filePath)
        let usernameArray = userDic?.allKeys
        guard usernameArray != nil else {
            return false
        }
        
        if (usernameArray! as NSArray).contains(username ) {
            return true
        } else {
            return false
        }
    }
}


// MARK: 登录时用户名验证
extension ValidationService {
    func loginUsernameValid(username:String) -> Observable<ResultVaile> {
        if username.count == 0 {
            return .just(.empty)
        }
        if usernameValid(username) {
            return .just(.OK(message: "用户名可用"))
        }
        return .just(.Faile(message: "用户名不存在"))
    }
    
    /// 点击登录按钮时的验证
    func login(username:String , password:String) -> Observable<ResultVaile> {
        let filePath = NSHomeDirectory() + "/Documents/users.plist"
        let userDic = NSDictionary(contentsOfFile: filePath)
        if let userPass = userDic?.object(forKey: username) as? String {
            if  userPass == password {
                return .just(.OK(message: "登录成功"))
            }
        }
        return .just(.Faile(message: "密码错误"))
    }
    
}



struct SearchService {
    
    static let shareInstance = SearchService()
    init() {}
    
    ///获取所有的英雄
    func getHeros() -> Observable<[Hero]> {
        let herosString = Bundle.main.path(forResource: "heros", ofType: "plist")
        let herosArray = NSArray(contentsOfFile: herosString!) as! Array<[String: String]>
        var heros = [Hero]()
        for heroDic in herosArray {
            let hero = Hero(name: heroDic["name"]!, desc: heroDic["intro"]!, icon: heroDic["icon"]!)
            heros.append(hero)
        }

        return Observable.just(heros).observeOn(MainScheduler.instance)
    }
    
    ///查询英雄
    func getHeros(withName name:String) -> Observable<[Hero]> {
        if name == "" {
            return getHeros()
        }
        let herosString = Bundle.main.path(forResource: "heros", ofType: "plist")
        let herosArray = NSArray(contentsOfFile: herosString!) as! Array<[String: String]>
        var heros = [Hero]()
        for heroDic in herosArray {
            if heroDic["name"]!.contains(name) {
                let hero = Hero(name: heroDic["name"]!, desc: heroDic["intro"]!, icon: heroDic["icon"]!)
                heros.append(hero)
            }
        }
        return Observable.just(heros).observeOn(MainScheduler.instance)
    }
    
}
