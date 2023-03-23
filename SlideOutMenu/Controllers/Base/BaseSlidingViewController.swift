//
//  BaseSlidingViewController.swift
//  SlideOutMenu
//
//  Created by EMCT on 2023/3/17.
//

import UIKit

class BaseSlidingViewController: UIViewController {

    let redView: UIView = {
        let vw = UIView()
        vw.backgroundColor = .red
        // 設定這行 autoLayout才有辦法啟動
        vw.translatesAutoresizingMaskIntoConstraints = false
        return vw
    }()

    let blueView: UIView = {
        let vw = UIView()
        vw.backgroundColor = .blue
        // 設定這行 autoLayout才有辦法啟動
        vw.translatesAutoresizingMaskIntoConstraints = false
        return vw
    }()

    let darkCoverView: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor(white: 0, alpha: 0.7)
        v.alpha = 0
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        // translate our red view
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        view.addGestureRecognizer(panGesture)
    }

    @objc func handlePan(gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: view)
        var x = translation.x
        // 才不會超過選單的範圍（左邊）
        x = isMenuOpened ? x + menuWidth : x
        x = min(menuWidth, x)
        // 才不會超過畫面右邊
        x = max(0, x)

        redViewLeadingConstraint.constant = x
        darkCoverView.alpha = x / menuWidth

        if gesture.state == .ended {
            handleEnded(gesture: gesture)
        }
    }

    fileprivate let velocityThreshold: CGFloat = 500

    func openMenu() {
        redViewLeadingConstraint.constant = menuWidth
        isMenuOpened = true
        performAnimations()
    }

    func closeMenu() {
        redViewLeadingConstraint.constant = 0
        isMenuOpened = false
        performAnimations()
    }

    func didSelectMenuItem(indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            print("zzzzz")
        case 1:
            let listVC = ListViewController()
            redView.addSubview(listVC.view)
        case 2:
            print("yyyy")
            let bookmarksVC = BookmarksTableViewController()
            bookmarksVC.view.backgroundColor = .purple
            redView.addSubview(bookmarksVC.view)
            addChild(bookmarksVC)
        case 3:
            print("fffff")
        default:
            break
        }
        // 加上這行才會把灰色的view加回來
        redView.bringSubviewToFront(darkCoverView)
        closeMenu()
    }

    fileprivate func performAnimations() {
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
            // 畫面更新需要使用 如果沒加上的話在拖拉上的視覺效果會很突然
            self.view.layoutIfNeeded()
            self.darkCoverView.alpha = self.isMenuOpened ? 1 : 0
        }, completion: nil)
    }

    fileprivate func handleEnded(gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: view)
        let velocity = gesture.velocity(in: view)
        if isMenuOpened {
            if abs(velocity.x) > velocityThreshold {
                closeMenu()
                return
            }
            if abs(translation.x) < menuWidth / 2 {
                openMenu()
            } else {
                closeMenu()
            }
        } else {
            if abs(velocity.x) > velocityThreshold {
                openMenu()
                return
            }
            if translation.x < menuWidth / 2 {
                closeMenu()
            } else {
                openMenu()
            }
        }
    }

    var redViewLeadingConstraint: NSLayoutConstraint!
    private let menuWidth: CGFloat = 300
    private var isMenuOpened = false

    fileprivate func setupViews() {
        view.backgroundColor = .yellow
        view.addSubview(redView)
        view.addSubview(blueView)
        NSLayoutConstraint.activate([
            redView.topAnchor.constraint(equalTo: view.topAnchor),
            redView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            redView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            blueView.topAnchor.constraint(equalTo: view.topAnchor),
            blueView.trailingAnchor.constraint(equalTo: redView.safeAreaLayoutGuide.leadingAnchor),
            blueView.widthAnchor.constraint(equalToConstant: menuWidth),
            blueView.bottomAnchor.constraint(equalTo: redView.bottomAnchor)
        ])
        self.redViewLeadingConstraint = redView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0)
        redViewLeadingConstraint.isActive = true

        setupViewControllers()
    }

    fileprivate func setupViewControllers() {
        // 把HomeTVC加進來
        let homeTVC = HomeTableViewController()
        let menuTVC = MenuTableViewController()
        let homeView = homeTVC.view!
        let menuView = menuTVC.view!
        homeView.translatesAutoresizingMaskIntoConstraints = false
        menuView.translatesAutoresizingMaskIntoConstraints = false
        redView.addSubview(homeView)
        redView.addSubview(darkCoverView)
        blueView.addSubview(menuView)
        NSLayoutConstraint.activate([
            homeView.topAnchor.constraint(equalTo: redView.topAnchor),
            homeView.leadingAnchor.constraint(equalTo: redView.leadingAnchor),
            homeView.bottomAnchor.constraint(equalTo: redView.bottomAnchor),
            homeView.trailingAnchor.constraint(equalTo: redView.trailingAnchor),
            menuView.topAnchor.constraint(equalTo: blueView.topAnchor),
            menuView.leadingAnchor.constraint(equalTo: blueView.leadingAnchor),
            menuView.bottomAnchor.constraint(equalTo: blueView.bottomAnchor),
            menuView.trailingAnchor.constraint(equalTo: blueView.trailingAnchor),
            darkCoverView.topAnchor.constraint(equalTo: redView.topAnchor),
            darkCoverView.leadingAnchor.constraint(equalTo: redView.leadingAnchor),
            darkCoverView.bottomAnchor.constraint(equalTo: redView.bottomAnchor),
            darkCoverView.trailingAnchor.constraint(equalTo: redView.trailingAnchor)
        ])
        addChild(homeTVC)
        addChild(menuTVC)
    }
}
