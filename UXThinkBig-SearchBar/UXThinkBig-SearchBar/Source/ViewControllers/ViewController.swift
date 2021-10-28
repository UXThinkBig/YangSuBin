//
//  ViewController.swift
//  UXThinkBig-SearchBar
//
//  Created by 양수빈 on 2021/10/19.
//

import UIKit

import SnapKit

class ViewController: UIViewController, UISearchBarDelegate {
    // MARK: - Properties
    let backgroundView = UIView()
    let searchBar = UISearchBar()
    let searchController = UISearchController(searchResultsController: nil)
    let image = UIImage()
    let tableView = UITableView()
    
    let firstSectionItems : [String] = ["사람 찾아보기", "채널 탐색"]
    var sections : [String] = ["", "최근 검색", "검색 범위 좁히기"]
    var allSearch: [String] = ["삭제", "token", "다른 캐츄 구경하기", "hoho", "splash", "토큰", "토큰좀", "토큰어딨어"]
    var recentSearch : [String] = ["삭제", "token", "다른 캐츄 구경하기", "hoho", "splash"]
    var filteredSearch : [String] = []
    let shortItems : [String] = ["from:", "은(는):", "after:", "in:"]
    
    var isTyping : Bool?

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configUI()
        setupLayout()
        hideKeyboardWhenTappedAround()
    }

    // MARK: - Custom Method
    func configUI() {
        searchBar.delegate = self
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(CustomTVC.self, forCellReuseIdentifier: "CustomTVC")
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        
//        searchController.searchBar.tintColor = .purple
//        searchController.searchBar.placeholder = "메시지 및 파일 검색"
//        searchController.searchBar.backgroundImage = image
        searchBar.tintColor = .purple
        searchBar.placeholder = "메시지 및 파일 검색"
        searchBar.backgroundImage = image
        
//        tableView.tableHeaderView = searchController.searchBar
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
//        searchController.searchBar.sizeToFit()
        
        backgroundView.backgroundColor = .white
    }
    
    func setupLayout() {
        view.addSubview(tableView)
        view.addSubview(backgroundView)
        view.addSubview(searchBar)
        
        backgroundView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(120)
        }
        
        searchBar.snp.makeConstraints { make in
            make.bottom.equalTo(backgroundView.snp.bottom)
            make.leading.trailing.equalToSuperview().inset(10)
        }
    
        tableView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(120)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    func tableViewAnimation(_ tableView: UITableView) {
//        self.tableView.beginUpdates()
//        self.tableView.deleteRows(at: [IndexPath(row: 0, section: 1)], with: .automatic)
//        self.tableView.endUpdates()
        
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseInOut, animations: {
            let frame = CGAffineTransform(translationX: 0, y: -100)
            self.tableView.transform = frame
        }, completion: nil)
    }
    
    func resetTableViewAnimation(_ tableView: UITableView) {
//        self.tableView.beginUpdates()
//        self.tableView.insertRows(at: [IndexPath(row: 2, section: 0)], with: .none)
//        self.tableView.endUpdates()
        
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseInOut, animations: {
            let frame = CGAffineTransform(translationX: 0, y: 0)
            self.tableView.transform = frame
        }, completion: nil)
    }

    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.setShowsCancelButton(true, animated: true)
        let cancelButton = searchBar.value(forKey: "cancelButton") as! UIButton
        cancelButton.setTitle("취소", for: .normal)
        
        tableViewAnimation(tableView)
        isTyping = false
        
        return true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        self.hideKeyboard()
        searchBar.setShowsCancelButton(false, animated: true)
        resetTableViewAnimation(tableView)
        isTyping = false
        recentSearch = ["삭제", "token", "다른 캐츄 구경하기", "hoho", "splash"]
        tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.hideKeyboard()
        isTyping = false
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.hideKeyboard()
        searchBar.text = ""
        recentSearch = ["삭제", "token", "다른 캐츄 구경하기", "hoho", "splash"]
        print("Cancel")
        tableView.reloadData()
    }
}

// MARK: - extension
extension ViewController: UITableViewDelegate {
    
}

extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 1:
            return sections[1]
        case 2:
            return sections[2]
        default:
            return sections[0]
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0 :
            return firstSectionItems.count
        case 1:
            return recentSearch.count
        case 2:
            return shortItems.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomTVC.identifier, for: indexPath) as? CustomTVC else { return UITableViewCell() }
        
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                cell.iconImageView.image = UIImage(systemName: "person")
            } else {
                cell.iconImageView.image = UIImage(systemName: "tv")
            }
            cell.titleLabel.text = "\(firstSectionItems[indexPath.item])"

        } else if indexPath.section == 1 {
            cell.iconImageView.image = UIImage(systemName: "clock")
            cell.titleLabel.text = "\(recentSearch[indexPath.row])"

        } else if indexPath.section == 2 {
            cell.iconImageView.image = UIImage(systemName: "plus.square")
            cell.titleLabel.text = "\(shortItems[indexPath.item])"

        } else {
            return UITableViewCell()
        }
        
        return cell
    }
}

extension ViewController: UISearchResultsUpdating {
    
    func filteredContentForSearchText(_ searchText: String) {
        recentSearch = allSearch.filter({ (recent) -> Bool in
            return recent.lowercased().contains(searchText.lowercased()) || recent.lowercased().contains(searchText.lowercased())
        })
        tableView.reloadData()
        print("reload되었다")
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        filteredContentForSearchText(searchBar.text ?? "")
    }
    
    
}

extension UIViewController
{
    func hideKeyboard()
    {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard()
    {
        view.endEditing(true)
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
}
