//
//  SearchView.swift
//  iOSArchitecturesDemo
//
//  Created by Evgeny Kireev on 02/06/2019.
//  Copyright © 2019 ekireev. All rights reserved.
//

import UIKit

protocol SearchModeControlDelegate: class {
    func searchModeSelected(_ searchMode: SearchMode) //searchModeControlSwitched
}

enum SearchMode {
    case apps, songs
}

final class SearchView: UIView {
    
    // MARK: - Subviews
    
    let searchModeControl = UISegmentedControl(items: ["Apps","Songs"])
    let searchBar = UISearchBar()
    let tableView = UITableView()
    let emptyResultView = UIView()
    let emptyResultLabel = UILabel()
    
    var searchMode: SearchMode {
        switch self.searchModeControl.selectedSegmentIndex {
        case 0:
            return .apps
        case 1:
            return .songs
        default:
            return .apps
        }
    }

    weak var searchModeControlDelegate: SearchModeControlDelegate?

    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.configureUI()
    }
    
    // MARK: - UI
    
    private func configureUI() {
        //self.backgroundColor = .white
        self.addSearchModeControl()
        self.addSearchBar()
        self.addTableView()
        self.addEmptyResultView()
        self.setupConstraints()
    }
    
    private func addSearchModeControl() {
        self.searchModeControl.translatesAutoresizingMaskIntoConstraints = false
        self.searchModeControl.selectedSegmentIndex = 0
        self.searchModeControl.addTarget(self, action: #selector(self.searchModeControlSwitched(_:)), for: .valueChanged)
        self.addSubview(self.searchModeControl)
    }

    private func addSearchBar() {
        self.searchBar.translatesAutoresizingMaskIntoConstraints = false
        self.searchBar.searchBarStyle = .minimal
        self.addSubview(self.searchBar)
    }
    
    private func addTableView() {
        self.tableView.rowHeight = 72.0
        self.tableView.separatorInset = UIEdgeInsets(top: 0.0, left: 12.0, bottom: 0.0, right: 0.0)
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.isHidden = false
        self.tableView.tableFooterView = UIView()
        self.addSubview(self.tableView)
    }
    
    @objc func searchModeControlSwitched(_ sender: UISegmentedControl) {
        self.searchModeControlDelegate?.searchModeSelected(self.searchMode)
    }
    
    private func addEmptyResultView() {
        self.emptyResultView.translatesAutoresizingMaskIntoConstraints = false
        //self.emptyResultView.backgroundColor = .white
        self.emptyResultView.isHidden = true
        
        self.emptyResultLabel.translatesAutoresizingMaskIntoConstraints = false
        self.emptyResultLabel.text = "Nothing was found"
        self.emptyResultLabel.textColor = UIColor.darkGray
        self.emptyResultLabel.textAlignment = .center
        self.emptyResultLabel.font = UIFont.systemFont(ofSize: 12.0)
        
        self.addSubview(self.emptyResultView)
        self.emptyResultView.addSubview(self.emptyResultLabel)
    }
    
    private func setupConstraints() {
        let safeArea = self.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            self.searchModeControl.topAnchor.constraint(equalTo: self.topAnchor, constant: 8.0),
            self.searchModeControl.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 10.0),
            self.searchModeControl.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -10.0),

            self.searchBar.topAnchor.constraint(equalTo: self.searchModeControl.bottomAnchor, constant: 8.0),
            self.searchBar.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            self.searchBar.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            
            self.tableView.topAnchor.constraint(equalTo: self.searchBar.bottomAnchor),
            self.tableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            
            self.emptyResultView.topAnchor.constraint(equalTo: self.searchBar.bottomAnchor),
            self.emptyResultView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            self.emptyResultView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            self.emptyResultView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            self.emptyResultLabel.topAnchor.constraint(equalTo: self.emptyResultView.topAnchor, constant: 12.0),
            self.emptyResultLabel.leadingAnchor.constraint(equalTo: self.emptyResultView.leadingAnchor),
            self.emptyResultLabel.trailingAnchor.constraint(equalTo: self.emptyResultView.trailingAnchor)
            ])
    }
}
