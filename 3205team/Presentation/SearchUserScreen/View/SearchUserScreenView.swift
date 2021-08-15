//
//  SearchUserScreenView.swift
//  3205team
//
//  Created by Алексей Муренцев on 11.08.2021.
//

import UIKit

final class SearchUserScreenView: UIView {
    
    // MARK: - Public properties
    
    public let searchTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorColor = UIColor.white.withAlphaComponent(0.1)
        let headerForTable = SearchUserScreenTableViewHeader(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        tableView.tableHeaderView = headerForTable
        tableView.register(SearchUserScreenTableViewCell.self, forCellReuseIdentifier: "Cell")
        return tableView
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        self.setConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private methods
    
    private func setConstraints()  {
        addSubview(searchTableView)
        
        //-- Search table view
        NSLayoutConstraint.activate([
            searchTableView.leftAnchor.constraint(equalTo: leftAnchor),
            searchTableView.rightAnchor.constraint(equalTo: rightAnchor),
            searchTableView.topAnchor.constraint(equalTo: topAnchor),
            searchTableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
}
