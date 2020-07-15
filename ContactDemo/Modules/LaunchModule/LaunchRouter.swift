//
//  LaunchRouter.swift
//  ContactDemo
//
//  Created by Devanshu Saini on 11/07/20.
//  Copyright © 2020 Devanshu Saini. All rights reserved.
//

import UIKit

class LaunchRouter {
    weak var delegate: LaunchRouterOutputProtocol?
    weak var navigationController: UINavigationController?

    init(delegate: LaunchRouterOutputProtocol, navigationController: UINavigationController?) {
        self.delegate = delegate
        self.navigationController = navigationController
    }
}

extension LaunchRouter: LaunchRouterProtocol {
    func gotoContactList() {
        if let vc = ContactListViewController.getViper(with: self.navigationController) {
            self.navigationController?.setViewControllers([vc], animated: true)
        }
    }
    
    func showErrorAlertAndTakeUserAction(error: Error) {
        let alert = UIAlertController(title: NSLocalizedString("Error", comment: "Error"), message: error.localizedDescription, preferredStyle: .alert)
        let retry = UIAlertAction(title: NSLocalizedString("Retry", comment: "Retry"), style: .default) { [weak self] (action) in
            self?.delegate?.retryCallOnInitError()
        }
        alert.addAction(retry)
        self.navigationController?.visibleViewController?.present(alert, animated: true, completion: nil)
    }
}
