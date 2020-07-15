//
//  ContactDetailViewController.swift
//  ContactDemo
//
//  Created by Devanshu Saini on 11/07/20.
//  Copyright © 2020 Devanshu Saini. All rights reserved.
//

import UIKit

class ContactDetailViewController: UIViewController, StoryBoardViewControllerIdentifier {
    static var storyboardName: String {
        get {
            return Constants.StoryBoard.main
        }
    }
    
    static var storyboardIdentifier: String {
        get {
            return Constants.ViewControllerIdentifiers.contactDetailViewController
        }
    }
    
    var presenter: ContactDetailPresenterProtocol!
    
    @IBOutlet weak var infoContainer: UIView!
    @IBOutlet weak var webContainer: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addChildControllers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setPageTitle()
    }
    
    func setPageTitle() {
        self.title = self.presenter.getTitle()
    }
    
    func addChildControllers() {
        if let infoController = ContactDetailInfoViewController.getViper(with: nil) as? ContactDetailInfoViewController, let webController = WebPageViewController.getViper(with: nil) as? WebPageViewController {
            infoController.presenter.user = self.presenter.user
            webController.presenter.webPageURLString = self.presenter.user.website
            self.displayChildController(infoController, containerView: self.infoContainer)
            self.displayChildController(webController, containerView: self.webContainer)
        }
    }
    
    private func displayChildController(_ controller:UIViewController, containerView: UIView) {
        self.addChild(controller)
        controller.view.frame = containerView.bounds
        containerView.addSubview(controller.view)
        controller.didMove(toParent: self)
    }
}

extension ContactDetailViewController: ViperCreation {
    static func getViper(with navigationController: UINavigationController?) -> UIViewController? {
        if let controller = ContactDetailViewController.getViewController() as? ContactDetailViewController {
            let presenter = ContactDetailPresenter(outputHandler: controller)
            let router = ContactDetailRouter(delegate: presenter, navigationController: navigationController)
            let interactor = ContactDetailInteractor(outputHandler: presenter)
            
            presenter.router = router
            presenter.interactor = interactor
            
            controller.presenter = presenter
            return controller
        }
        return nil
    }
}

extension ContactDetailViewController: ContactDetailPresenterOutputProtocol {

}
