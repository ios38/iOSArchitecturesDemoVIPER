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
    
    func viewDidSearch(with query: String)

    func app(atIndex indexPath: IndexPath) -> ITunesApp?
    func showAppDetails(for indexPath: IndexPath)
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
    
    //var viewInput: (UIViewController & SearchViewInput)?
    
    private func requestApps(with query: String) {
        self.interactor.requestApps(with: query)
    }

}

// MARK: - SearchPresenterProtocol
extension SearchPresenter: SearchPresenterProtocol {
    func viewDidSearch(with query: String) {
        self.requestApps(with: query)
    }

    func app(atIndex indexPath: IndexPath) -> ITunesApp? {
        if apps.indices.contains(indexPath.row) {
            return apps[indexPath.row]
        } else {
            return nil
        }
    }
    
    func showAppDetails(for indexPath: IndexPath) {
        //if courses.indices.contains(indexPath.row) {
        //    let course = courses[indexPath.row]
        //    router.openCourseDetailsViewController(with: course)
        //}
    }
}

// MARK: - SearchInteractorOutputProtocol
extension SearchPresenter: SearchInteractorOutputProtocol {

    func appsDidReceive(_ apps: [ITunesApp]) {
        self.apps = apps
        view.reloadData()
    }
}
