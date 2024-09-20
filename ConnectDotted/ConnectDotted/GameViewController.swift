//
//  GameViewController.swift
//  ConnectDotted
//
//  Created by Parameswaran on 19/09/24.
//

import UIKit

class GameViewController: UIViewController {

    var dotsGameView: DotsGameView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Create and add DotsGameView to the view
        dotsGameView = DotsGameView(frame: self.view.bounds)
        dotsGameView.backgroundColor = .white
        self.view.addSubview(dotsGameView)

        // Create a reset button
        let resetButton = UIButton(frame: CGRect(x: 20, y: self.view.bounds.height - 80, width: 100, height: 50))
        resetButton.setTitle("Reset", for: .normal)
        resetButton.backgroundColor = .systemBlue
        resetButton.addTarget(self, action: #selector(resetGame), for: .touchUpInside)
        self.view.addSubview(resetButton)
    }

    @objc func resetGame() {
        dotsGameView.resetGame()
    }
}
