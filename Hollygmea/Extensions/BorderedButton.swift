//
//  BorderedButton.swift
//  HollywoodSports
//

import SwiftUI

struct BorderedLabel: View {
    
    let title: String
    
    var body: some View {
        Text(title)
            .font(.montserrat(15.flexible(), weight: .bold))
            .foregroundStyle(.white)
            .frame(height: 44.flexible())
            .frame(maxWidth: .infinity)
            .background {
                RoundedRectangle(cornerRadius: 8.flexible(), style: .continuous)
                    .inset(by: 1)
                    .stroke(.white, lineWidth: 2)
            }
    }
}
