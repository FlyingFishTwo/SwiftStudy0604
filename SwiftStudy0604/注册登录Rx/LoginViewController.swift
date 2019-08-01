//
//  LoginViewController.swift
//  SwiftStudy0604
//
//  Created by wanglishuai on 2019/8/1.
//  Copyright © 2019 King. All rights reserved.
//

import UIKit

class LoginViewController: Base_ViewController {
    
    
    @IBOutlet weak var userNameTF: UITextField!
    @IBOutlet weak var userNameTipLabel: UILabel!

    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    
    var viewModel: LoginViewModel!

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "登录"
        
        viewModel = LoginViewModel(input: (username: userNameTF.rx.text.orEmpty.asDriver(),
                                           password: passwordTF.rx.text.orEmpty.asDriver(),
                                           loginTaps: loginBtn.rx.tap.asDriver()),
                                   service: ValidationService.instance)
        
        viewModel.usernameUsable.drive(userNameTipLabel.rx.validationResult).disposed(by: disposeBag)
        
        viewModel.loginButtonEnabled.drive(onNext: { [weak self] valid in
            self?.loginBtn.isEnabled = valid
            self?.loginBtn.alpha = valid ? 1 : 0.5
        }).disposed(by: disposeBag)
        
        
        viewModel.loginResult
            .drive(onNext: { [weak self] result in
            switch result {
            case let .OK(message):
//                self?.showAlert(message: message)
                print(message)
                let contVC = ContainerViewController()
                self?.navigationController?.pushViewController(contVC, animated: true)
            case .empty:
                self?.showAlert(message: "")
            case let .Faile(message):
                self?.showAlert(message: message)
            }

        }).disposed(by: disposeBag)

    }


    
}


extension LoginViewController {
    
    func showAlert(message: String) {
        let action = UIAlertAction(title: "确定", style: .default, handler: nil)
        let alertViewController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alertViewController.addAction(action)
        present(alertViewController, animated: true, completion: nil)
    }

}
