//
//  ContactDetailContracts.swift
//  ContactDemo
//
//  Created by Devanshu Saini on 11/07/20.
//  Copyright © 2020 Devanshu Saini. All rights reserved.
//

import Foundation

protocol ContactDetailPresenterOutputProtocol: class {
    
}

protocol ContactDetailInteractorOutputProtocol: class {
    
}

protocol ContactDetailInteractorProtocol: class {
    
}

protocol ContactDetailRouterProtocol: class {
    
}

protocol ContactDetailPresenterProtocol: class {
    var user: User! { get set }
    func getTitle() -> String?
}

protocol ContactDetailRouterOutputProtocol: class {
    
}
