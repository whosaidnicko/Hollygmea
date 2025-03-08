//
//  Adaptive.swift
//  HollywoodSports
//

import Foundation
import UIKit

extension Int {
    func flexible(_ scale: Double = 1.5) -> CGFloat {
        let screenHeight = UIScreen.main.bounds.height
        if screenHeight > 800 {
            return CGFloat(self) * (screenHeight / 852)
        } else {
            return CGFloat(self) * (screenHeight / 736)
        }
    }
}

extension UIScreen {
    
    static let screenWidth = UIScreen.main.bounds.size.width
    static let screenHeight = UIScreen.main.bounds.size.height
}
