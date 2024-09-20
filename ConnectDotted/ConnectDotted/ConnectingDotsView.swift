//
//  ConnectingDotsView.swift
//  ConnectDotted
//
//  Created by Parameswaran on 18/09/24.
//

import UIKit

class ConnectingDotsView: UIView {
    // Array of points (dots) to connect
    var points: [CGPoint] = [
        CGPoint(x: 250, y: 250),
        CGPoint(x: 100, y: 150),
        CGPoint(x: 200, y: 100),
        CGPoint(x: 250, y: 200)
    ]
    
    // Custom dot and line appearance
    var dotColor: UIColor = .red
    var lineColor: UIColor = .blue
    var dotRadius: CGFloat = 5.0
    var lineWidth: CGFloat = 2.0
    
    override func draw(_ rect: CGRect) {
        // Draw lines between the points
        if points.count > 1 {
            let path = UIBezierPath()
            path.lineWidth = lineWidth
            lineColor.setStroke()
            
            for (index, point) in points.enumerated() {
                if index == 0 {
                    path.move(to: point)
                } else {
                    path.addLine(to: point)
                }
            }
            path.stroke()
        }
        
        // Draw dots at each point
        for point in points {
            let dotPath = UIBezierPath(arcCenter: point, radius: dotRadius, startAngle: 0, endAngle: CGFloat.pi * 2, clockwise: true)
            dotColor.setFill()
            dotPath.fill()
        }
    }
}
