//
//  ContentView.swift
//  Memorize
//
//  Created by Guap1 Gao on 2020/10/25.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    // 声明ObservedObject 订阅viemodel(ObservableObject)的修改动作，用于响应model的变化
    // swift会自动判断修改的内容来定向修改view
    @ObservedObject var viewModel: EmojiMemoryGame
    
    var body: some View {
        Grid(viewModel.cards) { card in
            CardView(card: card).aspectRatio(2/3, contentMode: .fit).onTapGesture {
                viewModel.choose(card: card)
            }
            .padding(5)
        }
            .padding()
            .foregroundColor(Color.orange)
    }
}

struct CardView: View {
    var card: MemoryGame<String>.Card
    var body: some View {
        GeometryReader (content: { geometry in
            ZStack {
                if self.card.isFaceUp {
                    RoundedRectangle(cornerRadius: self.cornerTadius).fill(Color.white)
                    RoundedRectangle(cornerRadius: 10.0).stroke(lineWidth: self.edgeLineWidth)
                    Text(self.card.content)
                } else {
                    RoundedRectangle(cornerRadius: 10.0).fill()
                }
            }
            .font(Font.system(size: min(geometry.size.width, geometry.size.height) * self.fontSizeRadio))
        })
    }
    
    
    // MARK: - Drawing Constents
    
    // make codes more readable
    let cornerTadius: CGFloat = 10
    let edgeLineWidth: CGFloat = 3
    let fontSizeRadio: CGFloat = 0.75
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiMemoryGameView(viewModel: EmojiMemoryGame())
    }
}
