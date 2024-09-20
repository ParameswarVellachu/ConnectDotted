//
//  DotsGameView.swift
//  ConnectDotted
//
//  Created by Parameswaran on 19/09/24.
//

import UIKit

class DotsGameView: UIView {
    
    // Define the positions of the dots
    private var dotCenters: [CGPoint] = []
    
    // Array to track the lines drawn by the player
    private var lines: [CGPoint] = []
    
    // Predefined correct order to connect the dots
    private var correctOrder: [Int] = []
    
    // Track if the player is following the correct order
    private var currentStep: Int = 0
    
    // Define whether the game is completed
    private var gameCompleted: Bool = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupDots()
        setupCorrectOrder()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupDots()
        setupCorrectOrder()
    }
    
    // Setup the dot positions and store them
    private func setupDots() {
        let numberOfRows = 7
        let numberOfCols = 3
        let spacing: CGFloat = self.bounds.width / 4
        
        for row in 0..<numberOfRows {
            for col in 0..<numberOfCols {
                let x = spacing + CGFloat(col) * spacing
                let y = spacing + CGFloat(row) * spacing
                dotCenters.append(CGPoint(x: x, y: y))
            }
        }
        setNeedsDisplay()
    }
    
    // Setup the correct order of dots to connect
    private func setupCorrectOrder() {
        // The correct order (e.g., top-left, top-middle, top-right, bottom-right, etc.)
        correctOrder = [0, 1, 3, 5, 7] // This is just an example order
    }
    
    // Draw the dots and lines
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let dotRadius: CGFloat = 20.0
        
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
        
        // Show a "Game Completed" message
        if gameCompleted {
            let completedMessage = "Game Completed!"
            let attributes: [NSAttributedString.Key: Any] = [
                .font: UIFont.boldSystemFont(ofSize: 30),
                .foregroundColor: UIColor.green
            ]
            let textSize = completedMessage.size(withAttributes: attributes)
            let textRect = CGRect(x: (rect.width - textSize.width) / 2, y: (rect.height - textSize.height) / 2, width: textSize.width, height: textSize.height)
            completedMessage.draw(in: textRect, withAttributes: attributes)
        }
    }
    
    // Handle touches to connect dots
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        
        if let nearestDotIndex = findNearestDotIndex(to: location) {
            // Check if the player is following the correct order
            if nearestDotIndex == correctOrder[currentStep] {
                lines.append(dotCenters[nearestDotIndex])
                currentStep += 1
                
                // Check if game is completed
                if currentStep == correctOrder.count {
                    gameCompleted = true
                }
                setNeedsDisplay()
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        
        if let nearestDotIndex = findNearestDotIndex(to: location), !lines.contains(dotCenters[nearestDotIndex]) {
            if nearestDotIndex == correctOrder[currentStep] {
                lines.append(dotCenters[nearestDotIndex])
                currentStep += 1
                
                // Check if game is completed
                if currentStep == correctOrder.count {
                    gameCompleted = true
                }
                setNeedsDisplay()
            }
        }
    }
    
    // Helper function to find the nearest dot index
    private func findNearestDotIndex(to point: CGPoint) -> Int? {
        let maxDistance: CGFloat = 30.0
        for (index, dot) in dotCenters.enumerated() {
            if distance(from: dot, to: point) <= maxDistance {
                return index
            }
        }
        return nil
    }
    
    // Helper function to calculate distance between two points
    private func distance(from pointA: CGPoint, to pointB: CGPoint) -> CGFloat {
        return sqrt(pow(pointA.x - pointB.x, 2) + pow(pointA.y - pointB.y, 2))
    }
    
    // Method to reset the game
    func resetGame() {
        lines.removeAll()
        currentStep = 0
        gameCompleted = false
        setNeedsDisplay()
    }
}
