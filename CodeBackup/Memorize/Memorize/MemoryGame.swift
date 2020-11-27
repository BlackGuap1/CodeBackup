//
//  MemoryGame.swift
//  Memorize
//
//  Created by Guap1 Gao on 2020/10/31.
//

// It is a file defined as Model

import Foundation

struct MemoryGame<CardContent> {
    var cards: Array<Card>
    
    // self是只读的 添加mutating表明可以改变该类中的内容 对于struct需要这个声明 class不需要
    mutating func choose(card: Card) {
        print("lebe card cosen: \(card)")
        let chosenIndex: Int =  cards.firstIndex(matching: card)
        self.cards[chosenIndex].isFaceUp = !self.cards[chosenIndex].isFaceUp
    }
    
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = Array<Card>()
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content, id: pairIndex*2))
            cards.append(Card(content: content, id: pairIndex*2+1))
        }
    }
    
    // Identifiable标识符，表明对象有索引指向，协议
    struct Card: Identifiable {
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var content: CardContent
        var id: Int
    }
}
