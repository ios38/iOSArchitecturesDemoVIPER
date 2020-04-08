//
//  SearchInteractor.swift
//  iOSArchitecturesDemo
//
//  Created by Maksim Romanov on 08.04.2020.
//  Copyright © 2020 ekireev. All rights reserved.
//

import Foundation

protocol SearchInteractorProtocol: class {
    //func fetchCourses()
}

protocol SearchInteractorOutputProtocol: class {
    //func coursesDidReceive(_ courses: [Course])
}

class SearchInteractor {
    
    weak var presenter: SearchInteractorOutputProtocol!
    
    required init(presenter: SearchInteractorOutputProtocol) {
        self.presenter = presenter
    }
}

extension SearchInteractor: SearchInteractorProtocol {
    //func fetchCourses() {
    //    NetworkManager.shared.fetchData { [weak self] courses in
    //        self?.presenter.coursesDidReceive(courses)
    //    }
    //}
}
