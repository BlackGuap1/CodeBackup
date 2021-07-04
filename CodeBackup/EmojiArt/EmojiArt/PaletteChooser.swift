//
//  PaletteChooser.swift
//  EmojiArt
//
//  Created by Guap1 on 2021/1/24.
//

import SwiftUI

struct PaletteChooser: View {
    @ObservedObject var document: EmojiArtDocument
    
    // @Binding 所以不需要在此处初始化
    @Binding var chosenPalette: String
    
    var body: some View {
        HStack {
            Stepper(onIncrement: {
                self.chosenPalette = self.document.palette(after: self.chosenPalette)
            }, onDecrement: {
                self.chosenPalette = self.document.palette(before: self.chosenPalette)
            }, label: { EmptyView() })
            Text(self.document.paletteNames[self.chosenPalette] ?? "")
        }
            // .fixedSize view 被调整为只占据需要的空间，可选择 水平或垂直
            .fixedSize(horizontal: true, vertical: false)
    }
}


struct PaletteChooser_Previews: PreviewProvider{
    static var previews: some View{
        PaletteChooser(document: EmojiArtDocument(), chosenPalette: Binding.constant("")) // Binding的默认值
    }
}
