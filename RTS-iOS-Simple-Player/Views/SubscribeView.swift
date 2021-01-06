//
//  SubscribeView.swift
//  RTS-iOS-Simple-Player
//
//  Created by Virgil Prewitt on 1/6/21.
//

import Foundation
import SwiftUI
import LLNW_RTS

struct SubscribeView: View {
    var subscriber: LLSubscriber
    @ObservedObject var opts: LLObservedOptions
    @State var play = false
    
    init() {
        // A) initialize with no options
        subscriber = LLNW_RTS.Subscriber()
        // B) or initialize with options
        let options = LLNW_RTS.Options()
        options.shortname = "your-shortname"
        options.stream = "your-stream"
        subscriber = LLNW_RTS.Subscriber(options: options)
        // C) or initialize and save with UserDefaults
        subscriber = LLNW_RTS.Subscriber(
            options: LLNW_RTS.Options(
                settings: UserDefaults.standard,
                key: "Subscriber 123"
            )
        )
        // assign observable options if needed
        opts = subscriber.observed()
    }
    var body: some View {
        return VStack(alignment: .center) {
            Text("Subscribe").padding()
            subscriber.subscribedVideo(play: $play) { given in
                switch given.event {
                case .Connect_Success:
                    subscriber.sendBroadcastMessage("Hello!")
                default: break
                }
            }.aspectRatio(16/9, contentMode: .fit)
            Button(action: { play = !play }) {
                Text(play ? "Stop" : "Play")
            }.padding()
        }
    }
}

struct SubscribeView_Previews: PreviewProvider {
    static var previews: some View {
        SubscribeView()
    }
}
