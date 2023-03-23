//
//  MenuItemCell.swift
//  SlideOutMenu
//
//  Created by EMCT on 2023/3/17.
//

import UIKit

class IconImageView: UIImageView {
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 40, height: 40)
    }
}

class MenuItemCell: UITableViewCell {

    let iconImageView: IconImageView = {
        let iv = IconImageView()
        iv.contentMode = .scaleAspectFit
        return iv
    }()

    let titleLabel: UILabel = {
        let lb = UILabel()
        lb.font = .systemFont(ofSize: 20, weight: .medium)
        return lb
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        let stackView = UIStackView(arrangedSubviews: [iconImageView, titleLabel, UIView()])
        stackView.spacing = 12
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 8, left: 12, bottom: 8, right: 12)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }



}
