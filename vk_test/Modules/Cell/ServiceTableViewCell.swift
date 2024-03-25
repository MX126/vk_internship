//
//  ServiceTableViewCell.swift
//  vk_test
//
//  Created by Михаил on 26.03.2024.
//

import UIKit
import PinLayout

class ServiceTableViewCell: UITableViewCell {
    
    // MARK: - private properties
    
    private let iconImageView = UIImageView()
    private let nameLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let proceedImageView = UIImageView()
    
    // MARK: - life cycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setup()
        
        contentView.addSubviews(iconImageView, nameLabel, descriptionLabel, proceedImageView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - actions
    
    func configure(with text: String, and desc: String, and image: UIImage) {
        self.iconImageView.image = image
        self.nameLabel.text = text
        self.descriptionLabel.text = desc
    }
    
    // MARK: - setup
    
    private func setup() {
        setupImageView()
        setupLabels()
    }
    
    private func setupImageView() {
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.layer.cornerRadius = Constants.iconImageView.cornerRadius
        iconImageView.clipsToBounds = true
        
        proceedImageView.image = UIImage(systemName: "chevron.right")
        proceedImageView.tintColor = Constants.proceedImageView.gray
    }
    
    private func setupLabels() {
        nameLabel.font = UIFont.boldSystemFont(ofSize: Constants.nameLabel.fontSize)
        
        descriptionLabel.font = UIFont.systemFont(ofSize: Constants.descriptionLabel.fontSize)
        descriptionLabel.textColor = .gray
        descriptionLabel.numberOfLines = Constants.descriptionLabel.linesNumber
    }
    
    // MARK: - layout
    
    private func layout() {
        let proceedImageTotalWidth = Constants.proceedImageView.size.width + Constants.proceedImageView.right + Constants.proceedImageView.marginToText
        
        iconImageView.pin
            .top(Constants.iconImageView.top)
            .left(Constants.iconImageView.left)
            .width(Constants.iconImageView.size.width)
            .height(Constants.iconImageView.size.height)
                
        nameLabel.pin
            .top(Constants.nameLabel.top)
            .after(of: iconImageView)
            .marginLeft(Constants.nameLabel.marginLeft)
            .right(Constants.nameLabel.right)
            .sizeToFit(.width)
        
        descriptionLabel.pin
            .below(of: nameLabel)
            .marginTop(Constants.descriptionLabel.marginTop)
            .after(of: iconImageView)
            .marginLeft(Constants.descriptionLabel.marginLeft)
            .right(Constants.descriptionLabel.right + proceedImageTotalWidth)
            .sizeToFit(.widthFlexible)
           
        proceedImageView.pin
            .right(Constants.proceedImageView.right)
            .vCenter()
            .width(Constants.proceedImageView.size.width)
            .height(Constants.proceedImageView.size.height)
    }
}

// MARK: - Constants

private extension ServiceTableViewCell {
    struct Constants {
        struct iconImageView {
            static let top: CGFloat = 10
            static let left: CGFloat = 10
            static let size: CGSize = CGSize(width: 64, height: 64)
            static let cornerRadius: CGFloat = 12
        }
        
        struct nameLabel {
            static let top: CGFloat = 10
            static let marginLeft: CGFloat = 10
            static let right: CGFloat = 10
            static let fontSize: CGFloat = 20
        }
        
        struct descriptionLabel {
            static let marginTop: CGFloat = 2
            static let marginLeft: CGFloat = 10
            static let right: CGFloat = 10
            static let fontSize: CGFloat = 16
            static let linesNumber: Int = 0
        }
        
        struct proceedImageView {
            static let right: CGFloat = 10
            static let size: CGSize = CGSize(width: 16, height: 16)
            static let gray = UIColor.gray
            static let marginToText: CGFloat = 5
        }
    }
}
