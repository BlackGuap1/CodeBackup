//
//  EmojiArt.swift
//  EmojiArt
//
//  Created by Guap1 on 2020/12/27.
//

import Foundation

struct EmojiArt: Codable {
    var backgroundURL: URL?
    // viewmodel 可以修改emoji的位置和size
    var emojis = [Emoji]()
    
    struct Emoji: Identifiable, Codable {
        let text: String
        var x: Int
        var y: Int
        var size: Int
        let id: Int
        
        // 保证id不会 被随意创建
        fileprivate init(text: String, x: Int, y: Int, size: Int, id: Int)
        {
            self.text = text
            self.x = x
            self.y = y
            self.size = size
            self.id = id
        }
    }
    
    var json: Data? {
        return try? JSONEncoder().encode(self)
    }
    
    init?(json: Data?) {
        if json != nil, let newEmojiArt = try? JSONDecoder().decode(EmojiArt.self, from: json!) {
            self = newEmojiArt
        }
        else {
            return nil
        }
    }
    
    // default init() func, because a customized init is defined above,so we have to declare the default one
    init() {}
    
    private var uniqueEmojiId = 0
    
    mutating func addEmoji(_ text: String, x: Int, y: Int, size: Int)
    {
        uniqueEmojiId += 1
        // 唯一创建emoji的地方
        emojis.append(Emoji(text: text, x: x, y: y, size: size, id: uniqueEmojiId))
    }
}
