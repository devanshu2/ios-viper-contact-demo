//
//  LaunchInteractor.swift
//  ContactDemo
//
//  Created by Devanshu Saini on 11/07/20.
//  Copyright © 2020 Devanshu Saini. All rights reserved.
//

import Foundation

class LaunchInteractor {
    weak var outputHandler: LaunchInteractorOutputProtocol?
    
    init(outputHandler: LaunchInteractorOutputProtocol) {
        self.outputHandler = outputHandler
    }
}

extension LaunchInteractor: LaunchInteractorProtocol {
    func initCoreData() {
        CoreDataController.shared.initializeStack { [weak self] (error) in
            guard let `self` = self else { return }
            if let er = error {
                self.outputHandler?.handleCoreDataInitInteractorOutput(LaunchInteractorGeneralOutput.failure(error: er))
            }
            else {
                self.outputHandler?.handleCoreDataInitInteractorOutput(LaunchInteractorGeneralOutput.success)
            }
        }
    }
    
    func flushAndAddUsers() {
        UserCRUD.shared.flushAndAddUsers { [weak self] (error) in
            guard let `self` = self else { return }
            let output: LaunchInteractorGeneralOutput = (error == nil) ? .success : .failure(error: error!)
            self.outputHandler?.handleUserSyncInteractorOutput(output)
        }
    }
}
