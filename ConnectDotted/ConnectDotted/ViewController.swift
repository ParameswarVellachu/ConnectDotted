//
//  ViewController.swift
//  ConnectDotted
//
//  Created by Parameswaran on 18/09/24.
//

import UIKit

class ViewController: UIViewController {

    private let touchView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Set up the touchView
        touchView.frame = view.bounds
        touchView.backgroundColor = .clear
        view.addSubview(touchView)

        // Add a gesture recognizer to handle touch events
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        touchView.addGestureRecognizer(tapGesture)
    }

    @objc private func handleTap(_ gesture: UITapGestureRecognizer) {
        let touchPoint = gesture.location(in: touchView)
        print("Tap at: \(touchPoint)")
    }
}


