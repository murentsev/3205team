//
//  GitService.swift
//  3205team
//
//  Created by Алексей Муренцев on 12.08.2021.
//

import Foundation

final class GitService {
    
    // MARK: - Public properties
    
    public let startingURL: String = "https://rawgit.com/NikitaAsabin/799e4502c9fc3e0ea7af439b2dfd88fa/raw/7f5c6c66358501f72fada21e04d75f64474a7888/page1.json"
    
    // MARK: - Public methods
    
    public func getRepositories(forUser userName: String,
                                completion: @escaping ([Repository]) -> Void) {
        if let url = URL(string: "https://api.github.com/users/\(userName)/repos") {
            let urlSession = URLSession(configuration: .default).dataTask(with: url) { (data, response, error) in
                if let data = data {
                    let decoder = JSONDecoder()
                    do {
                        let fileData = try decoder.decode([Repository].self, from: data)
                        completion(fileData)
                    } catch let error as NSError {
                        print(error.localizedDescription)
                    }
                }
            }
            urlSession.resume()
        }
    }
    
    public func download(repositoryName: String,
                                completion: @escaping (String) -> Void) {
        if let url = URL(string: "https://api.github.com/repos/\(repositoryName)/zipball") {
            let downloadTask = URLSession.shared.downloadTask(with: url) { fileURL , response, error in
                guard let fileURL = fileURL else { return }
                do {
                    let documentsURL = try
                        FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
                    let savedURL = documentsURL.appendingPathComponent("Download/\(repositoryName).zip")
                    var savedPath = savedURL
                    savedPath.deleteLastPathComponent()
                    let nameThemePath = savedPath.relativePath
                    self.createDirectoryIfNeeded(for: nameThemePath)
                    try FileManager.default.moveItem(at: fileURL, to: savedURL)
                    completion(savedURL.relativePath)
                } catch {
                    print(error.localizedDescription)
                }
            }
            downloadTask.resume()
        }
    }
    
    //MARK: - Private methods
    
    private func createDirectoryIfNeeded(for path: String) {
        if !FileManager.default.fileExists(atPath: path) {
            do {
                try FileManager.default.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: [:])
            } catch {
                print(error.localizedDescription)
            }
        }
    }
  
}

