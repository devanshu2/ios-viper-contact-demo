//
//  Constants.swift
//  ContactDemo
//
//  Created by Devanshu Saini on 11/07/20.
//  Copyright © 2020 Devanshu Saini. All rights reserved.
//

import Foundation

struct Constants {
    static let userJsonFile = "users"
    
    struct StoryBoard {
        static let main = "Main"
        static let launch = "Launch"
    }
    
    struct Entities {
        static let user = "User"
    }
    
    struct Segue {
        static let contactListToDetail = "contactListToDetail"
    }
    
    struct ViewControllerIdentifiers {
        static let launchViewController = "LaunchViewController"
        static let contactListViewController = "ContactListViewController"
        static let contactDetailViewController = "ContactDetailViewController"
        static let webPageViewController = "WebPageViewController"
        static let contactDetailInfoViewController = "ContactDetailInfoViewController"
        static let launchNavigationController = "LaunchNavigationController"
    }
}
