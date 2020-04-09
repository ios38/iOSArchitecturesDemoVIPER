//
//  PlayingSong.swift
//  iOSArchitecturesDemo
//
//  Created by Elena Gracheva on 02.04.2020.
//  Copyright © 2020 ekireev. All rights reserved.
//

import Foundation

protocol PlaySongServiceInterface: class {
    var PlayingSongs: [PlayingSong] { get }
    var onPlaying: (() -> Void)? { get set }
    func playSong(_ song: ITunesSong)
}

final class PlayingSong {
    enum playingState {
        case paused
        case playing(progress: Int)
        case finished
    }
    
    let song: ITunesSong
    
    var playingState: playingState = .paused
    
    init(song: ITunesSong) {
        self.song = song
    }
}

final class PlaySongService: PlaySongServiceInterface {
    
    // MARK: - DownloadAppsServiceInterface
    
    private(set) var PlayingSongs: [PlayingSong] = []
    
    var onPlaying: (() -> Void)?
    
    func playSong(_ song: ITunesSong) {
        let playingSong = PlayingSong(song: song)
        if !self.PlayingSongs.contains(where: { $0.song.trackName == song.trackName }) {
            self.PlayingSongs.append(playingSong)
            self.startTimer(for: playingSong)
        }
    }
    
    // MARK: - Private properties
    
    private var timers: [Timer] = []
    
    // MARK: - Private
    
    private func startTimer(for playingSong: PlayingSong) {
        let timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] timer in
            switch playingSong.playingState {
            case .paused:
                playingSong.playingState = .playing(progress: 1)
            case .playing(let progress):
                let newProgress = progress + 1
                if newProgress >= 300 {
                    playingSong.playingState = .finished
                    self?.invalidateTimer(timer)
                } else {
                    playingSong.playingState = .playing(progress: progress + 1)
                }
            case .finished:
                self?.invalidateTimer(timer)
            }
            self?.onPlaying?()
        }
        RunLoop.main.add(timer, forMode: .common)
        self.timers.append(timer)
    }
    
    private func invalidateTimer(_ timer: Timer) {
        timer.invalidate()
        self.timers.removeAll { $0 === timer }
    }
}
