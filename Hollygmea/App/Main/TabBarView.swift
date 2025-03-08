//
//  TabBarView.swift
//  HollywoodSports
//

import SwiftUI

struct TabBarView: View {
    
    @StateObject var profileVM: ProfileViewModel = .init()
    @StateObject var calendarManager: CalendarManager = .init()
    
    @State private var selectedTab: TabBarItem = .calendar
    
    var body: some View {
        VStack(spacing: 0) {
            
            switch selectedTab {
            case .calendar: CalendarView(manager: calendarManager)
            case .statistic: StatisticView(manager: calendarManager)
            case .news: NewsView()
            case .profile: ProfileView(vm: profileVM)
            }
            
            Spacer(minLength: 0)
            
            tabBar
        }
        .ignoresSafeArea(edges: .bottom)
        .setDefaultBackground()
        .background()
        .toolbar(.hidden, for: .navigationBar)
    }
    
    var tabBar: some View {
        HStack(spacing: 8.flexible()) {
            ForEach(TabBarItem.allCases, id: \.self) { item in
                VStack(spacing: 6.flexible()) {
                    Image(item.icon)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 36.flexible(), height: 36.flexible())
                    
                    Text(item.title)
                        .font(.montserrat(12.flexible(), weight: .semibold))
                        .foregroundStyle(.white)
                }
                .frame(maxWidth: .infinity)
                .contentShape(.rect)
                .opacity(item == selectedTab ? 1 : 0.5)
                .onTapGesture {
                    vibrate()
                    selectedTab = item
                }
            }
        }
        .frame(height: 90.flexible())
        .padding(.horizontal, 16.flexible())
        .padding(.bottom, 10.flexible())
        .background(.lightPurple)
        .clipShape(
            .rect(
                topLeadingRadius: 16.flexible(),
                topTrailingRadius: 16.flexible(),
                style: .continuous
            )
        )
    }
}

#Preview {
    NavigationStack {
        TabBarView()
    }
}
