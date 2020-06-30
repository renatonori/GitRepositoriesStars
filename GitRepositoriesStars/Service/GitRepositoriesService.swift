//
//  GitRepositoriesService.swift
//  GitRepositoriesStars
//
//  Created by Renato Ioshida on 27/06/20.
//  Copyright © 2020 Renato Ioshida. All rights reserved.
//

import Foundation
import Alamofire

class GitRepositoriesService {
    //https://api.github.com/search/repositories?q=language%3Aswift&sort=stars&page=2
    
    let fetchURL = "https://api.github.com/search/repositories?q=language:swift&sort=stars"
    
    func fetch(page: String, completionBlock: @escaping (_ success: Bool, _ model: GitRepositoryListModel?) -> Void) {
        let urlToUse = fetchURL + "&page=\(page)"
        AF.request(urlToUse).response { result in
            if let status = result.response?.statusCode, let data = result.data, status == 200 {
                do {
                    let list = try JSONDecoder().decode(GitRepositoryListModel.self, from: data)
                    completionBlock(true, list)
                } catch _ {
                    completionBlock(false, nil)
                }
                
            } else {
                completionBlock(false, nil)
            }
            
        }
    }
}
