//
//  SearchPresenter.swift
//  iOSArchitecturesDemo
//
//  Created by Maksim Romanov on 08.04.2020.
//  Copyright © 2020 ekireev. All rights reserved.
//

import Foundation

protocol SearchPresenterProtocol: class {
    var items: [Any] { get }
    var itemsCount: Int? { get }
    
    func item(atIndex indexPath: IndexPath) -> Any?

    func viewDidSearch(with query: String, searchMode: SearchMode)
    func viewDidSelect(at indexPath: IndexPath, searchMode: SearchMode)
}

class SearchPresenter {
    
    weak var view: SearchViewProtocol!
    var interactor: SearchInteractorProtocol!
    var router: SearchRouterProtocol!
    
    var items: [Any] = []
    var itemsCount: Int? {
        items.count
    }
    
    required init(view: SearchViewProtocol) {
        self.view = view
    }
    
    private func requestItems(with query: String, searchMode: SearchMode) {
        self.interactor.requestItems(with: query, searchMode: searchMode)
    }

}

// MARK: - SearchPresenterProtocol
extension SearchPresenter: SearchPresenterProtocol {
    func item(atIndex indexPath: IndexPath) -> Any? {
        if items.indices.contains(indexPath.row) {
            return items[indexPath.row]
        } else {
            return nil
        }
    }
    
    func viewDidSearch(with query: String, searchMode: SearchMode) {
        self.requestItems(with: query, searchMode: searchMode)
    }

    func viewDidSelect(at indexPath: IndexPath, searchMode: SearchMode) {
        if items.indices.contains(indexPath.row) {
            let app = items[indexPath.row]
            router.openDetailsViewController(with: app, searchMode: searchMode)
        }
    }
}

// MARK: - SearchInteractorOutputProtocol
extension SearchPresenter: SearchInteractorOutputProtocol {

    func itemsDidReceive(_ items: [Any]) {
        self.items = items 
        view.reloadData()
    }
}
