//
//  Cardifier.swift
//  Memorize
//
//  Created by Guap1 on 2020/12/9.
//

// a ViewModifier
import SwiftUI

//struct Cardifier: ViewModifier, Animatable {
struct Cardifier: AnimatableModifier {
    var rotation: Double
    
    init(isFaceUp: Bool) {
        rotation = isFaceUp ? 0 : 180
    }
    
    var isFaceUp: Bool {
        rotation < 90
    }
    
    //animation的对象
    //这里相当于rename ratation
    var animatableData: Double {
        get { return rotation }
        set { rotation = newValue }
    }
    
    func body(content: Content) -> some View {
        ZStack {
            Group {
                RoundedRectangle(cornerRadius: self.cornerTadius).fill(Color.white)
                RoundedRectangle(cornerRadius: 10.0).stroke(lineWidth: self.edgeLineWidth)
                content
            }
                .opacity(isFaceUp ? 1 : 0)
            RoundedRectangle(cornerRadius: 10.0).fill()
                .opacity(isFaceUp ? 0 : 1)
        }
            .rotation3DEffect(Angle.degrees(rotation), axis: (0, 1, 0))
    }
    
    // make codes more readable
    private let cornerTadius: CGFloat = 10
    private let edgeLineWidth: CGFloat = 3
}

extension View {
    func cardify(isFaceUp: Bool) -> some View {
        self.modifier(Cardifier(isFaceUp: isFaceUp))
    }
}
