//
//  LaunchPresenter.swift
//  ContactDemo
//
//  Created by Devanshu Saini on 11/07/20.
//  Copyright © 2020 Devanshu Saini. All rights reserved.
//

import UIKit

class LaunchPresenter {
    var interactor: LaunchInteractorProtocol!
    var router: LaunchRouterProtocol?
    weak var outputHandler: LaunchPresenterOutputProtocol?
    
    init(outputHandler: LaunchPresenterOutputProtocol) {
        self.outputHandler = outputHandler
    }
}

extension LaunchPresenter: LaunchInteractorOutputProtocol {
    func handleUserSyncInteractorOutput(_ interactorResponse: LaunchInteractorGeneralOutput) {
        switch interactorResponse {
        case .failure(let error):
            self.router?.showErrorAlertAndTakeUserAction(error: error)
        default:
            DispatchQueue.main.async {
                self.router?.gotoContactList()
            }
        }
    }
    
    func handleCoreDataInitInteractorOutput(_ interactorResponse: LaunchInteractorGeneralOutput) {
        switch interactorResponse {
        case .failure(let error):
            self.router?.showErrorAlertAndTakeUserAction(error: error)
        default:
            self.interactor?.flushAndAddUsers()
        }
    }
}

extension LaunchPresenter: LaunchPresenterProtocol {    
    func initAndLaunch() {
        self.interactor?.initCoreData()
    }
}

extension LaunchPresenter: LaunchRouterOutputProtocol {
    func retryCallOnInitError() {
        self.initAndLaunch()
    }
}
