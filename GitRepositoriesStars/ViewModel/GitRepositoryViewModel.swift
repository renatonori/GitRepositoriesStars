//
//  ViewControllerViewModel.swift
//  GitRepositoriesStars
//
//  Created by Renato Ioshida on 27/06/20.
//  Copyright © 2020 Renato Ioshida. All rights reserved.
//

import Foundation

protocol GitRepositoryViewModelDelegate {
    func fetchStart(fromBottom: Bool)
    func fetchFinished()
}

class GitRepositoryViewModel {
    
    var service: GitRepositoriesService?
    var delegate: GitRepositoryViewModelDelegate?
    
    internal init(service: GitRepositoriesService?) {
        self.service = service
    }
    
    var page = 2
    
    var repositoriesItens: [GitRepositoryModel] = []
    
    func fetchRepository(fromBottom: Bool) {
        self.delegate?.fetchStart(fromBottom: fromBottom)
        self.service?.fetch(page: "\(self.usagePage(fromBottom: fromBottom))", completionBlock: { success, result  in
            if let result = result, success {
                self.setupRespositoriesItems(fromBottom: fromBottom, and: result.items)
            }
            self.delegate?.fetchFinished()
        })
    }
    
    func setupRespositoriesItems(fromBottom: Bool, and items: [GitRepositoryModel]) {
        if fromBottom {
            self.page += 1
            self.repositoriesItens.append(contentsOf: items)
        } else {
            self.repositoriesItens = items
        }
    }
    
    func usagePage(fromBottom: Bool) -> Int {
        return fromBottom ? page : 1
    }
}
