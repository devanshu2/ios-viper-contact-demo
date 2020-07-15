//
//  ContactDetailInfoRouter.swift
//  ContactDemo
//
//  Created by Devanshu Saini on 11/07/20.
//  Copyright © 2020 Devanshu Saini. All rights reserved.
//

import UIKit

class ContactDetailInfoRouter {
    weak var delegate: ContactDetailInfoRouterOutputProtocol?

    init(delegate: ContactDetailInfoRouterOutputProtocol) {
        self.delegate = delegate
    }
}

extension ContactDetailInfoRouter: ContactDetailInfoRouterProtocol {
    
}
