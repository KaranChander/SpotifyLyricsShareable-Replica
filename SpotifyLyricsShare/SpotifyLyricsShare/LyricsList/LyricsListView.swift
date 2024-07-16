//
//  LyricsListView.swift
//  SpotifyLyricsShare
//
//  Created by Chander, Karan on 7/15/24.
//

import SwiftUI

struct LyricsListView: View {
    
    @StateObject var vm: LyricsListViewModel = .shared
    
    var body: some View {
        NavigationSplitView {
            List {
                GeometryReader { geometry in
                    let minY = geometry.frame(in: .global).minY
                    parallaxHeaderView()
                        .frame(width: geometry.size.width,
                               height: geometry.size.height - 60 + max(minY,0))
                }
                .padding(EdgeInsets(top: 10, leading: 12, bottom: 20, trailing: 12))
                .frame(height: 300)
                .listRowSeparator(.hidden)
                .listRowBackground(Color.clear)
                
                songList()
                    .listRowSeparator(.visible)
                    .listRowBackground(Color.clear)
                    .padding(EdgeInsets(top: 10, leading: 12, bottom: 0, trailing: 12))
                
            }.listStyle(.plain)
                .listRowSpacing(10)
                .background(Gradient(colors: [.gray, .black]))
          
        } detail: {
            Text("Select a song")
        }
    }
    
    @ViewBuilder
    func parallaxHeaderView() -> some View {
        HStack {
            Spacer()
            Image("playlistCover", bundle: nil)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .cornerRadius(15)
            Spacer()
        }
    }
    
    @ViewBuilder
    func songList() -> some View {
            ForEach(self.vm.songs) { song in
                NavigationLink {
                    LyricsShareableView(vm: LyricsShareableViewModel(id: song.id))
                } label: {
                    songRowView(song: song)
                }
            }
    }
    
    @ViewBuilder
    func songRowView(song: Song) -> some View {
        HStack(alignment: .center, spacing: 14) {
            Image(song.imageName, bundle: nil)
                .frame(width: 40, height: 40)
                .aspectRatio(contentMode: .fill)
                .cornerRadius(12)
            VStack(alignment: .leading) {
                Text(song.title)
                    .font(Font(.init(.menuTitle, size: 18, language: nil)))
                    .foregroundStyle(Color.white)
                Text(song.artist)
                    .font(Font(.init(.systemDetail, size: 14, language: nil)))
                    .foregroundColor(.gray)
            }
            Spacer()
            Button {
            } label: {
                Image(systemName: "square.and.arrow.up")
                    .foregroundColor(.white)
            }
        }
    }
}



#Preview {
    LyricsListView()
}
