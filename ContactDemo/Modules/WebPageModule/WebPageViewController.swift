//
//  WebPageViewController.swift
//  ContactDemo
//
//  Created by Devanshu Saini on 11/07/20.
//  Copyright © 2020 Devanshu Saini. All rights reserved.
//

import UIKit
import WebKit

class WebPageViewController: UIViewController, StoryBoardViewControllerIdentifier {
    static var storyboardName: String {
        get {
            return Constants.StoryBoard.main
        }
    }
    
    static var storyboardIdentifier: String {
        get {
            return Constants.ViewControllerIdentifiers.webPageViewController
        }
    }
    
    var presenter: WebPagePresenterProtocol!
    
    @IBOutlet weak var webView: WKWebView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.loadWebPage()
    }
    
    func loadWebPage() {
        guard let url = self.presenter.webPageURL else {
            return
        }
        self.webView.load(URLRequest(url: url))
    }
}

extension WebPageViewController: ViperCreation {    
    static func getViper(with navigationController: UINavigationController?) -> UIViewController? {
        if let controller = WebPageViewController.getViewController() as? WebPageViewController {
            let presenter = WebPagePresenter(outputHandler: controller)
            let router = WebPageRouter(delegate: presenter)
            let interactor = WebPageInteractor(outputHandler: presenter)
            
            presenter.router = router
            presenter.interactor = interactor
            
            controller.presenter = presenter
            return controller
        }
        return nil
    }
}

extension WebPageViewController: WebPagePresenterOutputProtocol {

}
