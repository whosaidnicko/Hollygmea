//
//  TabBarItem.swift
//  HollywoodSports
//

import SwiftUI

enum TabBarItem: Int, CaseIterable {
    case calendar
    case statistic
    case news
    case profile
    
    var title: String {
        switch self {
        case .calendar: "CALENDAR"
        case .statistic: "STATISTIC"
        case .news: "NEWS"
        case .profile: "PROFILE"
        }
    }
    
    var icon: ImageResource {
        switch self {
        case .calendar: .calendarTab
        case .statistic: .statisticTab
        case .news: .newsTab
        case .profile: .profileTab
        }
    }
}
