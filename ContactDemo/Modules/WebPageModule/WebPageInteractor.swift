//
//  WebPageInteractor.swift
//  ContactDemo
//
//  Created by Devanshu Saini on 11/07/20.
//  Copyright © 2020 Devanshu Saini. All rights reserved.
//

import Foundation

class WebPageInteractor {
    weak var outputHandler: WebPageInteractorOutputProtocol?
    
    init(outputHandler: WebPageInteractorOutputProtocol) {
        self.outputHandler = outputHandler
    }
}

extension WebPageInteractor: WebPageInteractorProtocol {
    
}
