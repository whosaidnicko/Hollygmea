//
//  NewsCardView.swift
//  HollywoodSports
//

import SwiftUI

struct NewsCardView: View {
    
    let news: NewsModel
    
    var body: some View {
        HStack(spacing: 12.flexible()) {
            VStack(spacing: 2.flexible()) {
                Text(news.title.uppercased())
                    .font(.montserrat(16.flexible(), weight: .bold))
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .multilineTextAlignment(.leading)
                
                Text(news.content)
                    .font(.montserrat(14.flexible(), weight: .medium))
                    .foregroundStyle(.white.opacity(0.72))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .multilineTextAlignment(.leading)
                    .lineLimit(3)
            }
            
            Image(.forwardButton)
                .resizable()
                .scaledToFit()
                .frame(width: 24.flexible(), height: 20.flexible())
        }
        .padding(.all, 16.flexible())
        .background {
            RoundedRectangle(cornerRadius: 16.flexible(), style: .continuous)
                .fill(.darkPurple)
        }
    }
}
