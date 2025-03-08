//
//  NewsView.swift
//  HollywoodSports
//

import SwiftUI

struct NewsView: View {
    
    let news: [NewsModel] = [
        .init(
            title: "Usain Bolt Hints at Comeback",
            content: "Sprinting legend Usain Bolt has teased a possible return to the track. In a recent interview, the eight-time Olympic gold medalist stated that he still feels the urge to compete and might consider training again. While no official plans have been announced, fans are eagerly speculating about his potential comeback."
        ),
        .init(
            title: "Cristiano Ronaldo Sets New Scoring Record",
            content: "Portuguese football star Cristiano Ronaldo has broken another record, becoming the top scorer in international football history. With his latest goal in a friendly match, Ronaldo surpassed the previous record of 118 goals. The 39-year-old continues to dominate the sport despite his age, proving his unmatched consistency."
        ),
        .init(
            title: "NBA All-Star Game Sees Highest-Scoring Match Ever",
            content: "The 2025 NBA All-Star Game broke records with a staggering 387 total points scored between both teams. Fans were thrilled by the offensive showcase, with multiple players hitting over 40 points each. The game has sparked debates on whether the event should introduce a stronger defensive element."
        ),
        .init(
            title: "Simone Biles Wins Another Gold at World Championships",
            content: "Gymnastics icon Simone Biles added another gold medal to her collection at the World Championships. Her flawless routine on the balance beam earned her a near-perfect score, reaffirming her status as the greatest gymnast of all time. At 27, Biles shows no signs of slowing down."
        ),
        .init(
            title: "Formula 1 Introduces New Sprint Race Format",
            content: "Formula 1 has announced a revised sprint race format for the upcoming season. The changes aim to make the shorter races more competitive, with adjustments to tire regulations and grid positioning. Fans and drivers have expressed mixed reactions, but F1 officials believe it will add more excitement to race weekends."
        )
    ]
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 4.flexible()) {
                ForEach(news, id: \.self) { news in
                    NavigationLink(destination: NewsDetailView(news: news)) {
                        NewsCardView(news: news)
                    }
                }
            }
            .padding(.horizontal, 16.flexible())
            .padding(.vertical, 24.flexible())
        }
        .padding(.top, 1)
    }
}

#Preview {
    NewsView()
}
