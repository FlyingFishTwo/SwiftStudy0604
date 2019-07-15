//
//  Banner_HeaderView.swift
//  SwiftStudy0604
//
//  Created by wanglishuai on 2019/7/11.
//  Copyright © 2019 King. All rights reserved.
//

import UIKit
import FSPagerView
import SnapKit

class Banner_HeaderView: UIView {
    
//    var imageArray : [URL]?{
//        didSet{
//            configureWithPageView_PageControl()
//        }
//    }
    
    var imageArray = [URL]()
    
    
    lazy var pagerView = FSPagerView()
    lazy var pageControl = FSPageControl()
    
    
    init(frame: CGRect, dataArray:Array<Any>?) {
        super.init(frame: frame)
        if let array = dataArray {
            self.imageArray = array as! [URL]
            configureWithPageView_PageControl()
        }else{
            
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}


extension Banner_HeaderView {
    
    func configureWithPageView_PageControl() {
        pagerView.dataSource = self
        pagerView.delegate = self
        pagerView.automaticSlidingInterval =  3
        pagerView.isInfinite = true
        pagerView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        // 枚举，可以h根据需求选择想要的效果
        pagerView.transformer = FSPagerViewTransformer(type: .linear)
        pagerView.interitemSpacing = 15  // 两张图片之间的间距
        pagerView.itemSize = CGSize.init(width: self.width - 60, height: 160) // 图片的大小
        pagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "Banner_Cell")
        self.addSubview(pagerView)
        
        guard imageArray.count != 0 else {
            return
        }
        
        pageControl.numberOfPages = imageArray.count
        pageControl.contentHorizontalAlignment = .center
        pageControl.setFillColor(.gray, for: .normal)
        pageControl.setFillColor(UIColor.red, for: .selected)
        self.addSubview(pageControl)
        
        pagerView.snp.makeConstraints { (make) in
//            make.height.equalTo(160)
            make.left.top.right.bottom.equalToSuperview()
        }
        pageControl.snp.makeConstraints { (make) in
            make.width.equalTo(80)
            make.height.equalTo(30)
            make.bottom.equalTo(pagerView.snp.bottom).offset(-10)
            make.centerX.equalTo(pagerView)
        }

    }
}


extension Banner_HeaderView:FSPagerViewDataSource, FSPagerViewDelegate {
    //实现代理 :FSPagerViewDataSource, FSPagerViewDelegate
    // MARK:- FSPagerView Delegate
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return imageArray.count
    }
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "Banner_Cell", at: index)
        cell.imageView?.kf.setImage(with: imageArray[index])
        cell.textLabel?.text = "超好用的无限轮播图"
        cell.textLabel?.font = UIFont.systemFont(ofSize: 13.0)
        return cell
    }
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        let url:URL = imageArray[index]
        print(url)
    }
    
    
    func pagerViewWillEndDragging(_ pagerView: FSPagerView, targetIndex: Int) {
        self.pageControl.currentPage = targetIndex
    }
    
    func pagerViewDidEndScrollAnimation(_ pagerView: FSPagerView) {
        self.pageControl.currentPage = pagerView.currentIndex
    }
    
}
