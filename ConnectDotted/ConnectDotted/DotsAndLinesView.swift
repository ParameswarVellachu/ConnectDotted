//
//  DotsAndLinesView.swift
//  ConnectDotted
//
//  Created by Parameswaran on 19/09/24.
//

import UIKit

class DotsAndLinesView: UIView {

    // Store the positions of the dots
    private var dotCenters: [CGPoint] = []

    // Store lines (connections between dots)
    private var lines: [(CGPoint, CGPoint)] = []

    // Add a new dot at a given position
    func addDot(at position: CGPoint) {
        dotCenters.append(position)
        setNeedsDisplay() // Redraw the view with the new dot
    }

    // Connect the last dot with the new one
    func connectLastDot() {
        guard dotCenters.count >= 2 else { return }
        let lastDot = dotCenters[dotCenters.count - 2]
        let newDot = dotCenters[dotCenters.count - 1]
        lines.append((lastDot, newDot))
        setNeedsDisplay() // Redraw the view with the new line
    }

    // Clear all dots and lines
    func clearDotsAndLines() {
        dotCenters.removeAll()
        lines.removeAll()
        setNeedsDisplay() // Redraw the view
    }

    // Draw the dots and lines
    override func draw(_ rect: CGRect) {
        super.draw(rect)

        // Draw dots
        let dotRadius: CGFloat = 10.0
        UIColor.red.setFill()
        for dotCenter in dotCenters {
            let dotRect = CGRect(x: dotCenter.x - dotRadius, y: dotCenter.y - dotRadius, width: dotRadius * 2, height: dotRadius * 2)
            let dotPath = UIBezierPath(ovalIn: dotRect)
            dotPath.fill()
        }

        // Draw lines
        UIColor.blue.setStroke()
        let linePath = UIBezierPath()
        for (startPoint, endPoint) in lines {
            linePath.move(to: startPoint)
            linePath.addLine(to: endPoint)
        }
        linePath.lineWidth = 2.0
        linePath.stroke()
    }
}

