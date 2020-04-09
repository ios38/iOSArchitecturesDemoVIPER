//
//  SearchRouter.swift
//  iOSArchitecturesDemo
//
//  Created by Maksim Romanov on 08.04.2020.
//  Copyright © 2020 ekireev. All rights reserved.
//

import UIKit

protocol SearchRouterProtocol: class {
    func openAppDetailsViewController(with app: ITunesApp)
}

class SearchRouter {
    
    weak var viewController: SearchViewController!
    
    init(viewController: SearchViewController) {
        self.viewController = viewController
    }
}

extension SearchRouter: SearchRouterProtocol {
    func openAppDetailsViewController(with app: ITunesApp) {
        print("SearchRouter: openAppDetailsViewController with (\(app.appName)")

        let appDetaillViewController = AppDetailViewController(app: app)
        //appDetaillViewController.view.backgroundColor = .white
        self.viewController?.navigationController?.pushViewController(appDetaillViewController, animated: true)
    }
}
