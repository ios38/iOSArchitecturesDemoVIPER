//
//  ViewController.swift
//  iOSArchitecturesDemo
//
//  Created by ekireev on 14.02.2018.
//  Copyright © 2018 ekireev. All rights reserved.
//

import UIKit

protocol SearchViewProtocol: class {
    func reloadData()
    //func showError(error: Error)
}

class SearchViewController: UIViewController {
    var presenter: SearchPresenterProtocol!
    
    // MARK: - Private Properties
    private let builder: SearchBuilderProtocol = SearchBuilder()

    private var searchView: SearchView {
        return self.view as! SearchView
    }

    private var searchMode: SearchMode = .apps

    private struct Constants {
        static let appReuseId = "appReuseId"
        static let songReuseId = "songReuseId"
    }
    
    // MARK: - Lifecycle
        override func loadView() {
        super.loadView()
        self.view = SearchView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .dark
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        builder.build(with: self)
        
        self.searchView.searchModeControlDelegate = self
        self.searchView.searchBar.delegate = self
        self.searchView.tableView.register(AppCell.self, forCellReuseIdentifier: Constants.appReuseId)
        self.searchView.tableView.register(SongCell.self, forCellReuseIdentifier: Constants.songReuseId)
        self.searchView.tableView.delegate = self
        self.searchView.tableView.dataSource = self
    }
}

//MARK: - UITableViewDataSource
extension SearchViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.itemsCount ?? 0
        //return searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch searchMode {
            
        case .apps:
            let dequeuedCell = tableView.dequeueReusableCell(withIdentifier: Constants.appReuseId, for: indexPath)
            guard let data = presenter.item(atIndex: indexPath) else { return dequeuedCell }
            guard let cell = dequeuedCell as? AppCell else { return dequeuedCell }
            let app = data as! ITunesApp
            let cellModel = AppCellModelFactory.cellModel(from: app)
            cell.configure(with: cellModel)
            return cell
            
        case .songs:
            let dequeuedCell = tableView.dequeueReusableCell(withIdentifier: Constants.songReuseId, for: indexPath)
            guard let data = presenter.item(atIndex: indexPath) else { return dequeuedCell }
            guard let cell = dequeuedCell as? SongCell else { return dequeuedCell }
            let song = data as! ITunesSong
            let cellModel = SongCellModelFactory.cellModel(from: song)
            cell.configure(with: cellModel)
            return cell
        }
    }
}

//MARK: - UITableViewDelegate
extension SearchViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter.viewDidSelect(at: indexPath, searchMode: searchMode)
    }
}

//MARK: - UISegmentedControlDelegate
extension SearchViewController: SearchModeControlDelegate {
    
    func searchModeSelected(_ searchMode: SearchMode) {
        self.searchMode = searchMode
        print("ViewController: searchModeSelected: \(self.searchMode)")
        searchBarSearchButtonClicked(self.searchView.searchBar)
    }
}

//MARK: - UISearchBarDelegate
extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let query = searchBar.text else {
            searchBar.resignFirstResponder()
            return
        }
        if query.count == 0 {
            searchBar.resignFirstResponder()
            return
        }
        presenter.viewDidSearch(with: query, searchMode: searchMode)
    }
}

//MARK: - SearchViewProtocol
extension SearchViewController: SearchViewProtocol {
    func reloadData() {
        DispatchQueue.main.async {
            self.searchView.tableView.reloadData()
        }
    }
    /*
    func showError(error: Error) {
        let alert = UIAlertController(title: "Error", message: "\(error.localizedDescription)", preferredStyle: .alert)
        let actionOk = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(actionOk)
        self.present(alert, animated: true, completion: nil)
    }*/
}
