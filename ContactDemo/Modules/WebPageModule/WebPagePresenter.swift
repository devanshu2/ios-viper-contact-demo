//
//  WebPagePresenter.swift
//  ContactDemo
//
//  Created by Devanshu Saini on 11/07/20.
//  Copyright © 2020 Devanshu Saini. All rights reserved.
//

import Foundation

class WebPagePresenter: WebPagePresenterProtocol {
    var interactor: WebPageInteractorProtocol!
    var router: WebPageRouterProtocol?
    weak var outputHandler: WebPagePresenterOutputProtocol?
    
    var webPageURLString: String?
    var webPageURL: URL? {
        get {
            if let urlString = self.webPageURLString, let url = URL(string: urlString) {
                return url
            }
            else {
                return nil
            }
        }
    }
    
    init(outputHandler: WebPagePresenterOutputProtocol) {
        self.outputHandler = outputHandler
    }
}

extension WebPagePresenter: WebPageInteractorOutputProtocol {
    
}

extension WebPagePresenter: WebPageRouterOutputProtocol {
    
}
