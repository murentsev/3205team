//
//  SearchUserScreenTableViewCell.swift
//  3205team
//
//  Created by Алексей Муренцев on 12.08.2021.
//

import UIKit

final class SearchUserScreenTableViewCell: UITableViewCell {
    
    // MARK: - Public Properties
    
    public var currentData: String? {
        didSet {
            guard let data = currentData else { return }
            repositoryName.text = data
        }
    }
    
    public var hideButton: Bool = false {
        didSet {
            if hideButton {
                repositoryButton.isHidden = true
            }
        }
    }
    
    public var isDownloaded: Bool = false {
        didSet {
            if isDownloaded {
                UIView.transition(with: repositoryButton,
                                  duration: 0.3,
                                  options: .transitionCrossDissolve,
                                  animations: {
                                    self.repositoryButton.setImage(
                                        UIImage(systemName: "folder.circle"),
                                        for: .normal
                                    )
                                  },
                                  completion: nil)
            }
        }
    }
    
    public var downloadAction: (() -> Void)? = nil
    
    // MARK: - Views
    
    private let repositoryName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var repositoryButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.imageView?.contentMode = .scaleAspectFit
        button.tintColor = .black
        button.setImage(UIImage(systemName: "arrow.down.circle"), for: .normal)
        button.addTarget(self, action: #selector(downloadButtonAction), for: .touchUpInside)
        button.isUserInteractionEnabled = true
        return button
    }()

    // MARK: - Initializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    
    @objc private func downloadButtonAction() {
        downloadAction?()
    }
    
    private func setConstraints() {
        addSubview(repositoryName)
        contentView.addSubview(repositoryButton)
        
        NSLayoutConstraint.activate([
            repositoryName.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            repositoryName.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            repositoryButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -15),
            repositoryButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            repositoryButton.heightAnchor.constraint(equalTo: heightAnchor),
            repositoryButton.widthAnchor.constraint(equalTo: heightAnchor)
        ])
    }
  
}


