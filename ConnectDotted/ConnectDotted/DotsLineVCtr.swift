//
//  DotsLineVCtr.swift
//  ConnectDotted
//
//  Created by Parameswaran on 19/09/24.
//

import UIKit

class DotsLineVCtr: UIViewController {

    var dotsAndLinesView: DotsAndLinesView!
    var currentDotIndex: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create and add the custom DotsAndLinesView
        dotsAndLinesView = DotsAndLinesView(frame: CGRect(x: 20, y: 100, width: view.bounds.width - 40, height: view.bounds.width - 40))
        dotsAndLinesView.backgroundColor = .yellow
        view.addSubview(dotsAndLinesView)
        
        // Add a gesture recognizer to handle touch events
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        dotsAndLinesView.addGestureRecognizer(tapGesture)

        // Add a button to clear all dots and lines
        let clearButton = UIButton(type: .system)
        clearButton.frame = CGRect(x: 290, y: view.bounds.height - 200, width: 100, height: 50)
        clearButton.setTitle("Clear", for: .normal)
        clearButton.addTarget(self, action: #selector(clearDotsAndLines), for: .touchUpInside)
        view.addSubview(clearButton)
    }

    // Action to clear all dots and lines
    @objc func clearDotsAndLines() {
        dotsAndLinesView.clearDotsAndLines()
        currentDotIndex = 0
    }
    
    @objc private func handleTap(_ gesture: UITapGestureRecognizer) {
        let touchPoint = gesture.location(in: dotsAndLinesView)
        print("Tap at: \(touchPoint)")
        
        dotsAndLinesView.addDot(at: CGPoint(x: touchPoint.x, y: touchPoint.y))
        currentDotIndex += 1
        dotsAndLinesView.connectLastDot()
        
    }
}



