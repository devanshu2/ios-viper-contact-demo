//
//  ContactListPresenter.swift
//  ContactDemo
//
//  Created by Devanshu Saini on 11/07/20.
//  Copyright © 2020 Devanshu Saini. All rights reserved.
//

import Foundation

class ContactListPresenter {
    var interactor: ContactListInteractorProtocol!
    var router: ContactListRouterProtocol?
    weak var outputHandler: ContactListPresenterOutputProtocol?
    
    var users: [User] = []
    
    init(outputHandler: ContactListPresenterOutputProtocol) {
        self.outputHandler = outputHandler
    }
}

extension ContactListPresenter: ContactListPresenterProtocol {
    func getUserCount() -> Int {
        return self.users.count
    }
    
    func getUser(atIndex index: Int) -> User {
        return self.users[index]
    }
    
    func didSelectUser(atIndex index: Int) {
        let user = self.getUser(atIndex: index)
        self.router?.goToDetail(withUser: user)
    }
    
    func fetchUsers() {
        self.interactor?.fetchUsers()
    }
    
    func getTitle() -> String {
        return NSLocalizedString("Contact List", comment: "Contact List")
    }
}

extension ContactListPresenter: ContactListInteractorOutputProtocol {
    func handleUserFetchInteractorOutput(_ interactorResponse: ContactListInteractorUserOutput) {
        switch interactorResponse {
        case .failure(let error):
            self.router?.showErrorAlert(error: error)
        case .success(let users):
            self.users = users
            self.outputHandler?.refreshUserTable()
        }
    }
}

extension ContactListPresenter: ContactListRouterOutputProtocol {
    
}
