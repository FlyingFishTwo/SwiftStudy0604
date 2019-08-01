//
//  RegisterViewModel.swift
//  SwiftStudy0604
//
//  Created by wanglishuai on 2019/7/31.
//  Copyright © 2019 King. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa


struct RegisterViewModel {
    
    // input
    let username = BehaviorRelay<String>(value: "")
    let password = BehaviorRelay<String>(value: "")
    let repeatPassword = BehaviorRelay<String>(value: "")
    let registerTaps = BehaviorRelay<Void>(value: ())

    // output
    let usernameUsable : Observable<ResultVaile>
    let passwordUsable : Observable<ResultVaile>
    let repeatPasswordUsable : Observable<ResultVaile>
    let registerButtonEnabled : Observable<Bool>
    
    let registerResult: Observable<ResultVaile>

    /// 初始化方法
    init() {
        
        let service = ValidationService.instance
        // MARK: ⚠️  注意这里的返回值 Observable<ResultVaile>
        usernameUsable = username.asObservable().flatMapLatest({ (username) -> Observable<ResultVaile> in
            return service.validateUsername(username: username)
                .observeOn(MainScheduler.instance)
                .catchErrorJustReturn(.Faile(message: "username检测出错"))
            .share(replay: 1)
        })
        // MARK: ⚠️  注意这里的返回值 ResultVaile
        passwordUsable = password.asObservable()
            .map{ password in
            return service.validatePassword(password: password)
        }.share(replay: 1)
        
        // MARK: ⚠️  注意这里的返回值 ResultVaile
        repeatPasswordUsable = Observable.combineLatest(password.asObservable(),repeatPassword.asObservable()) {
            return service.validateRepeatedPassword(password: $0, repeatedPasswordword: $1)
        }.share(replay: 1)

        // MARK: 注册按钮是否可点击
        registerButtonEnabled = Observable.combineLatest(usernameUsable,passwordUsable,repeatPasswordUsable) {
            (username ,password ,repeatPassword) in
            username.isValid && password.isValid && repeatPassword.isValid
        }.distinctUntilChanged()
        .share(replay: 1)
        
        
        
        let usernameAndPassword = Observable.combineLatest(username.asObservable(),password.asObservable()) {
            ($0 ,$1)
        }
        
        // MARK: 注册按钮点击验证
        registerResult = registerTaps.asObservable().withLatestFrom(usernameAndPassword)
            .flatMapLatest { username,password in
            return service.register(username: username, password: password)
                .observeOn(MainScheduler.instance)
                .catchErrorJustReturn(.Faile(message: "注册出错"))
        }.share(replay: 1)

    }
    
    
}
