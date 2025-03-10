import Foundation
import CoreData

public class CoreDataManager {
    public static let shared = CoreDataManager()
    
    private let modelName = "DuskerDataModel"
    
    public lazy var persistentContainer: NSPersistentContainer = {
        // Look for the model in the bundle
        guard let modelURL = Bundle.module.url(forResource: modelName, withExtension: "momd") else {
            // If not found, try to find the xcdatamodeld directly
            guard let modelURL = Bundle.module.url(forResource: modelName, withExtension: "xcdatamodeld") else {
                fatalError("Failed to find Core Data model named \(modelName)")
            }
            
            guard let mom = NSManagedObjectModel(contentsOf: modelURL) else {
                fatalError("Failed to create model from file at \(modelURL)")
            }
            
            let container = NSPersistentContainer(name: modelName, managedObjectModel: mom)
            container.loadPersistentStores { (storeDescription, error) in
                if let error = error as NSError? {
                    fatalError("Unresolved error \(error), \(error.userInfo)")
                }
            }
            container.viewContext.automaticallyMergesChangesFromParent = true
            container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
            return container
        }
        
        guard let mom = NSManagedObjectModel(contentsOf: modelURL) else {
            fatalError("Failed to create model from file at \(modelURL)")
        }
        
        let container = NSPersistentContainer(name: modelName, managedObjectModel: mom)
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        container.viewContext.automaticallyMergesChangesFromParent = true
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        return container
    }()
    
    public var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    // Make init internal so it can be overridden by subclasses in the same module
    internal init() {}
    
    // MARK: - Helper Methods
    
    public func saveContext() {
        let context = viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    // Create a background context for performing operations off the main thread
    public func backgroundContext() -> NSManagedObjectContext {
        let context = persistentContainer.newBackgroundContext()
        context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        return context
    }
} 