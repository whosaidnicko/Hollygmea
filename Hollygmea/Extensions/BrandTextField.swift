//
//  BrandTextField.swift
//  HollywoodSports
//

import SwiftUI

struct BrandTextField: View {
    
    let placeholder: String
    @Binding var text: String
    
    var body: some View {
        TextField(placeholder, text: $text)
            .font(.montserrat(15.flexible(), weight: .bold))
            .foregroundStyle(.white)
            .autocorrectionDisabled()
            .textInputAutocapitalization(.never)
            .lineLimit(1)
            .frame(height: 52.flexible())
            .padding(.horizontal, 16.flexible())
            .background {
                RoundedRectangle(cornerRadius: 8.flexible(), style: .continuous)
                    .fill(.lightPurple)
            }
    }
}
