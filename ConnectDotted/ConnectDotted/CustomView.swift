//
//  CustomView.swift
//  ConnectDotted
//
//  Created by Parameswaran on 19/09/24.
//

import UIKit

class CustomView: UIView {

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let touchPoint = touch.location(in: self)
            print("Touch began at: \(touchPoint)")
        }
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let touchPoint = touch.location(in: self)
            print("Touch moved to: \(touchPoint)")
        }
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let touchPoint = touch.location(in: self)
            print("Touch ended at: \(touchPoint)")
        }
    }

    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let touchPoint = touch.location(in: self)
            print("Touch cancelled at: \(touchPoint)")
        }
    }
}
