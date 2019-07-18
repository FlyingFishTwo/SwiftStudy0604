//
//  Todo.swift
//  SwiftStudy0604
//
//  Created by wanglishuai on 2019/7/16.
//  Copyright © 2019 King. All rights reserved.
//

import Foundation
import RealmSwift

// Define your models like regular Swift classes
class Todo: Object {

    @objc dynamic var name = ""
    @objc dynamic var age = 0

}
