//
//  SearchUserScreenTableViewHeader.swift
//  3205team
//
//  Created by Алексей Муренцев on 12.08.2021.
//

import UIKit

final class SearchUserScreenTableViewHeader: UIView {
    
    public let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.placeholder = "user name"
        return searchBar
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setConstraints() {
        addSubview(searchBar)
        
        //-- MainScrollView
        NSLayoutConstraint.activate([
            searchBar.leftAnchor.constraint(equalTo: leftAnchor),
            searchBar.rightAnchor.constraint(equalTo: rightAnchor),
            searchBar.topAnchor.constraint(equalTo: topAnchor),
            searchBar.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
    }
}
