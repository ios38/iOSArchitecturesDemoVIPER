//
//  SearchPresenter.swift
//  iOSArchitecturesDemo
//
//  Created by Maksim Romanov on 08.04.2020.
//  Copyright © 2020 ekireev. All rights reserved.
//

import Foundation

protocol SearchPresenterProtocol: class {
    var apps: [Any] { get }
    var appsCount: Int? { get }
    
    func app(atIndex indexPath: IndexPath) -> Any?

    func viewDidSearch(with query: String, searchMode: SearchMode)
    func viewDidSelect(at indexPath: IndexPath, searchMode: SearchMode)
}

class SearchPresenter {
    
    weak var view: SearchViewProtocol!
    var interactor: SearchInteractorProtocol!
    var router: SearchRouterProtocol!
    
    var apps: [Any] = []
    var appsCount: Int? {
        apps.count
    }
    
    required init(view: SearchViewProtocol) {
        self.view = view
    }
    
    private func requestApps(with query: String, searchMode: SearchMode) {
        self.interactor.requestApps(with: query, searchMode: searchMode)
    }

}

// MARK: - SearchPresenterProtocol
extension SearchPresenter: SearchPresenterProtocol {
    func app(atIndex indexPath: IndexPath) -> Any? {
        if apps.indices.contains(indexPath.row) {
            return apps[indexPath.row]
        } else {
            return nil
        }
    }
    
    func viewDidSearch(with query: String, searchMode: SearchMode) {
        self.requestApps(with: query, searchMode: searchMode)
    }

    func viewDidSelect(at indexPath: IndexPath, searchMode: SearchMode) {
        if apps.indices.contains(indexPath.row) {
            let app = apps[indexPath.row]
            router.openDetailsViewController(with: app, searchMode: searchMode)
        }
    }
}

// MARK: - SearchInteractorOutputProtocol
extension SearchPresenter: SearchInteractorOutputProtocol {

    func appsDidReceive(_ apps: [Any]) {
        self.apps = apps 
        view.reloadData()
    }
    /*
    func songsDidReceive(_ songs: [ITunesSong]) {
        self.songs = songs
        view.reloadData()
    }*/
}
