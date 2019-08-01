//
//  LoginViewModel.swift
//  SwiftStudy0604
//
//  Created by wanglishuai on 2019/8/1.
//  Copyright © 2019 King. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift


struct LoginViewModel {
    
    /// output:
    let usernameUsable : Driver<ResultVaile>
    let loginButtonEnabled : Driver<Bool>
    let loginResult : Driver<ResultVaile>
    
    init(input:(username:Driver<String> ,password:Driver<String>,loginTaps:Driver<Void>),service:ValidationService) {
        
        usernameUsable = input.username
            .flatMapLatest({ username  in
                return service.loginUsernameValid(username: username)
                .asDriver(onErrorJustReturn: .Faile(message: "连接server失败"))
            })
        
        let usernameAndPassword = Driver.combineLatest(input.username,input.password){
            ($0,$1)
        }
        
        loginResult = input.loginTaps.withLatestFrom(usernameAndPassword)
            .flatMapLatest({ (username,password)  in
                return service.login(username: username, password: password)
                .asDriver(onErrorJustReturn: .Faile(message: "连接server失败"))
            })
        
        loginButtonEnabled = input.password.map({
            $0.count > 0
        }).asDriver()
        
    }
    
    
}
