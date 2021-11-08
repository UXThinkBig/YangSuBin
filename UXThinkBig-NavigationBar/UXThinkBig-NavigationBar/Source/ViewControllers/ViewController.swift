//
//  ViewController.swift
//  UXThinkBig-NavigationBar
//
//  Created by 양수빈 on 2021/10/28.
//

import UIKit

import SnapKit

class ViewController: UIViewController {
    
    // MARK: - Properties
    let appTitleLabel = UILabel()
    let appIconButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configUI()
        setupLayout()
        setupAddTarget()
    }

    // MARK: - Custom Method
    func configUI() {
        appTitleLabel.text = "당근마켓"
        appIconButton.setImage(UIImage(named: "karrotIcon"), for: .normal)
        
        title = "앱"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func setupLayout() {
        view.addSubview(appTitleLabel)
        view.addSubview(appIconButton)
        
        appTitleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(appIconButton.snp.bottom).offset(12)
        }
        
        appIconButton.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(100)
        }
    }
    
    func setupAddTarget() {
        appIconButton.addTarget(self, action: #selector(touchupAppIcon), for: .touchUpInside)
    }
    
    // MARK: - @objc
    @objc func touchupAppIcon() {
        guard let vc = storyboard?.instantiateViewController(identifier: "AppDetailVC") as? AppDetailVC else { return }
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

