//
//  ViewController.swift
//  iOSArchitecturesDemo
//
//  Created by ekireev on 14.02.2018.
//  Copyright © 2018 ekireev. All rights reserved.
//

import UIKit

protocol SearchViewProtocol: class {
    var selfToCourseDetailsSegueName: String { get }
    func reloadData()
}

class SearchViewController: UIViewController {
    var presenter: SearchPresenterProtocol!
    private let builder: SearchBuilderProtocol = SearchBuilder()
    var selfToCourseDetailsSegueName = "showDetails"
    // MARK: - Private Properties
    
    private var searchView: SearchView {
        return self.view as! SearchView
    }
    
    //private let searchService = ITunesSearchService()
    //private var searchResults = [ITunesApp]()
    
    private struct Constants {
        static let reuseIdentifier = "reuseId"
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
        
        self.searchView.searchBar.delegate = self
        self.searchView.tableView.register(AppCell.self, forCellReuseIdentifier: Constants.reuseIdentifier)
        self.searchView.tableView.delegate = self
        self.searchView.tableView.dataSource = self
    }
    /*
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.throbber(show: false)
    }*/
    
    // MARK: - Private
    /*
    private func throbber(show: Bool) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = show
    }
    
    private func showError(error: Error) {
        let alert = UIAlertController(title: "Error", message: "\(error.localizedDescription)", preferredStyle: .alert)
        let actionOk = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(actionOk)
        self.present(alert, animated: true, completion: nil)
    }
    
    private func showNoResults() {
        self.searchView.emptyResultView.isHidden = false
    }
    
    private func hideNoResults() {
        self.searchView.emptyResultView.isHidden = true
    }
    
    private func requestApps(with query: String) {
        self.throbber(show: true)
        self.searchResults = []
        self.searchView.tableView.reloadData()
        
        self.searchService.getApps(forQuery: query) { [weak self] result in
            guard let self = self else { return }
            self.throbber(show: false)
            result
                .withValue { apps in
                    guard !apps.isEmpty else {
                        self.searchResults = []
                        self.showNoResults()
                        return
                    }
                    self.hideNoResults()
                    self.searchResults = apps
                    
                    self.searchView.tableView.isHidden = false
                    self.searchView.tableView.reloadData()
                    
                    self.searchView.searchBar.resignFirstResponder()
                }
                .withError {
                    self.showError(error: $0)
                }
        }
    }*/
}

//MARK: - UITableViewDataSource
extension SearchViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("SearchViewController: presenter.appsCount: \(presenter.appsCount)")
        return presenter.appsCount ?? 0
        //return searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dequeuedCell = tableView.dequeueReusableCell(withIdentifier: Constants.reuseIdentifier, for: indexPath)
        guard let cell = dequeuedCell as? AppCell else { return dequeuedCell }
        guard let app = presenter.app(atIndex: indexPath) else { return dequeuedCell }
        //let app = self.searchResults[indexPath.row]
        print("SearchViewController: app: \(app)")
        let cellModel = AppCellModelFactory.cellModel(from: app)
        cell.configure(with: cellModel)
        return cell
    }
}

//MARK: - UITableViewDelegate
extension SearchViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter.showAppDetails(for: indexPath)
        //let app = searchResults[indexPath.row]
        //let appDetaillViewController = AppDetailViewController()
        //appDetaillViewController.app = app
        //navigationController?.pushViewController(appDetaillViewController, animated: true)
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
        presenter.viewDidSearch(with: query)
        //self.requestApps(with: query)
    }
}

//MARK: - SearchViewProtocol
extension SearchViewController: SearchViewProtocol {
    func reloadData() {
        DispatchQueue.main.async {
            self.searchView.tableView.reloadData()
        }
    }
}
