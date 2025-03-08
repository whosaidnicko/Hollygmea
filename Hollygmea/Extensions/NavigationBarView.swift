//
//  NavigationBarView.swift
//  HollywoodSports
//

import SwiftUI

struct NavigationBarView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    let title: String
    let showBackButton: Bool
    
    var body: some View {
        HStack(alignment: .top, spacing: 16.flexible()) {
            if showBackButton {
                Button {
                    dismiss()
                } label: {
                    Image(.backButton)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20.flexible(), height: 20.flexible())
                }
            }
            
            Text(title.uppercased())
                .font(.montserrat(18.flexible(), weight: .bold))
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity, alignment: .center)
                .multilineTextAlignment(.center)
                .fixedSize(horizontal: false, vertical: true)
            
            if showBackButton {
                Rectangle()
                    .fill(.clear)
                    .frame(width: 20.flexible())
            }
        }
        .padding(.horizontal, 16.flexible())
        .padding(.top, 24.flexible())
    }
}

struct NavigationBarViewModifiers: ViewModifier {
    
    let title: String
    let showBackButton: Bool
    
    func body(content: Content) -> some View {
        VStack(spacing: 4.flexible()) {
            NavigationBarView(title: title, showBackButton: showBackButton)
            
            content
                .frame(maxHeight: .infinity)
                .layoutPriority(1)
            
            Spacer(minLength: 0)
        }
        .toolbar(.hidden, for: .navigationBar)
    }
}

extension View {
    func navigationContent(_ title: String, showBackButton: Bool = false) -> some View {
        modifier(NavigationBarViewModifiers(title: title, showBackButton: showBackButton))
    }
}
