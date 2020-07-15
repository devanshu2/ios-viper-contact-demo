//
//  StoryBoardViewControllerIdentifier.swift
//  ContactDemo
//
//  Created by Devanshu Saini on 11/07/20.
//  Copyright © 2020 Devanshu Saini. All rights reserved.
//

import UIKit

protocol StoryBoardViewControllerIdentifier: UIViewController {
    static var storyboardIdentifier: String { get }
    static var storyboardName: String { get }
}

extension StoryBoardViewControllerIdentifier {
    static func getViewController() -> UIViewController? {
        return UIStoryboard(name: self.storyboardName, bundle: nil).instantiateViewController(withIdentifier: storyboardIdentifier)
    }
}
