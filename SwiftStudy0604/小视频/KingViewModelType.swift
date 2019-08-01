//
//  KingViewModelType.swift
//  SwiftStudy0604
//
//  Created by wanglishuai on 2019/8/1.
//  Copyright © 2019 King. All rights reserved.
//

import Foundation

///定义输入输出

protocol KingViewModelType {
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
    
}
