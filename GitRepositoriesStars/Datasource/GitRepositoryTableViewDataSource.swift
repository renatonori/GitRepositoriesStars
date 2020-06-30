//
//  GitRepositoryTableViewDataSource.swift
//  GitRepositoriesStars
//
//  Created by Renato Ioshida on 29/06/20.
//  Copyright © 2020 Renato Ioshida. All rights reserved.
//

import Foundation
import UIKit

protocol GitRepositoryTableViewDataSourceProtocol {
    func didReachedTheEnd()
}

class GitRepositoryTableViewDataSource: NSObject, UITableViewDataSource {
    
    let cellID = "GitRepositoryTableViewCell"
    var delegate: GitRepositoryTableViewDataSourceProtocol?
    var data: [GitRepositoryModel]?
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as? GitRepositoryTableViewCell
             else {
            fatalError("Célula não existe")
        }
        
        let item = data?[indexPath.row]
        cell.repositoryLabel.text = item?.name
        cell.scoreLabel.text = "⭐️ \(String(describing: item?.stargazers_count))"
        cell.nameLabel.text = item?.owner.login
        
        if let urlAvatar = item?.owner.avatar_url {
            cell.setImage(urlString: urlAvatar)
        }
    
        return cell
    }
}

extension GitRepositoryTableViewDataSource: UITableViewDelegate {
     func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastSectionIndex = tableView.numberOfSections - 1
        let lastRowIndex = tableView.numberOfRows(inSection: lastSectionIndex) - 1
        if indexPath.section ==  lastSectionIndex && indexPath.row == lastRowIndex {
            self.delegate?.didReachedTheEnd()
        }
    }
}
