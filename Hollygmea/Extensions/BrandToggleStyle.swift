//
//  BrandToggleStyle.swift
//  HollywoodSports
//

import SwiftUI

struct BrandToggleStyle: ToggleStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.label
            
            Spacer()

            RoundedRectangle(cornerRadius: .infinity, style: .continuous)
                .fill(.lightPurple)
                .frame(width: 40.flexible(), height: 20.flexible())
                .overlay(alignment: configuration.isOn ? .trailing : .leading) {
                    Circle()
                        .fill(configuration.isOn ? .toggleGreen : .white)
                        .animation(.easeInOut, value: configuration.isOn)
                }
                .onTapGesture {
                    withAnimation {
                        configuration.isOn.toggle()
                    }
                }
        }
    }
}
