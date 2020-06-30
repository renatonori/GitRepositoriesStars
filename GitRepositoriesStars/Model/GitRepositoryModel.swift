//
//  GitRepositoryModel.swift
//  GitRepositoriesStars
//
//  Created by Renato Ioshida on 27/06/20.
//  Copyright © 2020 Renato Ioshida. All rights reserved.
//

import Foundation



struct GitRepositoryListModel: Decodable, Equatable {
    let items: [GitRepositoryModel]
}

struct GitRepositoryModel: Decodable,Equatable {
    let name: String
    let stargazers_count: Int
    let owner: GitRepositoryUserModel

}

struct GitRepositoryUserModel: Decodable,Equatable {
    let login: String
    let avatar_url: String
}
