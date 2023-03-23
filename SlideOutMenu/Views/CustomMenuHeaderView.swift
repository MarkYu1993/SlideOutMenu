//
//  CustomMenuHeaderView.swift
//  SlideOutMenu
//
//  Created by EMCT on 2023/3/17.
//

import UIKit

class CustomMenuHeaderView: UIView {
    let nameLabel = UILabel()
    let userNameLabel = UILabel()
    let statsLabel = UILabel()
    let profileImageView = ProfileImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupComponentProps()
        setupStackView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    fileprivate func setupComponentProps() {
        // 客製化元件
        nameLabel.text = "Mark Yu"
        nameLabel.font = .systemFont(ofSize: 20, weight: .heavy)
        userNameLabel.text = "@markyu1993"
        statsLabel.text = "99 Following 8888 Followers"
        profileImageView.image = UIImage(named: "kb24")
        profileImageView.contentMode = .scaleAspectFit
        profileImageView.layer.cornerRadius = 48/2
        profileImageView.clipsToBounds = true

        setupStatsAttributedText()
    }

    fileprivate func setupStatsAttributedText() {
        statsLabel.font = .systemFont(ofSize: 14)
        let attributedText = NSMutableAttributedString(string: "42 ", attributes: [.font: UIFont.systemFont(ofSize: 16, weight: .medium)])
        attributedText.append(NSAttributedString(string: "Following  ", attributes: [.foregroundColor: UIColor.black]))
        attributedText.append(NSAttributedString(string: "7091 ", attributes: [.font: UIFont.systemFont(ofSize: 16, weight: .medium)]))
        attributedText.append(NSAttributedString(string: "Followers", attributes: [.foregroundColor: UIColor.black]))
        statsLabel.attributedText = attributedText
    }

    fileprivate func setupStackView() {
        let rightSpacerView = UIView()
        let arrangedSubviews = [
            UIStackView(arrangedSubviews: [profileImageView, rightSpacerView]),
            nameLabel,
            userNameLabel,
            statsLabel
        ]
        let stackView = UIStackView(arrangedSubviews: arrangedSubviews)
        stackView.axis = .vertical
        stackView.spacing = 8
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 24, left: 24, bottom: 24, right: 24)
    }
}
