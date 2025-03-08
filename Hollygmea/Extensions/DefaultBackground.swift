//
//  DefaultBackground.swift
//  HollywoodSports
//

import SwiftUI

struct DefaultBackground: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .background(alignment: .center) {
                Color.lightPurple
                    .ignoresSafeArea()
                Image(.backgroundPrimary)
                    .resizable()
                    .ignoresSafeArea(edges: .bottom)
            }
    }
}

extension View {
    public func setDefaultBackground() -> some View {
        modifier(DefaultBackground())
    }
}
