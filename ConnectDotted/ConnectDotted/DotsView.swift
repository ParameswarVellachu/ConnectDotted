//
//  DotsView.swift
//  ConnectDotted
//
//  Created by Parameswaran on 19/09/24.
//

import UIKit

class DotsView: UIView {
    
    // Array to store the positions of the dots
    private var dotCenters: [CGPoint] = []
    
    // Array to store the points for the lines
    private var lines: [CGPoint] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupDots()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupDots()
    }
    
    // Method to calculate the positions of the dots
    private func setupDots() {
        let numberOfRows = 3
        let numberOfCols = 3
        let spacing: CGFloat = self.bounds.width / 4
        
        for row in 0..<numberOfRows {
            for col in 0..<numberOfCols {
                let x = spacing + CGFloat(col) * spacing
                let y = spacing + CGFloat(row) * spacing
                dotCenters.append(CGPoint(x: x, y: y))
            }
        }
        setNeedsDisplay() // Redraw the view
    }
    
    // Override the draw function to render dots and lines
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let dotRadius: CGFloat = 15.0
        
        // Draw dots
        for dotCenter in dotCenters {
            let dotRect = CGRect(x: dotCenter.x - dotRadius, y: dotCenter.y - dotRadius, width: dotRadius * 2, height: dotRadius * 2)
            let dotPath = UIBezierPath(ovalIn: dotRect)
            UIColor.black.setFill()
            dotPath.fill()
        }
        
        // Draw lines
        if lines.count >= 2 {
            let linePath = UIBezierPath()
            linePath.move(to: lines.first!)
            
            for point in lines.dropFirst() {
                linePath.addLine(to: point)
            }
            
            UIColor.blue.setStroke()
            linePath.lineWidth = 3.0
            linePath.stroke()
        }
    }
    
    // Handle touch events to draw lines between dots
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        
        if let nearestDot = findNearestDot(to: location) {
            lines = [nearestDot]
            setNeedsDisplay()
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        
        if let nearestDot = findNearestDot(to: location), !lines.contains(nearestDot) {
            lines.append(nearestDot)
            setNeedsDisplay()
        }
    }
    
    // Find the nearest dot to the touch point
    private func findNearestDot(to point: CGPoint) -> CGPoint? {
        let maxDistance: CGFloat = 30.0
        for dot in dotCenters {
            if distance(from: dot, to: point) <= maxDistance {
                return dot
            }
        }
        return nil
    }
    
    // Calculate the distance between two points
    private func distance(from pointA: CGPoint, to pointB: CGPoint) -> CGFloat {
        return sqrt(pow(pointA.x - pointB.x, 2) + pow(pointA.y - pointB.y, 2))
    }
}
