//
//  CoreDataManager.swift
//  3205team
//
//  Created by Алексей Муренцев on 15.08.2021.
//

import Foundation
import CoreData

class CoreDataManager {
    
    lazy var viewContext: NSManagedObjectContext = {
        return persistentContainer.viewContext
    }()
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "_205team")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    public func saveDownloadedRep(name: String, localURL: String, htmlURL: String, completion: @escaping (Bool) -> Void) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Rep")
        fetchRequest.predicate = NSPredicate(format: "name = %@", name)
        if let repositories = try? viewContext.fetch(fetchRequest) as? [Rep], !repositories.isEmpty {
            
        } else {
            let repObject = Rep(context: viewContext)
            repObject.name = name
            repObject.localURL = localURL
            repObject.htmlURL = htmlURL
            
            do {
                try viewContext.save()
                completion(true)
            } catch let error {
                print(error.localizedDescription)
            }
        }
    }
    
    public func getRepos() -> [Rep]? {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Rep")
        if let repositories = try? viewContext.fetch(fetchRequest) as? [Rep], !repositories.isEmpty {
            return repositories
        }
        return nil
    }
    
    public func checkRepDownloaded(name: String) -> Bool {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Rep")
        fetchRequest.predicate = NSPredicate(format: "name = %@", name)
        if let repositories = try? viewContext.fetch(fetchRequest) as? [Rep], !repositories.isEmpty {
            return true
        }
        return false
    }
}
