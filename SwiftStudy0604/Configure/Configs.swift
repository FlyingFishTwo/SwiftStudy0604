//
//  Configs.swift
//  SwiftStudy0604
//
//  Created by wanglishuai on 2019/6/26.
//  Copyright © 2019 King. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
// MARK: 配置项目全局刷新加载状态  Rx
enum KingRefreshStatus {
    case none
    case beingHeaderRefresh
    case endHeaderRefresh
    case beingFooterRefresh
    case endFooterRefresh
    case noMoreData
}


struct Configs {
    
    struct Dimensions {
        //屏宽
        static let screenWidth: CGFloat = UIScreen.main.bounds.size.width
        //屏高
        static let screenHeight: CGFloat = UIScreen.main.bounds.size.height
        //状态栏高度
        static let statusBarHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height
        //导航栏高度
        static let naviBarHeight: CGFloat = 44
        //导航栏加状态栏高度
        static let topHeight: CGFloat = statusBarHeight + naviBarHeight
        // 常规 字体
        static let wordRegular :String  = "PingFangSC-Regular"
        static let word_Medium :String  = "PingFangSC-Medium"
        static let word_Semibold :String  = "PingFangSC-Semibold"
        static let word_Bold :String  = "PingFangSC-Bold"

        //CollectionView Item的最小间距
        static let minimum_Spacing: CGFloat = 3
        
    }
    
    /// Rx 全局调用刷新的方法
    static func rsfresh_DataWith_TableView(tableView:UITableView,status:KingRefreshStatus) {
        switch status {
        case .beingHeaderRefresh:
            tableView.mj_header.beginRefreshing()
        case .endHeaderRefresh:
            tableView.mj_header.endRefreshing()
        case .beingFooterRefresh:
            tableView.mj_footer.beginRefreshing()
        case .endFooterRefresh:
            tableView.mj_footer.endRefreshing()
        case .noMoreData:
            tableView.mj_footer.endRefreshingWithNoMoreData()
        default:
            break
        }
    }
    /// 刷新或者加载
    static func refresh_WithPublicSubject(tableView:UITableView,subject:PublishSubject<Bool>,isRefresh:Bool){
        ///下拉刷新
        tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: {
            subject.onNext(isRefresh)
        })
        ///上拉加载
        tableView.mj_footer = MJRefreshAutoNormalFooter(refreshingBlock: {
            subject.onNext(!isRefresh)
        })
    }
    
}

