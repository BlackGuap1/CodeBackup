//
//  FireWork.swift
//  Memorize
//
//  Created by Guap1 on 2020/12/12.
//

import SwiftUI

struct FireWork: Shape {
    var fireWorkPercent: Double = 0

    var animatableData: Double {
        set {
            fireWorkPercent = newValue
        }
        get {
            return fireWorkPercent
        }
    }

    private func calEndPoint(sPoint: CGPoint, ePoint: CGPoint, percent: CGFloat) -> CGPoint {
        let xd = ePoint.x - sPoint.x
        let yd = ePoint.y - sPoint.y
        let ret = CGPoint(
            x: sPoint.x + percent * xd,
            y: sPoint.y + percent * yd
        )
        return ret
    }
    
    func path(in rect: CGRect) -> Path {
        let wid: CGFloat = 10
        let startPoint = CGPoint(x: rect.midX, y: rect.maxY - rect.height/5)
        var endPoints: Array<CGPoint> = Array<CGPoint>()
        for index in 0...5 {
            let p = CGPoint(x: rect.minX + rect.width/5*CGFloat(index), y: rect.minY)
            endPoints.append(calEndPoint(sPoint: startPoint, ePoint: p, percent: CGFloat(fireWorkPercent)))
        }
        
        var p = Path()
        
        p.move(to: startPoint)
        for index in 0...5 {
            p.addLine(to: endPoints[index])
            p.addLine(to: CGPoint(x: endPoints[index].x+wid, y: endPoints[index].y))
            p.addLine(to: startPoint)
        }

        return p
    }
}
