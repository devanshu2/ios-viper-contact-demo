//
//  WebPageContracts.swift
//  ContactDemo
//
//  Created by Devanshu Saini on 11/07/20.
//  Copyright © 2020 Devanshu Saini. All rights reserved.
//

import Foundation

protocol WebPagePresenterOutputProtocol: class {
    
}

protocol WebPageInteractorOutputProtocol: class {
    
}

protocol WebPageInteractorProtocol: class {
    
}

protocol WebPageRouterProtocol: class {
    
}

protocol WebPagePresenterProtocol: class {
    var webPageURLString: String? { get set }
    
    var webPageURL: URL? { get }
}

protocol WebPageRouterOutputProtocol: class {
    
}
