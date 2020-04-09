//
//  SearchInteractor.swift
//  iOSArchitecturesDemo
//
//  Created by Maksim Romanov on 08.04.2020.
//  Copyright © 2020 ekireev. All rights reserved.
//

import Foundation

import Alamofire

protocol SearchInteractorProtocol: class {
    func requestApps(with query: String)
}

protocol SearchInteractorOutputProtocol: class {
    func appsDidReceive(_ apps: [ITunesApp])
}

class SearchInteractor {
    
    weak var presenter: SearchInteractorOutputProtocol!
    private let searchService = ITunesSearchService()

    required init(presenter: SearchInteractorOutputProtocol) {
        self.presenter = presenter
    }
}

extension SearchInteractor: SearchInteractorProtocol {
    func requestApps(with query: String) {
        self.searchService.getApps(forQuery: query) { [weak self] results in
            results
                .withValue { apps in
                    print("SearchInteractor: apps.count: \(apps.count)")
                    self?.presenter.appsDidReceive(apps)
            }
            .withError { error in
                print(error)
            }
        }
    }
}
