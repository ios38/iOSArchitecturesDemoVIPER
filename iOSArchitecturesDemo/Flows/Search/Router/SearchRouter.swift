//
//  SearchRouter.swift
//  iOSArchitecturesDemo
//
//  Created by Maksim Romanov on 08.04.2020.
//  Copyright © 2020 ekireev. All rights reserved.
//

import UIKit

protocol SearchRouterProtocol: class {
    func openDetailsViewController(with item: Any, searchMode: SearchMode)
}

class SearchRouter {
    
    weak var viewController: SearchViewController!
    
    init(viewController: SearchViewController) {
        self.viewController = viewController
    }
}

extension SearchRouter: SearchRouterProtocol {
    func openDetailsViewController(with item: Any, searchMode: SearchMode) {
        
        switch searchMode {
        case .apps:
            let app = item as! ITunesApp
            print("SearchRouter: openDetailsViewController with \(app.appName)")
            
            let appDetaillViewController = AppDetailViewController(app: app)
            self.viewController?.navigationController?.pushViewController(appDetaillViewController, animated: true)
            
        case .songs:
            let song = item as! ITunesSong
            print("SearchRouter: openDetailsViewController with \(song.trackName)")

            let songDetaillViewController = SongDetailViewController(song: song)
            self.viewController?.navigationController?.pushViewController(songDetaillViewController, animated: true)
        }
        
    }
}
