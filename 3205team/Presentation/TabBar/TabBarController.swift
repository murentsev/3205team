//
//  TabBarController.swift
//  3205team
//
//  Created by Алексей Муренцев on 11.08.2021.
//

import UIKit

class TabBarController: UITabBarController {
    
    //MARK: - life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setControllers()
    }
    
    //MARK: - Private properties
    
    private func setControllers() {
        viewControllers = [
            createNavController(for: SearchUserScreenController(), title: "Repositories", image: UIImage(systemName: "magnifyingglass")!),
            createNavController(for: DownloadedReposScreenController(), title: "Downloaded", image: UIImage(systemName: "tray.2.fill")!)
        ]
    }
    
    private func createNavController(for rootViewController: UIViewController,
                                         title: String,
                                         image: UIImage) -> UIViewController {
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        navController.navigationBar.prefersLargeTitles = true
        rootViewController.navigationItem.title = title
        return navController
    }
    
}
