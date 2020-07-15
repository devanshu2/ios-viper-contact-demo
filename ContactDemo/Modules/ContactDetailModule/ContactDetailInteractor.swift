//
//  ContactDetailInteractor.swift
//  ContactDemo
//
//  Created by Devanshu Saini on 11/07/20.
//  Copyright © 2020 Devanshu Saini. All rights reserved.
//

import Foundation

class ContactDetailInteractor {
    weak var outputHandler: ContactDetailInteractorOutputProtocol?
    
    init(outputHandler: ContactDetailInteractorOutputProtocol) {
        self.outputHandler = outputHandler
    }
}

extension ContactDetailInteractor: ContactDetailInteractorProtocol {
    
}
