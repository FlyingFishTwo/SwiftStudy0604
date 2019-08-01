//
//  ContainerViewController.swift
//  SwiftStudy0604
//
//  Created by wanglishuai on 2019/8/1.
//  Copyright © 2019 King. All rights reserved.
//

import UIKit

import RxCocoa
import RxSwift

let searchCell = "searchCell"


class ContainerViewController: Base_ViewController {
    
    //懒加载 tableView
    lazy var tableView:UITableView = {
        let table = UITableView(frame: CGRect(x: 0, y: 0, width: Configs.Dimensions.screenWidth, height: Configs.Dimensions.screenHeight-Configs.Dimensions.topHeight), style: .plain )
        table.register(cellType: Banner_Cell.self)
        table.register(UITableViewCell.self, forCellReuseIdentifier: searchCell)
        table.tableFooterView = UIView()
        return table
    }()

    lazy var searchController = UISearchController.init(searchResultsController: nil)
    lazy var searchBar = searchController.searchBar

    var searchBarText : Observable<String> {
        return searchBar.rx.text.orEmpty
            .throttle(0.3, latest: true, scheduler: MainScheduler.instance)
            .distinctUntilChanged()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        
        tableView.tableHeaderView = searchController.searchBar
        searchBar.searchBarStyle = .default
        searchBar.tintColor = .red
        searchBar.barTintColor = .orange
        self.definesPresentationContext = true
        



        let viewModel = ContainerViewModel(withSearchText: searchBarText, service: SearchService.shareInstance)
        
        viewModel.models.drive(tableView.rx.items(cellIdentifier: searchCell, cellType: UITableViewCell.self)) {
            row,element,cell in
            cell.textLabel?.text = element.name
            cell.detailTextLabel?.text = element.desc
            cell.imageView?.image = UIImage(named: element.icon!)
        }.disposed(by: disposeBag)
        
        

    }

}



extension ViewController: UISearchControllerDelegate {
    func didPresentSearchController(_ searchController: UISearchController) {
        searchController.searchBar.setShowsCancelButton(false, animated: false)
    }
}


