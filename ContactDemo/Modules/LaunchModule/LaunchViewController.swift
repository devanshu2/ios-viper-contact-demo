//
//  LaunchViewController.swift
//  ContactDemo
//
//  Created by Devanshu Saini on 11/07/20.
//  Copyright © 2020 Devanshu Saini. All rights reserved.
//

import UIKit

class LaunchViewController: UIViewController, StoryBoardViewControllerIdentifier {
    static var storyboardName: String {
        get {
            return Constants.StoryBoard.launch
        }
    }

    static var storyboardIdentifier: String {
        get {
            return Constants.ViewControllerIdentifiers.launchViewController
        }
    }
    
    var presenter: LaunchPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter.initAndLaunch()
    }
}

extension LaunchViewController: LaunchPresenterOutputProtocol {

}

extension LaunchViewController: ViperCreation {
    static func getViper(with navigationController: UINavigationController?) -> UIViewController? {
        if let controller = LaunchViewController.getViewController() as? LaunchViewController {
            let presenter = LaunchPresenter(outputHandler: controller)
            let router = LaunchRouter(delegate: presenter, navigationController: navigationController)
            let interactor = LaunchInteractor(outputHandler: presenter)
            
            presenter.router = router
            presenter.interactor = interactor
            
            controller.presenter = presenter
            return controller
        }
        return nil
    }
}
