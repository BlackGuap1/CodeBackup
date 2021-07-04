//
//  OptionalImage.swift
//  EmojiArt
//
//  Created by Guap1 on 2021/1/17.
//

import SwiftUI

struct OptionalImage: View {
    var uiImage: UIImage?
    
    var body: some View {
        Group {
            if uiImage != nil
            {
               Image(uiImage: uiImage!)
            }
        }
    }
}
