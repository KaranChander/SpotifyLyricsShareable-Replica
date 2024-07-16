//
//  LyricsListViewModel.swift
//  SpotifyLyricsShare
//
//  Created by Chander, Karan on 7/15/24.
//

import Foundation


class LyricsListViewModel: ObservableObject {
    
    public static let shared = LyricsListViewModel()
    var songs: [Song] = []
    
    init() {
        fetchSongs()
    }
    
    
    func fetchSongs() {
        if let url = Bundle.main.url(forResource: "lyrics", withExtension: "json") {
                   do {
                       let data = try Data(contentsOf: url)
                       let songArr = try JSONDecoder().decode(SongData.self, from: data)
                       print(songArr)
                       for songData in songArr.songs {
                           self.songs.append(songData.toSong())
                       }
                   } catch {
                       print("Error loading JSON: \(error)")
                   }
               }
    }
}
