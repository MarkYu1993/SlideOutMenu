//
//  SpacerView.swift
//  SlideOutMenu
//
//  Created by EMCT on 2023/3/17.
//

import UIKit

class SpacerView: UIView {
    let space: CGFloat

    override var intrinsicContentSize: CGSize {
        return .init(width: 16, height: 16)
    }

    init(space: CGFloat) {
        self.space = space
        super.init(frame: .zero)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
