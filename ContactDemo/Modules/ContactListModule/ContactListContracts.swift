//
//  ContactListContracts.swift
//  ContactDemo
//
//  Created by Devanshu Saini on 11/07/20.
//  Copyright © 2020 Devanshu Saini. All rights reserved.
//

import Foundation

protocol ContactListPresenterOutputProtocol: class {
    func refreshUserTable()
}

enum ContactListInteractorUserOutput {
    case success(users: [User])
    case failure(error: Error)
}

protocol ContactListInteractorOutputProtocol: class {
    func handleUserFetchInteractorOutput(_ interactorResponse: ContactListInteractorUserOutput)
}

protocol ContactListInteractorProtocol: class {
    func fetchUsers()
}

protocol ContactListRouterProtocol: class {
    func goToDetail(withUser user: User)
    func showErrorAlert(error: Error)
}

protocol ContactListPresenterProtocol: class {
    func getUserCount() -> Int
    
    func getUser(atIndex index: Int) -> User
    
    func didSelectUser(atIndex index: Int)
    
    func fetchUsers()
    
    func getTitle() -> String
}

protocol ContactListRouterOutputProtocol: class {
    
}
