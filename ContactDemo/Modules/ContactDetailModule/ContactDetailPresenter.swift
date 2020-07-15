//
//  ContactDetailPresenter.swift
//  ContactDemo
//
//  Created by Devanshu Saini on 11/07/20.
//  Copyright © 2020 Devanshu Saini. All rights reserved.
//

import Foundation

class ContactDetailPresenter: ContactDetailPresenterProtocol {
    var user: User!
    var interactor: ContactDetailInteractorProtocol!
    var router: ContactDetailRouterProtocol?
    weak var outputHandler: ContactDetailPresenterOutputProtocol?
    
    init(outputHandler: ContactDetailPresenterOutputProtocol) {
        self.outputHandler = outputHandler
    }
    
    func getTitle() -> String? {
        return self.user.name
    }
}

extension ContactDetailPresenter: ContactDetailInteractorOutputProtocol {
    
}

extension ContactDetailPresenter: ContactDetailRouterOutputProtocol {
    
}
