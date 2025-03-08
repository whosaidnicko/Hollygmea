//
//  ReminderDelay.swift
//  Hollygmea
//

import SwiftUI

enum ReminderDelay: Int16, CaseIterable {
    case none
    case oneHour
    case twoHours
    case threeHours
    case sixHours
    
    var title: String {
        switch self {
        case .none: "NONE"
        case .oneHour: "BEFORE 1 HOUR"
        case .twoHours: "BEFORE 2 HOURS"
        case .threeHours: "BEFORE 3 HOURS"
        case .sixHours: "BEFORE 6 HOURS"
        }
    }
    
    static let pickerCases: [ReminderDelay] = [.oneHour, .twoHours, .threeHours, .sixHours]
}
