//
//  CoreDataController.swift
//  ContactDemo
//
//  Created by Devanshu Saini on 11/07/20.
//  Copyright © 2020 Devanshu Saini. All rights reserved.
//

import Foundation
import CoreData

typealias ContextSaveOperationCallback = ((_ error : Error?) -> ())

/// `CoreDataController` is a simple wrapper class for setting up
/// and using a Core Data stack.
///
/// Warning: Requires iOS 10 as it depends on the availability of
/// `NSPersistentContainer`.

@available(iOS 10.0, macOS 10.12, watchOS 3.0, tvOS 10.0, *)
final class CoreDataController: NSObject {

    static let dbFileName = "ContactDemo"
        
    /// The default directory for the persistent stores on the current platform.
    ///
    /// - Returns: An `NSURL` for the directory containing the persistent
    ///   store(s). If the persistent store does not exist it will be created
    ///   by default in this location when loaded.

    class func defaultDirectoryURL() -> URL {
        return NSPersistentContainer.defaultDirectoryURL()
    }

    /// A read-only flag indicating if the persistent store is loaded.

    private (set) var isStoreLoaded = false

    /// The managed object context associated with the main queue (read-only).
    /// To perform tasks on a private background queue see
    /// `performBackgroundTask:` and `newPrivateContext`.
    ///
    /// The context is configured to be generational and to automatically
    /// consume save notifications from other contexts.

    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    /// The `URL` of the persistent store for this Core Data Stack. If there
    /// is more than one store this property returns the first store it finds.
    /// The store may not yet exist. It will be created at this URL by default
    /// when first loaded.
    ///
    /// This is a readonly property to create a persistent store in a different
    /// location use `loadStoreAtURL:withCompletionHandler`. To move an existing
    ///  persistent store use
    /// `replacePersistentStoreAtURL:withPersistentStoreFromURL:`.

    var storeURL: URL? {
        var url: URL?
        let descriptions = persistentContainer.persistentStoreDescriptions
        if let firstDescription = descriptions.first {
            url = firstDescription.url
        }
        return url
    }

    /// A flag that indicates whether this store is read-only. Set this value
    /// to YES before loading the persistent store if you want a read-only
    /// store (for example if loading from the application bundle).
    /// Default is false.

    var isReadOnly = false

    /// A flag that indicates whether the store is added asynchronously.
    /// Set this value before loading the persistent store.
    /// Default is true.

    var shouldAddStoreAsynchronously = true

    /// A flag that indicates whether the store should be migrated
    /// automatically if the store model version does not match the
    /// coordinators model version.
    /// Set this value before loading the persistent store.
    /// Default is true.

    var shouldMigrateStoreAutomatically = true

    /// A flag that indicates whether a mapping model should be inferred
    /// when migrating a store.
    /// Set this value before loading the persistent store.
    /// Default is true.

    var shouldInferMappingModelAutomatically = true

    /// Creates and returns a `CoreDataController` object. This is the designated
    /// initializer for the class. It creates the managed object model,
    /// persistent store coordinator and main managed object context but does
    /// not load the persistent store.
    ///
    /// The managed object model should be in the same bundle as this class.
    ///
    /// - Parameter name: The name of the persistent store.
    ///
    /// - Returns: A `CoreDataController` object or nil if the model
    ///   could not be loaded.
    
    static let shared = CoreDataController()

    private var persistentContainer: NSPersistentContainer!
    
    func initializeStack(completion: @escaping (Error?) -> ()) {
        let bundle = Bundle(for: CoreDataController.self)
        if let mom = NSManagedObjectModel.mergedModel(from: [bundle]) {
            self.persistentContainer = NSPersistentContainer(name: CoreDataController.dbFileName, managedObjectModel: mom)
        }
        if self.persistentContainer == nil {
            self.persistentContainer = NSPersistentContainer(name: CoreDataController.dbFileName)
        }
        self.loadStore { (error) in
            if let er = error {
                debugPrint(er)
                completion(error)
            }
            else {
                completion(nil)
            }
        }
    }
    
    func getManagedModel()->NSManagedObjectModel? {
        return self.persistentContainer.managedObjectModel
    }
    
    func getPersistentStoreCoordinator()->NSPersistentStoreCoordinator {
        return self.persistentContainer.persistentStoreCoordinator
    }

    /// Load the persistent store from the default location.
    ///
    /// - Parameter handler: This handler block is executed on the calling
    ///   thread when the loading of the persistent store has completed.
    ///
    /// To override the default name and location of the persistent store use
    /// `loadStoreAtURL:withCompletionHandler:`.

    func loadStore(completionHandler: @escaping (Error?) -> Void) {
        loadStore(storeURL: storeURL, completionHandler: completionHandler)
    }

    /// Load the persistent store from a specified location
    ///
    /// - Parameter storeURL: The URL for the location of the persistent
    ///   store. It will be created if it does not exist.
    /// - Parameter handler: This handler block is executed on the calling
    ///   thread when the loading of the persistent store has completed.

    func loadStore(storeURL: URL?, completionHandler: @escaping (Error?) -> Void) {
        if let storeURL = storeURL ?? self.storeURL {
            let description = storeDescription(with: storeURL)
            persistentContainer.persistentStoreDescriptions = [description]
        }

        persistentContainer.loadPersistentStores { (storeDescription, error) in
            if error == nil {
                self.isStoreLoaded = true
                self.persistentContainer.viewContext.automaticallyMergesChangesFromParent = true
                self.persistentContainer.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
                debugPrint("DB Load Success")
            }
            else {
                debugPrint("DB Load Error: \(error!)")
            }

            DispatchQueue.main.async {
                completionHandler(error)
            }
        }
    }

    /// A flag indicating if the persistent store exists at the specified URL.
    ///
    /// - Parameter storeURL: An `NSURL` object for the location of the
    ///   peristent store.
    ///
    /// - Returns: true if a file exists at the specified URL otherwise false.
    ///
    /// - Warning: This method checks if a file exists at the specified
    ///   location but does not verify if it is a valid persistent store.

    func persistentStoreExists(at storeURL: URL) -> Bool {
        if storeURL.isFileURL &&
            FileManager.default.fileExists(atPath: storeURL.path) {
            return true
        }
        return false
    }

    /// Destroy a persistent store.
    ///
    /// - Parameter storeURL: An `NSURL` for the persistent store to be
    ///   destroyed.
    /// - Returns: A flag indicating if the operation was successful.
    /// - Throws: If the store cannot be destroyed.

    func destroyPersistentStore(at storeURL: URL) throws {
        let psc = persistentContainer.persistentStoreCoordinator
        try psc.destroyPersistentStore(at: storeURL, ofType: NSSQLiteStoreType, options: nil)
    }

    /// Replace a persistent store.
    ///
    /// - Parameter destinationURL: An `NSURL` for the persistent store to be
    ///   replaced.
    /// - Parameter sourceURL: An `NSURL` for the source persistent store.
    /// - Returns: A flag indicating if the operation was successful.
    /// - Throws: If the persistent store cannot be replaced.

    func replacePersistentStore(at url: URL, withPersistentStoreFrom sourceURL: URL) throws {
        let psc = persistentContainer.persistentStoreCoordinator
        try psc.replacePersistentStore(at: url, destinationOptions: nil,
            withPersistentStoreFrom: sourceURL, sourceOptions: nil, ofType: NSSQLiteStoreType)
    }

    /// Create and return a new private queue `NSManagedObjectContext`. The
    /// new context is set to consume `NSManagedObjectContextSave` broadcasts
    /// automatically.
    ///
    /// - Returns: A new private managed object context

    func newPrivateContext() -> NSManagedObjectContext {
        let context = persistentContainer.newBackgroundContext()
        context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        context.automaticallyMergesChangesFromParent = true
        context.undoManager = nil
        return context
    }

    /// Execute a block on a new private queue context.
    ///
    /// - Parameter block: A block to execute on a newly created private
    ///   context. The context is passed to the block as a parameter.

    func performBackgroundTask(block: @escaping (NSManagedObjectContext) -> Void) {
        persistentContainer.performBackgroundTask(block)
    }

    /// Return an object ID for the specified URI representation if a matching
    /// store is available.
    ///
    /// - Parameter storeURL: An `NSURL` containing a URI of a managed object.
    /// - Returns: An optional `NSManagedObjectID`.

    func managedObjectID(forURIRepresentation storeURL: URL) -> NSManagedObjectID? {
        let psc = persistentContainer.persistentStoreCoordinator
        return psc.managedObjectID(forURIRepresentation: storeURL)
    }

    private func storeDescription(with url: URL) -> NSPersistentStoreDescription {
        let description = NSPersistentStoreDescription(url: url)
        description.shouldMigrateStoreAutomatically = shouldMigrateStoreAutomatically
        description.shouldInferMappingModelAutomatically = shouldInferMappingModelAutomatically
        description.shouldAddStoreAsynchronously = shouldAddStoreAsynchronously
        description.isReadOnly = isReadOnly
        return description
    }
    
    func resetStack(_ doInit:Bool = true, completion: @escaping () -> ()) {
        if self.isStoreLoaded == false {
            self.loadStore { (error1) in
                if let er1 = error1 as NSError?, (self.isStoreLoaded == false || er1.code != 134081)  {
                    self.loadStore { (error2) in
                        if let er2 = error2 as NSError?, (self.isStoreLoaded == false || er2.code != 134081)  {
                            //unable to load store
                            completion()
                        }
                        else {
                            self.resetNextStep(doInit, completion: completion)
                        }
                    }
                }
                else {
                    self.resetNextStep(doInit, completion: completion)
                }
            }
        }
        else {
            self.resetNextStep(doInit, completion: completion)
        }
    }
    
    private func resetNextStep(_ doInit: Bool, completion: @escaping () -> ()) {
        let stores = self.persistentContainer.persistentStoreCoordinator.persistentStores
        for store in stores {
            if let url = store.url {
                do {
                    try self.destroyPersistentStore(at: url)
                    debugPrint("STORE DESTROYED: \(url)")
                }
                catch {
                    debugPrint("STORE UNABLE TO DESTROY: \(error.localizedDescription)")
                }
            }
        }
        self.isStoreLoaded = false
        if doInit {
            self.initializeStack { (_) in
                completion()
            }
        }
        else {
            completion()
        }
    }
    
    
    static func save(context: NSManagedObjectContext, async: Bool = true, completion: ContextSaveOperationCallback? = nil) {
        guard CoreDataController.shared.isStoreLoaded else {
            completion?(nil)
            return
        }
        
        func lambda(context: NSManagedObjectContext, completion: ContextSaveOperationCallback? = nil) {
            if context.hasChanges {
                do {
                    try context.save()
                    completion?(nil)
                }
                catch {
                    debugPrint("ERROR: Was not able to save objects. \(error)")
                    completion?(error)
                }
            }
            else {
                completion?(nil)
            }
        }
        
        if async {
            context.perform {
                lambda(context: context, completion: completion)
            }
        }
        else {
            context.performAndWait {
                lambda(context: context, completion: completion)
            }
        }
    }
    
    static func resetCoreData(completion: @escaping (() -> Void)) {
        CoreDataController.save(context: CoreDataController.shared.viewContext) { (_) in
            debugPrint("trial for reset")
            CoreDataController.shared.resetStack(true) {
                completion()
            }
        }
    }
}
