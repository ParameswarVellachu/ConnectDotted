//
//  DotConnectingView.swift
//  ConnectDotted
//
//  Created by Parameswaran on 18/09/24.
//

import UIKit

class DotConnectingView: UIView {
    // Store the points where the user touches
    private var points: [CGPoint] = []
    private var shapeLayer: CAShapeLayer!

    // Override touchesBegan to detect the user's touch
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let point = touch.location(in: self)
            points.append(point)
            drawLines()
        }
    }

    // Draw lines between dots
    private func drawLines() {
        // Remove the previous shape layer if it exists
        shapeLayer?.removeFromSuperlayer()

        let path = UIBezierPath()

        // Draw lines between each point
        for (index, point) in points.enumerated() {
            if index == 0 {
                path.move(to: point)
            } else {
                path.addLine(to: point)
            }
        }

        // Create the shape layer
        shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.strokeColor = UIColor.red.cgColor
        shapeLayer.lineWidth = 2.0

        // Add the shape layer to the view
        layer.addSublayer(shapeLayer)
    }
}
