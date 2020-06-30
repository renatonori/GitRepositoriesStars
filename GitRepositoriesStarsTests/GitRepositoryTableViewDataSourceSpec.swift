//
//  GitRepositoryTableViewDataSourceSpec.swift
//  GitRepositoriesStarsTests
//
//  Created by Renato Ioshida on 29/06/20.
//  Copyright © 2020 Renato Ioshida. All rights reserved.
//


import Foundation
import Quick
import Nimble
import Nimble_Snapshots

@testable import GitRepositoriesStars

class GitRepositoryTableViewDataSourceSpec: QuickSpec {
    override func spec() {
        var dataSource: GitRepositoryTableViewDataSource!
        var tableView: UITableView!
        
        beforeEach {
            
            
            let userModel = GitRepositoryUserModel(login: "Renato", avatar_url: "URL")
            let model = GitRepositoryModel(name: "Renato", stargazers_count: 100, owner: userModel)
            
            let userModel2 = GitRepositoryUserModel(login: "Nori", avatar_url: "URL")
            let model2 = GitRepositoryModel(name: "Nori", stargazers_count: 100, owner: userModel2)
            
            let userModel3 = GitRepositoryUserModel(login: "Ioshida", avatar_url: "URL")
            let model3 = GitRepositoryModel(name: "Ioshida", stargazers_count: 100, owner: userModel3)
            
            let data = [model,model2,model3]
            
            dataSource = GitRepositoryTableViewDataSource()
            dataSource.data = data
            
            tableView = UITableView()
            tableView.register(GitRepositoryTableViewCell.self,
                               forCellReuseIdentifier: "c")
            tableView.dataSource = dataSource
            tableView.delegate = dataSource
        }
        
        
        it("should return the right number of rows") {
            expect(dataSource.tableView(tableView, numberOfRowsInSection: 0)) == 3
        }
        
    }
}

