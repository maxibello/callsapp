//
//  ViewController.swift
//  callsapp
//
//  Created by Maxim Kuznetsov on 30.03.2021.
//

import UIKit
import SnapKit
import RxSwift

class MissedCallsViewController: UIViewController {
    
    private let tableView = UITableView()
    private let cellIdentifier = "cellIdentifier"
    private let viewModel = CallsViewModel()
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureProperties()
        configureLayout()
        bind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
    }
    
    private func configureProperties() {
        title = "Missed Calls"
        tableView.separatorStyle = .none
        tableView.register(CallViewCell.self, forCellReuseIdentifier: cellIdentifier)
    }
    
    private func configureLayout() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { v in
            v.edges.equalToSuperview()
        }
        tableView.contentInset.bottom = view.safeAreaInsets.bottom
    }
    
    private func bind() {
        viewModel.items
            .compactMap { $0.requests }
            .bind(to: tableView.rx.items(cellIdentifier: cellIdentifier, cellType: CallViewCell.self)) { index, model, cell in
                print(model)
                cell.setData(model)
            }.disposed(by: disposeBag)
        
        tableView.rx.modelSelected(CallModel.self).withUnretained(self)
            .subscribe(onNext: { vc, item in
                let detailVC = DetailCallViewController()
                detailVC.callModel = item
                vc.navigationController?.pushViewController(detailVC, animated: true)
            }).disposed(by: disposeBag)
    }
}

