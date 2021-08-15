//
//  DownloadedReposScreenController.swift
//  3205team
//
//  Created by Алексей Муренцев on 15.08.2021.
//

import UIKit

final class DownloadedReposScreenController: UIViewController {
    
    // MARK: - Private properties
    
    private let mainView = SearchUserScreenView()
    private let dataManager = CoreDataManager()
    private var data: [Rep] = []
    
    // MARK: - Life cycle
    
    override func loadView() {
        super.loadView()
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegates()
        mainView.searchTableView.tableHeaderView = nil
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateList()
    }
    
    // MARK: - Private Methods
    
    func updateList() {
        if let repos = dataManager.getRepos() {
            data.removeAll()
            data = repos
            DispatchQueue.main.async {
                self.mainView.searchTableView.reloadData()
            }
        }
    }
    
    func setDelegates() {
        mainView.searchTableView.dataSource = self
    }
}

//MARK: - UITableViewDataSource

extension DownloadedReposScreenController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SearchUserScreenTableViewCell
        cell.currentData = data[indexPath.row].name
        cell.hideButton = true
        return cell
    }
}
