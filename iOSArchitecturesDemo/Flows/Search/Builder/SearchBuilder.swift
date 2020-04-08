//
//  SearchBuilder.swift
//  iOSArchitecturesDemo
//
//  Created by Maksim Romanov on 08.04.2020.
//  Copyright © 2020 ekireev. All rights reserved.
//

import Foundation

protocol SearchBuilderProtocol: class {
    func build(with viewController: SearchViewController)
}

class SearchBuilder: SearchBuilderProtocol {
    func build(with viewController: SearchViewController) {
        let presenter = SearchPresenter(view: viewController)
        let interactor = SearchInteractor(presenter: presenter)
        let router = SearchRouter(viewController: viewController)
        
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}
