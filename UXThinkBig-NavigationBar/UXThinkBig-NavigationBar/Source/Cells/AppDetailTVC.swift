//
//  AppDetailTVC.swift
//  UXThinkBig-NavigationBar
//
//  Created by 양수빈 on 2021/10/30.
//

import UIKit

class AppDetailTVC: UITableViewCell {
    static let identifier = "AppDetailTVC"
    
    // MARK: - Properties
    let logoImageView = UIImageView()
    let titleLabel = UILabel()
    let subTitleLabel = UILabel()
    let installButton = UIButton()
    let shareButton = UIButton()
    let separator = UIView()
    
    // MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configUI()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: - Custom method
    func configUI() {
        logoImageView.image = UIImage(named: "karrotIcon")
        titleLabel.text = "당근마켓 - 대한민국 1등 동네 커뮤니티"
        titleLabel.numberOfLines = 2
        titleLabel.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        
        subTitleLabel.text = "당근당근당근당근"
        subTitleLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        subTitleLabel.textColor = .gray
        subTitleLabel.lineBreakMode = .byTruncatingTail
        
        installButton.setImage(UIImage(systemName: "icloud.and.arrow.down"), for: .normal)
        shareButton.setImage(UIImage(systemName: "square.and.arrow.up"), for: .normal)
        
        separator.backgroundColor = .lightGray.withAlphaComponent(0.2)
    }
    
    func setupLayout() {
        addSubview(logoImageView)
        addSubview(titleLabel)
        addSubview(subTitleLabel)
        addSubview(installButton)
        addSubview(shareButton)
        addSubview(separator)
        
        logoImageView.snp.makeConstraints { make in
            make.top.leading.bottom.equalToSuperview().inset(16)
            make.width.equalTo(120)
            make.height.equalTo(140)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalTo(logoImageView.snp.trailing).offset(16)
            make.trailing.equalToSuperview().inset(16)
        }
        
        subTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.leading.equalTo(titleLabel.snp.leading)
            make.trailing.equalTo(titleLabel.snp.trailing)
        }
        
        installButton.snp.makeConstraints { make in
            make.bottom.equalTo(logoImageView.snp.bottom)
            make.leading.equalTo(titleLabel.snp.leading)
            make.width.height.equalTo(40)
        }
        
        shareButton.snp.makeConstraints { make in
            make.bottom.equalTo(logoImageView.snp.bottom)
            make.trailing.equalTo(titleLabel.snp.trailing)
            make.width.height.equalTo(40)
        }
        
        separator.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview()
            make.height.equalTo(1)
        }
    }
}
