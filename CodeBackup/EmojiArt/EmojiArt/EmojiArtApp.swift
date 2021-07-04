//
//  EmojiArtApp.swift
//  EmojiArt
//
//  Created by Guap1 on 2020/12/27.
//

import SwiftUI

@main
struct EmojiArtApp: App {
    var body: some Scene {
        WindowGroup {
            EmojiArtDocumentView(document: EmojiArtDocument())
        }
    }
}
