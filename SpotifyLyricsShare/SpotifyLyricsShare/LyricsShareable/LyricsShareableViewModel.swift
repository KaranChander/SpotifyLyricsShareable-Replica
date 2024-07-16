//
//  LyricsShareableViewModel.swift
//  SpotifyLyricsShare
//
//  Created by Chander, Karan on 7/14/24.
//

import Foundation


class LyricsShareableViewModel: ObservableObject {
    public static let shared = LyricsShareableViewModel(id: 1)
    var selectedLyrics: [Lyric] = []
    @Published var song: Song?

    init(id: Int) {
        fetchSongDetails(id: id)
    }
    
    func fetchSongDetails(id: Int) {
        if let url = Bundle.main.url(forResource: "lyrics", withExtension: "json") {
                   do {
                       let data = try Data(contentsOf: url)
                       let songArr = try JSONDecoder().decode(SongData.self, from: data)
                       for songData in songArr.songs {
                           if songData.id == id {
                               self.song = songData.toSong()
                           }
                       }
                   } catch {
                       print("Error loading JSON: \(error)")
                   }
               }
    }
    
    func enableLyricSelection(_ lyric: Lyric) {
        if let index = self.song?.lyrics.firstIndex(of: lyric) {
            print(lyric.text)
            self.song?.lyrics[index].isSelected = !(self.song?.lyrics[index].isSelected ?? true)
        }
    }
}
