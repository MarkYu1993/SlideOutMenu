//
//  ListViewController.swift
//  SlideOutMenu
//
//  Created by EMCT on 2023/3/22.
//

import UIKit

class ListViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .yellow
        let lb = UILabel()
        lb.text = "Markkkkk"
        lb.font = .systemFont(ofSize: 64, weight: .bold)
        lb.frame = view.frame
        lb.textAlignment = .center
        view.addSubview(lb)
    }

}
