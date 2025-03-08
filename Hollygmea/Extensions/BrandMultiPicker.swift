//
//  BrandMultiPicker.swift
//  HollywoodSports
//

import SwiftUI

struct BrandSinglePicker<T: Hashable, CellContent: View>: View {
    
    var items: [T]
    @Binding var selection: T
    @Binding var isOpen: Bool
    var title: String
    var content: (T) -> CellContent
    
    var body: some View {
        HStack(spacing: 10.flexible()) {
            Text(title)
                .font(.montserrat(15.flexible(), weight: .semibold))
                .foregroundStyle(.white.opacity(0.52))
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Image(.arrowDown)
                .resizable()
                .scaledToFit()
                .frame(height: 14.flexible())
                .foregroundStyle(.white.opacity(0.2))
                .rotationEffect(.degrees(isOpen ? 0 : -90))
        }
        .frame(height: 52.flexible())
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 16.flexible())
        .background {
            RoundedRectangle(cornerRadius: 8.flexible(), style: .continuous)
                .fill(.lightPurple)
        }
        .onTapGesture {
            UIApplication.shared.endEditing()
            withAnimation {
                isOpen.toggle()
            }
        }
        .overlay(alignment: .top) {
            if isOpen {
                VStack(spacing: 0) {
                    ForEach(items, id: \.self) { item in
                        
                        content(item)
                            .contentShape(.rect)
                            .onTapGesture {
                                selection = item
                                withAnimation {
                                    isOpen = false
                                }
                            }
                        
                        if item != items.last {
                            Rectangle()
                                .fill(.white.opacity(0.1))
                                .frame(height: 1)
                        }
                    }
                }
                .padding(.horizontal, 16.flexible())
                .padding(.vertical, 8.flexible())
                .background(.thinMaterial)
                .clipShape(.rect(cornerRadius: 10.flexible()))
                .padding(.top, 52.flexible())
                .background {
                    Color.clear
                        .contentShape(.rect)
                        .frame(width: UIScreen.screenWidth, height: 1500.flexible())
                        .onTapGesture {
                            withAnimation {
                                isOpen = false
                            }
                        }
                }
            }
        }
    }
}
