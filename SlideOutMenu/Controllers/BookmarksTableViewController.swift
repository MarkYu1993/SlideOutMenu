//
//  BookmarksViewController.swift
//  SlideOutMenu
//
//  Created by EMCT on 2023/3/22.
//

import UIKit

class BookmarksTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .green
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.text = "Bookmark: \(indexPath.row)"
        return cell
    }

}
