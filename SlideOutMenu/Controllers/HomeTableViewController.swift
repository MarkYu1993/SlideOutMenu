//
//  ViewController.swift
//  SlideOutMenu
//
//  Created by EMCT on 2023/3/16.
//

import UIKit

class HomeTableViewController: UITableViewController {

    let menuTVC = MenuTableViewController()

    fileprivate let menuWidth: CGFloat = 300
    fileprivate var isMenuOpened = false
    fileprivate let velocityOpenThreshold: CGFloat = 500

    /// 位移的動畫效果
    fileprivate func performAnimations(transform: CGAffineTransform) {
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut) {
            self.menuTVC.view.transform = transform
            self.navigationController?.view.transform = transform
            self.darkCorverView.transform = transform
            if transform == .identity {
                self.darkCorverView.alpha = 0
            } else {
                self.darkCorverView.alpha = 1
            }
        }
    }

    @objc func menuButtonTapped() {
        isMenuOpened = true
        // 選單的動畫效果
        performAnimations(transform: CGAffineTransform(translationX: self.menuWidth, y: 0))
    }

    @objc func hideButtonTapped() {
        isMenuOpened = false
        // 隱藏時一樣使用動畫效果縮回去，而非移除
        performAnimations(transform: .identity)
    }

    fileprivate func setupNavigationItem() {
        navigationItem.title = "Home"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Menu", style: .plain, target: self, action: #selector(menuButtonTapped))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Hide", style: .plain, target: self, action: #selector(hideButtonTapped))
    }

    fileprivate func setupMenuTVC() {
        // 設定選單的初始位置在畫面外的寬度位置
        menuTVC.view.frame = CGRect(x: -menuWidth, y: 0, width: menuWidth, height: self.view.frame.height)
        let mainWindow = UIApplication.shared.keyWindow
        mainWindow?.addSubview(menuTVC.view)

        // 當加入第二個vc的view在current vc的view上面時，必須使用addChild保證功能正常, 移除時同樣要removeFromParent
        addChild(menuTVC)
    }

    fileprivate func setupUI() {
        view.backgroundColor = .red
    }

    @objc func handlePan(gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: view)
        if gesture.state == .changed {
            var x = translation.x
            if isMenuOpened {
                x += menuWidth
            }
            x = min(menuWidth, x)
            x = max(0, x)
            // drag
            let transform = CGAffineTransform(translationX: x, y: 0)
            menuTVC.view.transform = transform
            navigationController?.view.transform = transform
            darkCorverView.transform = transform
            darkCorverView.alpha = x / menuWidth
        } else if gesture.state == .ended {
            handleEnded(gesture: gesture)
        }
    }

    fileprivate func handleEnded(gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: view)

        let velocity = gesture.velocity(in: view)

        if isMenuOpened {
            // 控制速度 速度快的時候直接收起來
            if abs(velocity.x) > velocityOpenThreshold {
                hideButtonTapped()
                return
            }
            // 當移動的距離(絕對值) < menu寬度的一半
            if abs(translation.x) < menuWidth/2 {
                menuButtonTapped()
            } else {
                hideButtonTapped()
            }
        } else {
            // 控制速度 速度快的時候直接打開
            if velocity.x > velocityOpenThreshold {
                menuButtonTapped()
                return
            }
            // 當往右滑的距離(一定為正所以不用abs) < menu寬度的一半
            if translation.x < menuWidth/2 {
                hideButtonTapped()
            } else {
                menuButtonTapped()
            }
        }
    }

    fileprivate func setupPanGesture() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
//        panGesture.delegate = self
        view.addGestureRecognizer(panGesture)
    }

    let darkCorverView = UIView()

    fileprivate func setupDarkCoverView() {
        darkCorverView.isUserInteractionEnabled = false
        darkCorverView.alpha = 0
        darkCorverView.backgroundColor = UIColor(white: 0, alpha: 0.8)
        let mainWindow = UIApplication.shared.keyWindow
        mainWindow?.addSubview(darkCorverView)
        darkCorverView.frame = mainWindow?.frame ?? .zero
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.backgroundColor = .red
        setupUI()
        setupNavigationItem()
//        setupPanGesture()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupMenuTVC()
        setupDarkCoverView()
    }


    // MARK: - UITableView
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = "Row: \(indexPath.row)"
        return cell
    }
    
}
