//
//  DotsAndLinesViewType1.swift
//  ConnectDotted
//
//  Created by Parameswaran on 19/09/24.
//

import UIKit

class DotsAndLinesViewType1: UIView {

    private var dots: [CGPoint] = []

        // Add dot to the array and redraw
        func addDot(at point: CGPoint) {
            dots.append(point)
            setNeedsDisplay()
        }

        override func draw(_ rect: CGRect) {
            guard let context = UIGraphicsGetCurrentContext() else { return }

            // Draw dots
            context.setFillColor(UIColor.blue.cgColor)
            for dot in dots {
                context.fillEllipse(in: CGRect(x: dot.x - 5, y: dot.y - 5, width: 10, height: 10))
            }

            // Draw lines
            context.setStrokeColor(UIColor.red.cgColor)
            context.setLineWidth(2)
            if dots.count > 1 {
                context.beginPath()
                context.move(to: dots.first!)
                for dot in dots.dropFirst() {
                    context.addLine(to: dot)
                }
                context.strokePath()
            }
        }
}
