//
//  SearchUserScreenController.swift
//  3205team
//
//  Created by Алексей Муренцев on 11.08.2021.
//

import UIKit
import SafariServices

final class SearchUserScreenController: UIViewController {
    
    // MARK: - Private properties
    
    private let mainView = SearchUserScreenView()
    private let service = GitService()
    private let manager = CoreDataManager()
    private var data: [Repository] = []
    
    // MARK: - Life cycle
    
    override func loadView() {
        super.loadView()
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegates()
    }
    
    // MARK: - Private Methods
    
    private func setDelegates() {
        let headerView = mainView.searchTableView.tableHeaderView as? SearchUserScreenTableViewHeader
        headerView?.searchBar.delegate = self
        mainView.searchTableView.delegate = self
        mainView.searchTableView.dataSource = self
    }
    
    private func presentSafari(with link: String) {
        guard let url = URL(string: link) else { return }
        let safariVC = SFSafariViewController(url: url)
        self.present(safariVC, animated: true, completion: nil)
    }
    
    private func downloadRepository(repositoryName: String, htmlURL: String) {
        service.download(repositoryName: repositoryName) { [weak self] localURL in
            self?.manager.saveDownloadedRep(name: repositoryName, localURL: localURL, htmlURL: htmlURL, completion: { result in
                print("Download to folder: \(localURL)")
                DispatchQueue.main.async {
                    self?.mainView.searchTableView.reloadData()
                }
            })
        }
    }
}

// MARK: - UITableViewDelegate

extension SearchUserScreenController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presentSafari(with: data[indexPath.row].html_url)
    }
}

//MARK: - UITableViewDataSource

extension SearchUserScreenController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SearchUserScreenTableViewCell
        let rep = self.data[indexPath.row]
        cell.currentData = rep.name
        cell.isDownloaded = manager.checkRepDownloaded(name: rep.full_name)
        cell.downloadAction = {
            self.downloadRepository(repositoryName: rep.full_name, htmlURL: rep.html_url)
        }
        return cell
    }
}

//MARK: - UISearchBarDelegate

extension SearchUserScreenController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.data.removeAll()
        DispatchQueue.main.async {
            self.mainView.searchTableView.reloadData()
        }
        if !searchText.isEmpty {
            service.getRepositories(forUser: searchText) {[weak self] response in
                self?.data = response
                DispatchQueue.main.async {
                    self?.mainView.searchTableView.reloadData()
                }
            }
        }
    }
}
