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
    func viewDidLoad(with query: String)
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
}

// MARK: - SearchPresenterProtocol
extension SearchPresenter: SearchPresenterProtocol {
    func viewDidLoad(with query: String) {
        //interactor.fetchCourses()
    }
    
    func app(atIndex indexPath: IndexPath) -> ITunesApp? {
        //if courses.indices.contains(indexPath.row) {
        //    return courses[indexPath.row]
        //} else {
            return nil
        //}
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
    //func coursesDidReceive(_ courses: [Course]) {
    //    self.courses = courses
    //    view.reloadData()
    //}
}
