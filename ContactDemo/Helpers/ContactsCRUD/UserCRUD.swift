//
//  UserCRUD.swift
//  ContactDemo
//
//  Created by Devanshu Saini on 11/07/20.
//  Copyright © 2020 Devanshu Saini. All rights reserved.
//

import CoreData

class UserCRUD {
    static let shared = UserCRUD()
    
    static let errorDomain = "com.contactdemo.error.usercrud"
    static let userJsonFileNotFound = 1
    static let noUserFound = 1

    private lazy var userPrivateContext = CoreDataController.shared.newPrivateContext()
    
    func flushAndAddUsers(completion: @escaping (Error?) -> ()) {
        self.flushUsers { (flushError) in
            guard flushError == nil else {
                completion(flushError)
                return
            }
            self.addUsers(completion: completion)
        }
    }
    
    func addUsers(completion: @escaping (Error?) -> ()) {
        guard let url = Bundle.main.url(forResource: Constants.userJsonFile, withExtension: Constants.Strings.json) else {
            let error = NSError(domain: UserCRUD.errorDomain, code: UserCRUD.userJsonFileNotFound, userInfo: [NSLocalizedDescriptionKey: "User Json File Not Found"])
            completion(error)
            return
        }
        var caughtError: Error?
        do {
            let json = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            decoder.userInfo[CodingUserInfoKey.context!] = self.userPrivateContext
            do {
                let users = try decoder.decode([User].self, from: json)
                debugPrint("user count added: \(users.count)")
                self.threadUnSafeContextSave()
            }
            catch {
                caughtError = error
                debugPrint(error)
            }
        }
        catch {
            caughtError = error
            debugPrint(error)
        }
        completion(caughtError)
    }
    
    func flushUsers(completion: @escaping (Error?) -> ()) {
        self.userPrivateContext.perform {
            let allUsersFetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: Constants.Entities.user)
            let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: allUsersFetchRequest)
            var caughtError: Error?
            do {
                try self.userPrivateContext.executeAndMergeChanges(using: batchDeleteRequest)
            }
            catch {
                caughtError = error
                debugPrint(error)
            }
            self.threadUnSafeContextSave()
            completion(caughtError)
        }
    }
    
    func fetchAllUsersOnViewContext(completion: @escaping ([User]?, Error?) -> ()) {
        let context = CoreDataController.shared.viewContext
        context.perform {
            let allUsersFetchRequest = NSFetchRequest<User>(entityName: Constants.Entities.user)
            let sort = NSSortDescriptor(key: "name", ascending: true)
            allUsersFetchRequest.sortDescriptors = [sort]
            do {
                let users = try context.fetch(allUsersFetchRequest)
                if users.count > 0 {
                    completion(users, nil)
                }
                else {
                    let error = NSError(domain: UserCRUD.errorDomain, code: UserCRUD.noUserFound, userInfo: [NSLocalizedDescriptionKey: "No user found"])
                    completion(nil, error)
                }
            }
            catch {
                debugPrint(error)
                completion(nil, error)
            }
        }
    }
    
    private func threadUnSafeContextSave() {
        if self.userPrivateContext.hasChanges {
            do {
                try self.userPrivateContext.save()
            }
            catch {
                debugPrint(error)
            }
        }
        else {
            debugPrint("nothing to save")
        }
    }
}
