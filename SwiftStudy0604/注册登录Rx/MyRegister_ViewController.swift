//
//  MyRegister_ViewController.swift
//  SwiftStudy0604
//
//  Created by wanglishuai on 2019/7/27.
//  Copyright © 2019 King. All rights reserved.
//

import UIKit
import RxSwift
//import RxCocoa

let minUsernameLength = 5
let maxUsernameLength = 10
let minPasswordLength = 5
let maxPasswordLength = 16

class MyRegister_ViewController: Base_ViewController {

    @IBOutlet weak var userNmaeTF: UITextField!
    @IBOutlet weak var userNmaeTipLabel: UILabel!
    
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var passwordTipLabel: UILabel!
    
    @IBOutlet weak var repeatTF: UITextField!
    @IBOutlet weak var repeatTipLabel: UILabel!
    
    @IBOutlet weak var registerBtn: UIButton!
    @IBOutlet weak var loginBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "注册"
        

        
        
        
        let viewModel = RegisterViewModel()
        userNmaeTF.rx.text.orEmpty
        .bind(to: viewModel.username).disposed(by: disposeBag)
        passwordTF.rx.text.orEmpty
        .bind(to: viewModel.password).disposed(by: disposeBag)
        repeatTF.rx.text.orEmpty
        .bind(to: viewModel.repeatPassword).disposed(by: disposeBag)
        
        registerBtn.rx.tap.bind(to: viewModel.registerTaps).disposed(by: disposeBag)
        
        
        viewModel.usernameUsable.bind(to: userNmaeTipLabel.rx.validationResult).disposed(by: disposeBag)
        viewModel.usernameUsable.bind(to: passwordTF.rx.inputEnabled).disposed(by: disposeBag)
        
        viewModel.passwordUsable.bind(to: passwordTipLabel.rx.validationResult).disposed(by: disposeBag)
        viewModel.passwordUsable.bind(to: repeatTF.rx.inputEnabled).disposed(by: disposeBag)
        
        viewModel.repeatPasswordUsable.bind(to: repeatTipLabel.rx.validationResult).disposed(by: disposeBag)
        
        viewModel.registerButtonEnabled.subscribe(onNext: { [unowned self] valid in
            self.registerBtn.isEnabled = valid
            self.registerBtn.alpha = valid ? 1.0 : 0.5
        }).disposed(by: disposeBag)
        
        
        viewModel.registerResult.subscribe(onNext: { [unowned self] result in
            switch result {
            case let .OK(message):
                self.showAlert(message: message)
            case let .Faile(message):
                self.showAlert(message: message)
            case .empty:
                self.showAlert(message: "")
            }
        }).disposed(by: disposeBag)
        
        
        loginBtn.rx.tap.subscribe(onNext: { [weak self] in
            let loginvc = LoginViewController()
            self?.navigationController?.pushViewController(loginvc, animated: true)
        }).disposed(by: disposeBag)

        
    }

}

extension MyRegister_ViewController{
    func study() {
        
        
        
    }
    
    
    func showAlert(message: String) {
        let action = UIAlertAction(title: "确定", style: .default, handler: nil)
        let alertViewController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alertViewController.addAction(action)
        present(alertViewController, animated: true, completion: nil)
    }
    

}
