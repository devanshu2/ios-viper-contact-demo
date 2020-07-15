//
//  ContactDetailInfoViewController.swift
//  ContactDemo
//
//  Created by Devanshu Saini on 11/07/20.
//  Copyright © 2020 Devanshu Saini. All rights reserved.
//

import UIKit

class ContactDetailInfoViewController: UIViewController, StoryBoardViewControllerIdentifier {
    static var storyboardName: String {
        get {
            return Constants.StoryBoard.main
        }
    }
    
    static var storyboardIdentifier: String {
        get {
            return Constants.ViewControllerIdentifiers.contactDetailInfoViewController
        }
    }
    
    var presenter: ContactDetailInfoPresenterProtocol!
    
    @IBOutlet weak var verticalStackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.renderStackView()
    }
    
    func renderStackView() {
        let infoItems = self.presenter.getUserInfoLines()
        for item in infoItems {
            let label = UILabel()
            label.text = item.title + ": " + item.description
            self.verticalStackView.addArrangedSubview(label)
        }
    }
}

extension ContactDetailInfoViewController: ViperCreation {
    static func getViper(with navigationController: UINavigationController?) -> UIViewController? {
        if let controller = ContactDetailInfoViewController.getViewController() as? ContactDetailInfoViewController {
            let presenter = ContactDetailInfoPresenter(outputHandler: controller)
            let router = ContactDetailInfoRouter(delegate: presenter)
            let interactor = ContactDetailInfoInteractor(outputHandler: presenter)
            
            presenter.router = router
            presenter.interactor = interactor
            
            controller.presenter = presenter
            return controller
        }
        return nil
    }
}

extension ContactDetailInfoViewController: ContactDetailInfoPresenterOutputProtocol {

}
