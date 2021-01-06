//
//  PublishView.swift
//  RTS-iOS-Simple-Player
//
//  Created by Virgil Prewitt on 1/6/21.
//

import Foundation
import SwiftUI
import LLNW_RTS

struct PublishView: View {
    var publisher: LLPublisher
    @ObservedObject var opts: LLObservedOptions
    @State var publish = false
    
    init() {
        // A) initialize with no options
        publisher = LLNW_RTS.Publisher()
        // B) or initialize with options
        let options = LLNW_RTS.Options()
        options.publishURL = "your-given-publish-url"
        options.rendition = "your-rendition"
        options.username = "your-username"
        options.password = "your-password"
        options.camera = "front"
        publisher = LLNW_RTS.Publisher(options: options)
        // C) or initialize and save with UserDefaults
        publisher = LLNW_RTS.Publisher(
            options: LLNW_RTS.Options(
                settings: UserDefaults.standard,
                key: "Publisher 123"
            )
        )
        // assign observable options if needed
        opts = publisher.observed()
    }
    var body: some View {
        return VStack(alignment: .center) {
            Text("Publish").padding()
            // add renderer with given account and stream (updated with state)
            publisher.publishedVideo(publish: $publish) { given in
                switch given.event {
                case .Connect_Success:
                    publisher.sendPublisherMessage("Hello!")
                default: break
                }
            }.modifier(Ratio16x9())
            Button(action: { publish = !publish }) {
                Text(publish ? "End" : "Publish")
            }.padding()
        }
    }
}

struct PublishView_Previews: PreviewProvider {
    static var previews: some View {
        PublishView()
    }
}
