//
//  GitRepositoryTableViewCellTestCase.swift
//  GitRepositoriesStarsTests
//
//  Created by Renato Ioshida on 29/06/20.
//  Copyright © 2020 Renato Ioshida. All rights reserved.
//

import Quick
import Nimble
import Nimble_Snapshots

@testable import GitRepositoriesStars

class GitRepositoryTableViewCellTestCase: QuickSpec {

    override func spec() {
        describe("GitRepositoryTableViewCell") {
            var cell: GitRepositoryTableViewCell!
            
            beforeEach {
                cell = GitRepositoryTableViewCell()
                cell.translatesAutoresizingMaskIntoConstraints = false
            }
            
            it("should the started layout") {
                expect(cell) == recordSnapshot()
            }
            
            it("should show the repository text") {
                cell.repositoryLabel.text = "Renato Repository"
                expect(cell) == recordSnapshot()
            }
            
            it("should show the name text") {
                cell.nameLabel.text = "Renato"
                expect(cell) == recordSnapshot()
            }
            
            it("should show the score text") {
                cell.scoreLabel.text = "Score"
                expect(cell) == recordSnapshot()
            }
        }
    }

}
