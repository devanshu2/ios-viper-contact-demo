//
//  ContactListRouter.swift
//  ContactDemo
//
//  Created by Devanshu Saini on 11/07/20.
//  Copyright © 2020 Devanshu Saini. All rights reserved.
//

import UIKit

class ContactListRouter {
    weak var delegate: ContactListRouterOutputProtocol?
    weak var navigationController: UINavigationController?

    init(delegate: ContactListRouterOutputProtocol, navigationController: UINavigationController?) {
        self.delegate = delegate
        self.navigationController = navigationController
    }
}

extension ContactListRouter: ContactListRouterProtocol {
    func goToDetail(withUser user: User) {
        if let controller = ContactDetailViewController.getViper(with: self.navigationController) as? ContactDetailViewController {
            controller.presenter.user = user
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
    
    func showErrorAlert(error: Error) {
        let alert = UIAlertController(title: NSLocalizedString("Error", comment: "Error"), message: error.localizedDescription, preferredStyle: .alert)
        let ok = UIAlertAction(title: NSLocalizedString("OK", comment: "OK"), style: .default, handler: nil)
        alert.addAction(ok)
        self.navigationController?.visibleViewController?.present(alert, animated: true, completion: nil)
    }
}
