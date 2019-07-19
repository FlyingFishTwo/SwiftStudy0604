//
//  Welfare_ViewController.swift
//  SwiftStudy0604
//
//  Created by wanglishuai on 2019/6/26.
//  Copyright © 2019 King. All rights reserved.
//

import UIKit
import JXSegmentedView

class Welfare_ViewController: UIViewController {
    
    var welfArr = [[WelfareModel]]()
    
    let segmentedView = JXSegmentedView()
    var segmentedDataSource: JXSegmentedBaseDataSource?
    var dataSource : JXSegmentedTitleDataSource! = {
        return JXSegmentedTitleDataSource()
    }()
    lazy var listContainerView: JXSegmentedListContainerView! = {
        return JXSegmentedListContainerView(dataSource: self)
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        //基础配置
        configureWithBase_UI()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        listContainerView.frame = CGRect(x: 0, y: segmentedView.frame.height, width: view.bounds.size.width, height: view.bounds.size.height - 50)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //离开页面的时候，需要恢复屏幕边缘手势，不能影响其他页面
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }

}


// MARK: - JXCategoryViewDelegate ---  标题的View
extension Welfare_ViewController :JXSegmentedViewDelegate{
    func segmentedView(_ segmentedView: JXSegmentedView, didSelectedItemAt index: Int) {
        if let dotDataSource = segmentedDataSource as? JXSegmentedDotDataSource {
            //先更新数据源的数据
            dotDataSource.dotStates[index] = false
            //再调用reloadItem(at: index)
            segmentedView.reloadItem(at: index)
        }
        navigationController?.interactivePopGestureRecognizer?.isEnabled = (segmentedView.selectedIndex == 0)
    }
    
    func segmentedView(_ segmentedView: JXSegmentedView, didClickSelectedItemAt index: Int) {
        //传递didClickSelectedItemAt事件给listContainerView，必须调用！！！
        listContainerView.didClickSelectedItem(at: index)
    }
    
    func segmentedView(_ segmentedView: JXSegmentedView, scrollingFrom leftIndex: Int, to rightIndex: Int, percent: CGFloat) {
        //传递scrollingFrom事件给listContainerView，必须调用！！！
        listContainerView.segmentedViewScrolling(from: leftIndex, to: rightIndex, percent: percent, selectedIndex: segmentedView.selectedIndex)
    }


}
// MARK: - JXSegmentedListContainerViewListDelegate ---- 列表的View
extension Welfare_ViewController :JXSegmentedListContainerViewDataSource{
    //返回列表的数量
    func numberOfLists(in listContainerView: JXSegmentedListContainerView) -> Int {
        if let titleDataSource = segmentedView.dataSource as? JXSegmentedBaseDataSource {
            CWLog(titleDataSource.dataSource.count)
            return titleDataSource.dataSource.count
        }
        return 0
    }
    //返回遵从`JXSegmentedListContainerViewListDelegate`协议的实例
    func listContainerView(_ listContainerView: JXSegmentedListContainerView, initListAt index: Int) -> JXSegmentedListContainerViewListDelegate {
        if index != 0 {
            return ListBaseViewController()
        }else {
            return Profile_ViewController()
        }
    }
}


// 基础的头部title    View设置
extension Welfare_ViewController {
    private func configureWithBase_UI(){
        // segmentedView 设置
        segmentedView.delegate = self
        segmentedView.backgroundColor = UIColor.lightGray
        segmentedView.frame = CGRect(x: 0, y: 0, width: Configs.Dimensions.screenWidth, height: 40)
        view.addSubview(segmentedView)
        //配置指示器
        let indicator = JXSegmentedIndicatorLineView()
        indicator.indicatorWidth = JXSegmentedViewAutomaticDimension
        segmentedView.indicators = [indicator]
        //segmentedDataSource一定要通过属性强持有，不然会被释放掉
        //配置数据源
        dataSource.isTitleColorGradientEnabled = true
        dataSource.titles = [MyAPI.LXFNetworkCategory.all.rawValue,
                             MyAPI.LXFNetworkCategory.android.rawValue,
                             MyAPI.LXFNetworkCategory.ios.rawValue,
                             MyAPI.LXFNetworkCategory.welfare.rawValue,
        ]
        
        dataSource.isTitleZoomEnabled = true
        dataSource.titleSelectedZoomScale = 1.2
        dataSource.isTitleStrokeWidthEnabled = true
        dataSource.isSelectedAnimable = true
        dataSource.isItemWidthZoomEnabled = true

        dataSource.titleNumberOfLines = 2
        dataSource.itemContentWidth = 60
        //reloadData(selectedIndex:)一定要调用
        dataSource.reloadData(selectedIndex: 0)
        segmentedDataSource = dataSource
        segmentedView.dataSource = segmentedDataSource
        
        
        //关联cotentScrollView，关联之后才可以互相联动！！！
        segmentedView.contentScrollView = listContainerView.scrollView
        listContainerView.didAppearPercent = 0.01
        view.addSubview(listContainerView)
        
    }
}
