//
//  ProtocolRegister.swift
//  SwiftStudy0604
//
//  Created by wanglishuai on 2019/7/31.
//  Copyright © 2019 King. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

// 声明一个枚举用来记录  结果信息
enum ResultVaile {
    case OK(message:String)
    case Faile(message:String)
    case empty
}

extension ResultVaile {
    var isValid: Bool {

        switch self {
        case .OK:
            return true
        default:
            return false
        }
    }
}

extension ResultVaile {
    var textColor: UIColor {
        switch self {
        case .OK:
            return UIColor(red: 138.0 / 255.0, green: 221.0 / 255.0, blue: 109.0 / 255.0, alpha: 1.0)
        case.Faile:
            return UIColor.red
        case .empty:
            return UIColor.black
        }
    }
}
extension ResultVaile {
    var description: String {
        switch self {
        case let .OK(message):
            return message
        case .empty:
            return ""
        case let .Faile(message):
            return message
        }
    }
}

// UILabel的拓展
extension Reactive where Base: UILabel {
    var validationResult: Binder<ResultVaile> {
        return Binder(self.base) { label , result111 in
            //收到发出的索引数后显示到label上
            label.textColor = result111.textColor
            label.text = result111.description
        }
    }
}
// UITextField的拓展
extension Reactive where Base: UITextField {
    var inputEnabled: Binder<ResultVaile> {
        return Binder(self.base) { textField , resultTF in
            textField.isEnabled = resultTF.isValid
        }
    }
}
// UIBarButtonItem的拓展
extension Reactive where Base: UIBarButtonItem {
    var tapEnabled: Binder<ResultVaile> {
        return Binder(self.base) { buttonItem, resultItem in
            buttonItem.isEnabled = resultItem.isValid
        }
    }
}
// UILabel的拓展 字体大小
extension UILabel {
    public var fontSize: Binder<CGFloat> {
        return Binder(self) { label, fontSize in
            label.font = UIFont.systemFont(ofSize: fontSize)
        }
    }
}

// UILabel的拓展 字体大小 Reactive的扩展可以使用    rx.fontSize
extension Reactive where Base: UILabel {
    public var fontSize: Binder<CGFloat> {
        return Binder(self.base) { label, fontSize in
            label.font = UIFont.systemFont(ofSize: fontSize)
        }
    }
}
