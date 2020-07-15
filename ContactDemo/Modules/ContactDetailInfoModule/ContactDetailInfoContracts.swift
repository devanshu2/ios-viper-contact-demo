//
//  ContactDetailInfoContracts.swift
//  ContactDemo
//
//  Created by Devanshu Saini on 11/07/20.
//  Copyright © 2020 Devanshu Saini. All rights reserved.
//

import Foundation

protocol ContactDetailInfoPresenterOutputProtocol: class {
    
}

protocol ContactDetailInfoInteractorOutputProtocol: class {
    
}

protocol ContactDetailInfoInteractorProtocol: class {
    func getUserInfoLines(user: User) -> [TitleDescription]
}

protocol ContactDetailInfoRouterProtocol: class {
    
}

protocol ContactDetailInfoPresenterProtocol: class {
    var user: User! { get set }
    func getUserInfoLines() -> [TitleDescription]
}

protocol ContactDetailInfoRouterOutputProtocol: class {
    
}
