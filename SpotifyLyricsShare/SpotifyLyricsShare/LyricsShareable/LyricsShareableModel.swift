import Foundation

public struct Lyric: Hashable, Codable, Identifiable {
    public let id: UUID
    public let text: String
    public var isSelected: Bool = false

    public init(text: String, isSelected: Bool = false) {
        self.id = UUID()
        self.text = text
        self.isSelected = isSelected
    }
}

public struct Song: Hashable, Codable, Identifiable {
    public let id: Int
    public let title: String
    public var artist: String
    public var lyrics: [Lyric]
    public var imageName: String

    public init(id: Int, title: String, artist: String, lyrics: [String], imageName: String) {
        self.id = id
        self.title = title
        self.artist = artist
        self.lyrics = lyrics.map { Lyric(text: $0) }
        self.imageName = imageName
    }
}

struct SongData: Codable {
    let songs: [CodableSong]
}

struct CodableSong: Codable {
    let id: Int
    let title: String
    let artist: String
    let lyrics: [String]
    let imageName: String
    
    func toSong() -> Song {
        return Song(id: id, title: title, artist: artist, lyrics: lyrics, imageName: imageName)
    }
}
