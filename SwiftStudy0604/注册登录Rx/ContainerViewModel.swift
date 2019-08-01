//
//  ContainerViewModel.swift
//  SwiftStudy0604
//
//  Created by wanglishuai on 2019/8/1.
//  Copyright © 2019 King. All rights reserved.
//

import Foundation

import RxCocoa
import RxSwift
import HandyJSON
import SwiftyJSON



struct ContainerViewModel {
    // MARK:
    var models : Driver<[Hero]>
    init(withSearchText searchText:Observable<String>,service:SearchService) {
        
        models = searchText.debug()
            .observeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .flatMap({ text in
            return service.getHeros(withName: text)
        }).asDriver(onErrorJustReturn: [])
    }
}


struct Hero {
    var name: String?
    var desc: String?
    var icon: String?
    
    init(name:String ,desc:String ,icon:String) {
        self.name = name
        self.desc = desc
        self.icon = icon
    }

}
