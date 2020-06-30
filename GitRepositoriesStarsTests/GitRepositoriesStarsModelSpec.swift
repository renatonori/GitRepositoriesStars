//
//  GitRepositoriesStarsModelSpec.swift
//  GitRepositoriesStarsTests
//
//  Created by Renato Ioshida on 28/06/20.
//  Copyright © 2020 Renato Ioshida. All rights reserved.
//

import Quick
import Nimble

@testable import GitRepositoriesStars

class GitRepositoriesStarsModelSpec: QuickSpec {
    override func spec() {
        
        let userModel = GitRepositoryUserModel(login: "Renato", avatar_url: "URL")
        
        let model = GitRepositoryModel(name: "Renato", stargazers_count: 100, owner: userModel)
        
        describe("the GitRepositoryUserModel") {
            context("Look if the model was properly initialized") {
                it("should be equal") {
                    expect(userModel.login).to(equal("Renato"))
                    expect(userModel.avatar_url).to(equal("URL"))
                }
            }
        }
        
        
        describe("the GitRepositoryModel") {
            context("Look if the model was properly initialized") {
                it("should be equal") {
                    expect(model.name).to(equal("Renato"))
                    expect(model.stargazers_count).to(equal(100))
                    expect(model.owner).to(equal(userModel))
                }

            }
        }
        
        let userModel2 = GitRepositoryUserModel(login: "Ioshida", avatar_url: "URL")
        
        let model2 = GitRepositoryModel(name: "Ioshida", stargazers_count: 100, owner: userModel2)
        
        let list = GitRepositoryListModel(items: [model, model2])
        
        describe("The GitRepositoryListModel") {
            context("Look if the model was properly initialized") {
                it("should be equal") {
                    let item1 = list.items[0]
                    expect(item1).to(equal(model))
                    let item2 = list.items[1]
                    expect(item2).to(equal(model2))
                }
            }
        }
    }
}
