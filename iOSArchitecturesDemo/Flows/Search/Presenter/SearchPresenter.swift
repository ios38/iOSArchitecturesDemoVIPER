//
//  SearchPresenter.swift
//  iOSArchitecturesDemo
//
//  Created by Maksim Romanov on 08.04.2020.
//  Copyright © 2020 ekireev. All rights reserved.
//

import Foundation

protocol SearchPresenterProtocol: class {
    var apps: [ITunesApp] { get }
    var appsCount: Int? { get }
    
    func app(atIndex indexPath: IndexPath) -> ITunesApp?

    func viewDidSearch(with query: String)
    func viewDidSelect(at indexPath: IndexPath)
}

class SearchPresenter {
    
    weak var view: SearchViewProtocol!
    var interactor: SearchInteractorProtocol!
    var router: SearchRouterProtocol!
    
    var apps: [ITunesApp] = []
    var appsCount: Int? {
        apps.count
    }
    
    required init(view: SearchViewProtocol) {
        self.view = view
    }
    
    private func requestApps(with query: String) {
        self.interactor.requestApps(with: query)
    }

}

// MARK: - SearchPresenterProtocol
extension SearchPresenter: SearchPresenterProtocol {
    func app(atIndex indexPath: IndexPath) -> ITunesApp? {
        if apps.indices.contains(indexPath.row) {
            return apps[indexPath.row]
        } else {
            return nil
        }
    }
    
    func viewDidSearch(with query: String) {
        self.requestApps(with: query)
    }

    func viewDidSelect(at indexPath: IndexPath) {
        if apps.indices.contains(indexPath.row) {
            let app = apps[indexPath.row]
            router.openAppDetailsViewController(with: app)
        }
    }
}

// MARK: - SearchInteractorOutputProtocol
extension SearchPresenter: SearchInteractorOutputProtocol {

    func appsDidReceive(_ apps: [ITunesApp]) {
        self.apps = apps
        view.reloadData()
    }
}
