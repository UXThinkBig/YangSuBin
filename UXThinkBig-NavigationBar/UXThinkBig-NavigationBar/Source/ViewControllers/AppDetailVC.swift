//
//  AppDetailVC.swift
//  UXThinkBig-NavigationBar
//
//  Created by 양수빈 on 2021/10/28.
//

import UIKit

import SnapKit

class AppDetailVC: UIViewController {
    
    // MARK: - Properties
    let tableView = UITableView()
    let installButton = UIButton()

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self

        configUI()
        setupLayout()
        registerXib()
    }
    
    func registerXib() {
        tableView.register(AppDetailTVC.self, forCellReuseIdentifier: AppDetailTVC.identifier)
    }
    
    // MARK: - Custom method
    func configUI() {
        title = nil
        navigationItem.largeTitleDisplayMode = .never
        
        installButton.setImage(UIImage(systemName: "icloud.and.arrow.down"), for: .normal)
        
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
    }
    
    func setupLayout() {
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(topLayoutGuide.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    func startAnimation() {
        let fadeTextAnimation = CATransition()
        fadeTextAnimation.duration = 0.2
        fadeTextAnimation.type = .fade
            
        navigationController?.navigationBar.layer.add(fadeTextAnimation, forKey: "fadeText")

        UIView.animate(withDuration: 0.4, delay: 0) {
            self.navigationItem.titleView?.alpha = 1
            self.navigationItem.rightBarButtonItem?.customView?.alpha = 1
        }
    }
    
    func endAnimation() {
        navigationItem.titleView?.alpha = 0
        navigationItem.rightBarButtonItem?.customView?.alpha = 0
    }
}

// MARK: - UITableViewDelegate
extension AppDetailVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if tableView.bounds.minY > 30 {
            let logo = UIImageView(image: UIImage(named: "karrotLogo"))
            navigationItem.titleView = logo
            navigationItem.rightBarButtonItem = UIBarButtonItem(customView: installButton)
            /// titleView 보이기
            startAnimation()
        } else {
            /// titleView 안보이기
            endAnimation()
        }
    }
}

// MARK: - UITableViewDataSource
extension AppDetailVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 5
        case 2:
            return 5
        default:
            return 0
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: AppDetailTVC.identifier) as? AppDetailTVC else {return UITableViewCell()}
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
}
