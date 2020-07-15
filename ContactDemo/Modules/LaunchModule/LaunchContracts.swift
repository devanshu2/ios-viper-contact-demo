//
//  LaunchContracts.swift
//  ContactDemo
//
//  Created by Devanshu Saini on 11/07/20.
//  Copyright © 2020 Devanshu Saini. All rights reserved.
//

import UIKit

protocol LaunchPresenterOutputProtocol: class {
    
}

protocol LaunchPresenterProtocol: class {
    func initAndLaunch()
}

enum LaunchInteractorGeneralOutput {
    case success
    case failure(error: Error)
}

protocol LaunchInteractorOutputProtocol: class {
    func handleUserSyncInteractorOutput(_ interactorResponse: LaunchInteractorGeneralOutput)
    func handleCoreDataInitInteractorOutput(_ interactorResponse: LaunchInteractorGeneralOutput)
}

protocol LaunchInteractorProtocol: class {
    func initCoreData()
    func flushAndAddUsers()
}

protocol LaunchRouterProtocol: class {
    func gotoContactList()
    func showErrorAlertAndTakeUserAction(error: Error)
}

protocol LaunchRouterOutputProtocol: class {
    func retryCallOnInitError()
}


