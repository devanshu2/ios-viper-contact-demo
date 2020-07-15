//
//  ContactListViewController.swift
//  ContactDemo
//
//  Created by Devanshu Saini on 11/07/20.
//  Copyright © 2020 Devanshu Saini. All rights reserved.
//

import UIKit

class ContactListViewController: UIViewController, StoryBoardViewControllerIdentifier {
    static var storyboardName: String {
        get {
            return Constants.StoryBoard.main
        }
    }
    
    static var storyboardIdentifier: String {
        get {
            return Constants.ViewControllerIdentifiers.contactListViewController
        }
    }
    
    var presenter: ContactListPresenterProtocol!
    
    @IBOutlet weak var listTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter.fetchUsers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = self.presenter.getTitle()
    }
}

extension ContactListViewController: ViperCreation {
    static func getViper(with navigationController: UINavigationController?) -> UIViewController? {
        if let controller = ContactListViewController.getViewController() as? ContactListViewController {
            let presenter = ContactListPresenter(outputHandler: controller)
            let router = ContactListRouter(delegate: presenter, navigationController: navigationController)
            let interactor = ContactListInteractor(outputHandler: presenter)
            
            presenter.router = router
            presenter.interactor = interactor
            
            controller.presenter = presenter
            return controller
        }
        return nil
    }
}

extension ContactListViewController: ContactListPresenterOutputProtocol {
    func refreshUserTable() {
        self.listTable.reloadData()
    }
}

extension ContactListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.presenter.getUserCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier: String = "cell"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: cellIdentifier)
            cell?.selectionStyle = .none
            cell?.accessoryType = .disclosureIndicator
        }
        let user = self.presenter.getUser(atIndex: indexPath.row)
        cell?.textLabel?.text = user.name
        return cell!
    }
}

extension ContactListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.presenter.didSelectUser(atIndex: indexPath.row)
    }
}
