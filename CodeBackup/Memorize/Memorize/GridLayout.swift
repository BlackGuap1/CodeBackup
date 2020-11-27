//
//  GridLayout.swift
//  Memorize
//
//  Created by Guap1 on 2020/11/27.
//

import SwiftUI

struct GridLayout{
    var size: CGSize
    var rowCount: Int = 0
    var columnCount: Int = 0
    
    init(itemCount: Int, nearAspectRadio desireAspectRadio: Double = 1, in size: CGSize) {
        self.size = size
        let lebe = size.height > size.width ? size.width : size.height
        rowCount = Int(lebe) / itemCount
        columnCount = Int(lebe) / itemCount
        // temporary op
        itemSize = size
    }
    
    var itemSize: CGSize
    
    func location(ofItemAt index: Int) -> CGPoint {
        let ret = CGPoint()
        return ret
    }
}
