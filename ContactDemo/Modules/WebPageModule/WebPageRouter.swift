//
//  WebPageRouter.swift
//  ContactDemo
//
//  Created by Devanshu Saini on 11/07/20.
//  Copyright © 2020 Devanshu Saini. All rights reserved.
//

import UIKit

class WebPageRouter {
    weak var delegate: WebPageRouterOutputProtocol?

    init(delegate: WebPageRouterOutputProtocol) {
        self.delegate = delegate
    }
}

extension WebPageRouter: WebPageRouterProtocol {
    
}
