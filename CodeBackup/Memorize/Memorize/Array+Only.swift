//
//  Array+Only.swift
//  Memorize
//
//  Created by Guap1 on 2020/11/27.
//

import Foundation

extension Array {
    var only: Element? {
        count == 1 ? first : nil
    }
}
