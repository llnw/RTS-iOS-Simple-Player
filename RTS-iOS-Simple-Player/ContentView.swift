//
//  ContentView.swift
//  RTS-iOS-Simple-Player
//
//  Created by Virgil Prewitt on 1/6/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        return TabView() {
            SubscribeView()
                .tabItem {
                    Image(systemName: "play")
                    Text("Subscribe")
                }
            PublishView()
                .tabItem {
                    Image(systemName: "video")
                    Text("Publish")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
