//
//  King_Welfare_Model.swift
//  SwiftStudy0604
//
//  Created by wanglishuai on 2019/8/1.
//  Copyright © 2019 King. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

let disposeBag = DisposeBag()


class King_Welfare_View_Model {
    ///存放解析完成的模型数组
    let models = BehaviorRelay<[KingWelfare_Model]>(value: [])
    
    ///记录当前的索引值
    var index:Int = 1
    
}


extension King_Welfare_View_Model : KingViewModelType {

    typealias Input = king_Intput
    typealias Output = King_Output
    
    struct king_Intput {
        ///网络请求类型
        let category : MyAPI.LXFNetworkCategory
        init(category:MyAPI.LXFNetworkCategory) {
            self.category = category
        }
    }
    
    struct King_Output {
        ///tableView 的sections数据类型
        let sections : Driver<[KingSection]>
        ///外界通过该属性告诉viewModel加载数据（传入的值是为了标志是否重新加载）
        let requestCommond = PublishSubject<Bool>()
        /// 告诉外界的tableView当前的刷新状态
        let refreshStatus = BehaviorRelay<KingRefreshStatus>(value: .none)
        
        init(sections:Driver<[KingSection]>) {
            self.sections = sections
        }
    }
    
    func transform(input: King_Welfare_View_Model.king_Intput) -> King_Welfare_View_Model.King_Output {
        
        let sections = models.asObservable().map { models -> [KingSection] in
            ///当models的值被改变时调用
            return [KingSection(items: models)]
        }.asDriver(onErrorJustReturn: [])
        
        ///定义输出
        let output = King_Output(sections: sections)
        /// 输出时订阅相关事件  刷新加载
        output.requestCommond.subscribe(onNext: { [unowned self] isReloadData in
            self.index = isReloadData ? 1 : self.index + 1
            ///请求数据
            NetworkProvider.rx.request(.data(type: input.category, size: 10, index: self.index))
                .asObservable()
                .mapArray(KingWelfare_Model.self)
                .subscribe({ [weak self] (event) in
                    switch event {
                    case let .next(modelArr):
                        self?.models.accept(isReloadData ? modelArr : (self?.models.value ?? []) + modelArr)
                        KingProgressHUD.showSuccess("加载成功")
                    case let .error(error):
                        KingProgressHUD.showError(error.localizedDescription)
                    case .completed:
                        output.refreshStatus.accept(isReloadData ? .endHeaderRefresh : .endFooterRefresh)
                    }
                }).disposed(by: disposeBag)
        }).disposed(by: disposeBag)
        return output
    }

    
}
