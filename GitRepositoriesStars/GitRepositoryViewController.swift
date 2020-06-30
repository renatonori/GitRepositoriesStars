//
//  ViewController.swift
//  GitRepositoriesStars
//
//  Created by Renato Ioshida on 27/06/20.
//  Copyright © 2020 Renato Ioshida. All rights reserved.
//

import UIKit
import Cartography

class GitRepositoryViewController: UIViewController {
    let cellID = "GitRepositoryTableViewCell"
    let tvDataSource: GitRepositoryTableViewDataSource = GitRepositoryTableViewDataSource()
    var viewModel: GitRepositoryViewModel?
    
    private let refreshControl = UIRefreshControl()
    private let bottomSpinner = UIActivityIndicatorView(style: .large)
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViewModel()
        self.setupView()
        self.viewModel?.fetchRepository(fromBottom: false)
    }
    
    func setupViewModel() {
        let service = GitRepositoriesService()
        self.viewModel = GitRepositoryViewModel(service: service)
        self.viewModel?.delegate = self
    }
    
    func setupView() {
        self.view.addSubview(tableView)
        
        constrain(self.tableView) { table in
            guard let superview = table.superview else {return}
            table.top == superview.top
            table.left == superview.left
            table.right == superview.right
            table.bottom == superview.bottom
        }
        self.setupTableView()
        self.setupRefresher()
    }
    
    func setupTableView() {
        self.tableView.register(GitRepositoryTableViewCell.self, forCellReuseIdentifier: cellID)
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 44
        
        tvDataSource.delegate = self
        self.tableView.dataSource = tvDataSource
        self.tableView.delegate = tvDataSource
        
    }

    func setupRefresher() {
        self.tableView.addSubview(refreshControl)
        refreshControl.addTarget(self, action: #selector(refreshRepositories(_:)), for: .valueChanged)
        refreshControl.attributedTitle = NSAttributedString(string: "Fetching Repositories ...", attributes: nil)
        
        bottomSpinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(44))
        
        self.tableView.tableFooterView = bottomSpinner
    }
    
    @objc private func refreshRepositories(_ sender: Any) {
        self.viewModel?.fetchRepository(fromBottom: false)
    }
}
extension GitRepositoryViewController: GitRepositoryTableViewDataSourceProtocol {
    func didReachedTheEnd() {
        self.viewModel?.fetchRepository(fromBottom: true)
        self.fetchStart(fromBottom: true)
    }
}

extension GitRepositoryViewController: GitRepositoryViewModelDelegate {
    func fetchStart(fromBottom: Bool) {
        if fromBottom {
            self.bottomSpinner.startAnimating()
            self.tableView.tableFooterView?.isHidden = false
        } else {
            self.refreshControl.beginRefreshing()
        }
    }
    
    func fetchFinished() {
        self.bottomSpinner.isHidden = false
        self.refreshControl.endRefreshing()
        self.tvDataSource.data = self.viewModel?.repositoriesItens
        self.tableView.reloadData()
    }
}
