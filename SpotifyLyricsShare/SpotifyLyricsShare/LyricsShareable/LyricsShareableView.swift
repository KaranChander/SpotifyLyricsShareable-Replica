//
//  LyricsShareableView.swift
//  SpotifyLyricsShare
//
//  Created by Chander, Karan on 7/14/24.
//

import SwiftUI

struct LyricsShareableView: View {
    @StateObject var vm: LyricsShareableViewModel 
    @State var lyricsSelected: Int = 0
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        if let lyrics = vm.song?.lyrics {
        VStack {
            Text(vm.song?.title ?? "")
                .font(.title)

            if lyricsSelected >= 3 {
                Text("Max lines selected")
            } else {
                Text("\(lyricsSelected) lines selected")
            }
                Spacer()
                List {
                    ForEach(lyrics) {lyric in
                        if lyric.isSelected {
                            Text(lyric.text)
                                .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
                                .background(Color.black)
                                .background(in: .capsule, fillStyle: FillStyle.init())
                                .foregroundColor(.white)
                                .onTapGesture {
                                        lyricsSelected -= 1
                                        vm.enableLyricSelection(lyric)
                                }
                        } else {
                            Text(lyric.text)
                                .padding(EdgeInsets(top: 5, leading: 20, bottom: 5, trailing: 20))
                                .background(Color.clear)
                                .background(in: .capsule, fillStyle: FillStyle.init())
                                .foregroundColor(.black)
                                .onTapGesture {
                                    if lyricsSelected < 3 {
                                        lyricsSelected += 1
                                        vm.enableLyricSelection(lyric)
                                    }
                                }
                        }
                    }.listRowSeparator(.hidden)
                        .listRowBackground(Color.clear)
                }
                .listRowSpacing(0)
                .listStyle(.plain)
            if let image = snapshot() {
                ShareLink(item: image, preview: SharePreview("Facts", image: image)) {
                    Text("Continue")
                        .padding()
                    .background(Color.black)
                    .background(in: .capsule, fillStyle: FillStyle.init())
                    .foregroundColor(.white)
                }
            }
            Spacer()
            }
        .navigationTitle("Share Lyrics")
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    HStack {
                        Image(systemName: "chevron.backward")
                            .foregroundColor(.black)
                    }
                }
            }
        }.navigationBarTitleDisplayMode(.inline)

        } else {
            Text("error")
        }
    }
    
    func snapshot() -> Image? {
        guard let song = vm.song else { return nil}
        let rendered = ImageRenderer(content:
            VStack(alignment: .leading) {
             VStack(alignment: .leading,spacing: 30) {
                 HStack(alignment: .center) {
                     Image(vm.song?.imageName ?? "", bundle: nil)
                         .frame(width: 40, height: 40)
                         .cornerRadius(12)
                     VStack(alignment: .leading) {
                         Text(song.title)
                             .font(.headline)
                         Text(song.artist)
                             .font(.subheadline)
                     }
                 }
                 VStack(alignment: .leading) {
                     ForEach(song.lyrics) {lyric in
                         if lyric.isSelected {
                             Text(lyric.text)
                                 .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
                                 .background(Color.black)
                                 .background(in: .capsule, fillStyle: FillStyle.init())
                                 .foregroundColor(.white)
                             
                         }
                     }
                 }
            }
            .padding(EdgeInsets(top: 50, leading: 30, bottom: 50, trailing: 30))
                .background(Color.black.opacity(0.1))
                .cornerRadius(18)
        }.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            .background(Color.gray.opacity(0.3))
        )
        rendered.scale = 2
        return Image(uiImage: rendered.uiImage!)
    }
}

#Preview {
    LyricsShareableView(vm: LyricsShareableViewModel(id: 1))
}
