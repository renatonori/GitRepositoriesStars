//
//  ViewControllerViewModelSpec.swift
//  GitRepositoriesStarsTests
//
//  Created by Renato Ioshida on 29/06/20.
//  Copyright © 2020 Renato Ioshida. All rights reserved.
//

import Quick
import Nimble

@testable import GitRepositoriesStars

class ViewControllerViewModelSpec: QuickSpec {

    
    override func spec() {
        
        let service = GitRepositoriesService()
        
        describe("The viewModel test") {
            context("Look if the viewModel was properly initialized") {
                it("should be equal") {
                    
                    let viewModel = GitRepositoryViewModel(service: service)
                    expect(viewModel.page).to(equal(2))
                    expect(viewModel.repositoriesItens).to(equal([]))
                }
            }
        }
        
        describe("The viewmodel usagePage") {
            context("Look if usage page returns the right number when is no fromBottom") {
                it("should be 1") {
                    let viewModel = GitRepositoryViewModel(service: service)
                    expect(viewModel.usagePage(fromBottom: false)).to(equal(1))
                }
            }
        }
        
        describe("The viewmodel usagePage") {
            context("Look if usage page returns the right number when is fromBottom") {
                it("should be egual to page") {
                    let viewModel = GitRepositoryViewModel(service: service)
                    expect(viewModel.usagePage(fromBottom: true)).to(equal(viewModel.page))
                }
            }
        }
        
        
        let userModel = GitRepositoryUserModel(login: "Renato", avatar_url: "URL")
        let model = GitRepositoryModel(name: "Renato", stargazers_count: 100, owner: userModel)
        
        
        describe("The ViewModel repositoriesItens") {
            context("Look if the repositoriesItens is adding item") {
                it("Should add new item") {
                    let viewModel = GitRepositoryViewModel(service: service)
                    viewModel.repositoriesItens.append(model)
                    expect(viewModel.repositoriesItens.count).to(equal(1))
                }
            }
        }
        
        describe("The viewModel setupRespositoriesItems") {
            context("Look if the setupRespositoriesItems is working when is fromBottom") {
                it("should append a new obj on array and page is 3") {
                    let viewModel = GitRepositoryViewModel(service: service)
                    viewModel.setupRespositoriesItems(fromBottom: true, and: [model])
                    viewModel.setupRespositoriesItems(fromBottom: true, and: [model])
                    expect(viewModel.repositoriesItens.count).to(equal(2))
                    expect(viewModel.page).to(equal(4))
                }
            }
        }
        
        
        describe("The viewModel setupRespositoriesItems") {
            context("Look if the setupRespositoriesItems is working when is not fromBottom") {
                it("should change the array to one obj and page is the same as the last test") {
                    let viewModel = GitRepositoryViewModel(service: service)
                    
                    viewModel.setupRespositoriesItems(fromBottom: true, and: [model])
                    viewModel.setupRespositoriesItems(fromBottom: true, and: [model])
                    
                    viewModel.setupRespositoriesItems(fromBottom: false, and: [model])
                    expect(viewModel.repositoriesItens.count).to(equal(1))
                }
            }
        }
        
    }
}
