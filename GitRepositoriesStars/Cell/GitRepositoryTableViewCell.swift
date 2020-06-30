//
//  GitRepositoryTableViewCell.swift
//  GitRepositoriesStars
//
//  Created by Renato Ioshida on 27/06/20.
//  Copyright © 2020 Renato Ioshida. All rights reserved.
//

import UIKit
import Cartography
import AlamofireImage
import Alamofire

class GitRepositoryTableViewCell: UITableViewCell {

    let repositoryLabel: UILabel = {
       let label = UILabel()
        label.text = "Repository"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let labelStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let nameLabel: UILabel  = {
        let label = UILabel()
        label.text = "Name"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let scoreLabel: UILabel = {
        let label = UILabel()
        label.text = "score"
         label.translatesAutoresizingMaskIntoConstraints = false
         return label
    }()
    
    let userImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.lightGray
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupView()
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        userImageView.image = nil
        repositoryLabel.text = ""
        nameLabel.text = ""
        scoreLabel.text = ""
    }
    func setupView() {
        
        self.isUserInteractionEnabled = false
        
        self.addSubview(userImageView)
        self.addSubview(labelStackView)
        self.labelStackView.addArrangedSubview(repositoryLabel)
        self.labelStackView.addArrangedSubview(nameLabel)
        self.labelStackView.addArrangedSubview(scoreLabel)
        constrain(userImageView, labelStackView) { userImageView,labelStackView in
                    guard let superView = userImageView.superview else { return }
                    
            userImageView.width == 50
            userImageView.height == 50
            userImageView.topMargin == superView.topMargin + 8
            userImageView.leftMargin == superView.leftMargin
            userImageView.bottomMargin <= superView.bottomMargin
            
            labelStackView.top == userImageView.top
            labelStackView.rightMargin == superView.rightMargin
            labelStackView.left == userImageView.right + 8
            labelStackView.bottomMargin == superView.bottomMargin
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.roundUserImage()
    }
    
    func roundUserImage() {
        self.userImageView.layer.cornerRadius = self.userImageView.frame.width/2
    }
    func setImage(urlString: String) {
        AF.request(urlString).responseImage { response in
            if case .success(let image) = response.result {
                self.userImageView.image = image
            }
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
