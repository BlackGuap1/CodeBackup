//
//  Grid.swift
//  Memorize
//
//  Created by Guap1 on 2020/11/27.
//

import SwiftUI

struct Grid<Item, ItemView>: View where Item: Identifiable, ItemView: View{
    var items: [Item]
    var viewForItem: (Item) -> ItemView
    
    init(_ items: [Item], viewForItem: @escaping (Item) -> ItemView) {
        self.items = items
        self.viewForItem = viewForItem
    }
    
    var body: some View {
        GeometryReader { geometry in
            let layout = GridLayout(itemCount: items.count, in: geometry.size)
            ForEach(items) { item in
                self.viewForItem(item)
                    .frame(width: layout.itemSize.width, height: layout.itemSize.height)
                    .position(layout.location(ofItemAt: items.firstIndex(matching: item)))
            }
        }
    }
}
