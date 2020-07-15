//
//  ContactDetailInfoPresenter.swift
//  ContactDemo
//
//  Created by Devanshu Saini on 11/07/20.
//  Copyright © 2020 Devanshu Saini. All rights reserved.
//

import Foundation

class ContactDetailInfoPresenter: ContactDetailInfoPresenterProtocol {
    var user: User!
    var interactor: ContactDetailInfoInteractorProtocol!
    var router: ContactDetailInfoRouterProtocol?
    weak var outputHandler: ContactDetailInfoPresenterOutputProtocol?
    
    init(outputHandler: ContactDetailInfoPresenterOutputProtocol) {
        self.outputHandler = outputHandler
    }
    
    func getUserInfoLines() -> [TitleDescription] {
        return self.interactor.getUserInfoLines(user: user)
    }
}

extension ContactDetailInfoPresenter: ContactDetailInfoInteractorOutputProtocol {
    
}

extension ContactDetailInfoPresenter: ContactDetailInfoRouterOutputProtocol {
    
}
