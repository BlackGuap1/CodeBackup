//
//  Array+Identifiable.swift
//  Memorize
//
//  Created by Guap1 on 2020/11/27.
//

import Foundation

// 使用extension 扩充func
extension Array where Element: Identifiable {
    // of 和 elemnt都是变量名，一个在外部使用(of)，一个在函数内部使用(elemnt)
    // external name & internal name
    // exm:  func firstIndex(_ element: Element) -> Int
    func firstIndex(matching: Element) -> Int {
        for index in 0..<self.count {
            if self[index].id == matching.id {
                return index
            }
        }
        return 0 // TODO: bogus!
    }
}
