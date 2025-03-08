//
//  LinearGradient+Extension.swift
//  HollywoodSports
//

import SwiftUI

extension LinearGradient {
    
    public static let horizontalGreen = LinearGradient(
        colors: [.lightGreen, .darkGreen],
        startPoint: .leading,
        endPoint: .trailing
    )
    
    public static let horizontalGray = LinearGradient(
        colors: [.lightGray, .darkGray],
        startPoint: .leading,
        endPoint: .trailing
    )
}
