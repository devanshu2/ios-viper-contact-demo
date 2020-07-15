//
//  ContactListInteractor.swift
//  ContactDemo
//
//  Created by Devanshu Saini on 11/07/20.
//  Copyright © 2020 Devanshu Saini. All rights reserved.
//

import Foundation

class ContactListInteractor {
    weak var outputHandler: ContactListInteractorOutputProtocol?
    
    init(outputHandler: ContactListInteractorOutputProtocol) {
        self.outputHandler = outputHandler
    }
}

extension ContactListInteractor: ContactListInteractorProtocol {
    func fetchUsers() {
        UserCRUD.shared.fetchAllUsersOnViewContext { [weak self] (users, error) in
            guard let `self` = self else { return }
            if let users = users {
                self.outputHandler?.handleUserFetchInteractorOutput(ContactListInteractorUserOutput.success(users: users))
            }
            else if let error = error {
                self.outputHandler?.handleUserFetchInteractorOutput(ContactListInteractorUserOutput.failure(error: error))
            }
        }
    }
}
