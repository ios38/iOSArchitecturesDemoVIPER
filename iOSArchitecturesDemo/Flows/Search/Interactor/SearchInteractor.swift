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
    func requestApps(with query: String, searchMode: SearchMode)
}

protocol SearchInteractorOutputProtocol: class {
    func appsDidReceive(_ apps: [Any])
}

class SearchInteractor {
    
    weak var presenter: SearchInteractorOutputProtocol!
    private let searchService = ITunesSearchService()

    required init(presenter: SearchInteractorOutputProtocol) {
        self.presenter = presenter
    }
}

extension SearchInteractor: SearchInteractorProtocol {
    func requestApps(with query: String, searchMode: SearchMode) {
        switch searchMode {
        case .apps:
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
        case .songs:
            self.searchService.getSongs(forQuery: query) { [weak self] results in
                results
                    .withValue { songs in
                        print("SearchInteractor: apps.count: \(songs.count)")
                        self?.presenter.appsDidReceive(songs)
                }
                .withError { error in
                    print(error)
                }
            }
        }
    }
}
