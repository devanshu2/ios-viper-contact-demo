//
//  ContactDetailRouter.swift
//  ContactDemo
//
//  Created by Devanshu Saini on 11/07/20.
//  Copyright © 2020 Devanshu Saini. All rights reserved.
//

import UIKit

class ContactDetailRouter {
    weak var delegate: ContactDetailRouterOutputProtocol?
    weak var navigationController: UINavigationController?

    init(delegate: ContactDetailRouterOutputProtocol, navigationController: UINavigationController?) {
        self.delegate = delegate
        self.navigationController = navigationController
    }
}

extension ContactDetailRouter: ContactDetailRouterProtocol {
    
}
