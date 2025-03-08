//
//  NewsDetailView.swift
//  HollywoodSports
//

import SwiftUI

struct NewsDetailView: View {
    
    let news: NewsModel
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            Text(news.content)
                .font(.montserrat(16.flexible(), weight: .medium))
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity, alignment: .leading)
                .multilineTextAlignment(.leading)
                .padding(.all, 16.flexible())
                .background {
                    RoundedRectangle(cornerRadius: 16.flexible(), style: .continuous)
                        .fill(.darkPurple)
                }
                .padding(.all, 16.flexible())
            
            Spacer()
        }
        .navigationContent(news.title, showBackButton: true)
        .setDefaultBackground()
    }
}
