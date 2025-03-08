//
//  Font+Extension.swift
//  HollywoodSports
//

import SwiftUI

extension Font {
    
    static func montserrat(_ size: CGFloat, weight: Font.Weight = .regular) -> Font {
        Font.custom("Montserrat", size: size).weight(weight)
    }
}
