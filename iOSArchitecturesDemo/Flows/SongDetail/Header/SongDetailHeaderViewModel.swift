//
//  SongDetailHeaderViewModel.swift
//  iOSArchitecturesDemo
//
//  Created by Maksim Romanov on 09.04.2020.
//  Copyright © 2020 ekireev. All rights reserved.
//

import Foundation

struct SongDetailHeaderViewModel {
    let trackName: String
    let artistName: String?
    let collectionName: String?
    let artwork: String?
    let primaryGenreName: String?
    let releaseDate: String
}

final class SongDetailHeaderViewModelFactory {
    
    static func viewModel(from model: ITunesSong) -> SongDetailHeaderViewModel {
        return SongDetailHeaderViewModel(
            trackName: model.trackName,
            artistName: model.artistName,
            collectionName: model.collectionName,
            artwork: model.artwork,
            primaryGenreName: model.primaryGenreName,
            releaseDate: model.releaseDate)
    }
}
