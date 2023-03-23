//
//  MenuTableViewController.swift
//  SlideOutMenu
//
//  Created by EMCT on 2023/3/16.
//

import UIKit

struct MenuItem {
    let icon: UIImage
    let title: String
}

class MenuTableViewController: UITableViewController {
    let menuItems: [MenuItem] = [
        MenuItem(icon: UIImage(systemName: "person")!, title: "Home"),
        MenuItem(icon: UIImage(systemName: "list.bullet.rectangle")!, title: "Lists"),
        MenuItem(icon: UIImage(systemName: "bookmark")!, title: "Bookmarks"),
        MenuItem(icon: UIImage(systemName: "lightbulb")!, title: "Moments")
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorStyle = .none
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return menuItems.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = MenuItemCell(style: .default, reuseIdentifier: "cellId")
        let item = menuItems[indexPath.row]
        cell.iconImageView.image = item.icon
        cell.iconImageView.tintColor = .black
        cell.titleLabel.text = item.title
        return cell
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = CustomMenuHeaderView()
        return headerView
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let slidingController = UIApplication.shared.keyWindow?.rootViewController as? BaseSlidingViewController
        slidingController?.didSelectMenuItem(indexPath: indexPath)
    }
}
