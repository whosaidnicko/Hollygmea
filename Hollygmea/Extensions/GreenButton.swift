//
//  GreenButton.swift
//  HollywoodSports
//

import SwiftUI

enum ButtonSizeType {
    case small
    case medium
    case large
    
    var height: CGFloat {
        switch self {
        case .small: 44
        case .medium: 52
        case .large: 70
        }
    }
    
    var fontSize: Int {
        switch self {
        case .small: 15
        case .medium: 17
        case .large: 22
        }
    }
}

struct GreenButton: View {
    
    let icon: ImageResource?
    let title: String
    let size: ButtonSizeType
    let action: () -> Void
    
    init(icon: ImageResource? = nil, title: String, size: ButtonSizeType = .small, action: @escaping () -> Void) {
        self.icon = icon
        self.title = title
        self.size = size
        self.action = action
    }
    
    var body: some View {
        Button {
            vibrate()
            action()
        } label: {
            HStack(spacing: 8.flexible()) {
                if let icon {
                    Image(icon)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20.flexible(), height: 20.flexible())
                }
                
                Text(title)
                    .font(.montserrat(size.fontSize.flexible(), weight: .bold))
                    .foregroundStyle(.white)
            }
            .frame(height: size.height)
            .frame(maxWidth: .infinity)
            .background {
                RoundedRectangle(cornerRadius: 8, style: .continuous)
                    .fill(LinearGradient.horizontalGreen)
            }
        }
    }
}

func vibrate(style: UIImpactFeedbackGenerator.FeedbackStyle = .medium) {
    let generator = UIImpactFeedbackGenerator(style: style)
    generator.prepare()
    generator.impactOccurred()
}
