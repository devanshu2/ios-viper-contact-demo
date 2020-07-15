//
//  ContactDetailInfoInteractor.swift
//  ContactDemo
//
//  Created by Devanshu Saini on 11/07/20.
//  Copyright © 2020 Devanshu Saini. All rights reserved.
//

import Foundation

class ContactDetailInfoInteractor {
    weak var outputHandler: ContactDetailInfoInteractorOutputProtocol?
    
    init(outputHandler: ContactDetailInfoInteractorOutputProtocol) {
        self.outputHandler = outputHandler
    }
}

extension ContactDetailInfoInteractor: ContactDetailInfoInteractorProtocol {
    func getUserInfoLines(user: User) -> [TitleDescription] {
        var items = [TitleDescription]()
        if let name = user.name {
            items.append(TitleDescription(title: NSLocalizedString("Name", comment: "Name"), description: name))
        }
        if let email = user.email {
            items.append(TitleDescription(title: NSLocalizedString("Email", comment: "Email"), description: email))
        }
        if let phone = user.phone {
            items.append(TitleDescription(title: NSLocalizedString("Phone", comment: "Phone"), description: phone))
        }
        return items
    }
}
