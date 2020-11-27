//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Guap1 Gao on 2020/10/31.
//

// It is a file defined as ViewModel

import SwiftUI

// ObservableObject EmojiMemoryGame类实现的协议
class EmojiMemoryGame: ObservableObject {
    // 对于函数中声明但是在实现时不需要用到的参数，用_代替，在实现中不用显示声明
    // 声明Published 来保证每一次model的修改都会发布，即调用objectWillChange.send()
    @Published private(set) var model: MemoryGame<String> = EmojiMemoryGame.createMemoryGame()
        
    static func createMemoryGame() -> MemoryGame<String> {
        let emojis: Array<String> = ["👻", "🎃", "🕸"]
        return MemoryGame<String>(numberOfPairsOfCards: emojis.count) { pairIndex in
            return emojis[pairIndex]
        }
    }
    
    // 实现ObservableObject协议 会获得一个变量objectWillChange 隐式获得
    //var objectWillChange: ObservableObjectPublisher
        
    // MARK: - Access to the Model
    var cards: Array<MemoryGame<String>.Card> {
        model.cards
    }
    
    // MARK: - Intent(s) action of views
    
    func choose(card: MemoryGame<String>.Card) {
        //objectWillChange.send()
        model.choose(card: card)
    }
}
