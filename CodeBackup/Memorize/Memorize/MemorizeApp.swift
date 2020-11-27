//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Guap1 Gao on 2020/10/25.
//

import SwiftUI

@main
struct MemorizeApp: App {
    let game = EmojiMemoryGame()
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(viewModel: game)
        }
    }
}
