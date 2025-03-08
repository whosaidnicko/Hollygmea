//
//  CalendarManager.swift
//  Hollygmea
//

import SwiftUI

final class CalendarManager: ObservableObject {
    
    let calendar = Calendar.current
    @Published var selectedDay: Date = Date()
    @Published private var previousMonthDays: [Date] = []
    @Published private var selectedMonthDays: [Date] = []
    @Published private var nextMonthDays: [Date] = []
    
    var calendarDays: [Date] {
        previousMonthDays + selectedMonthDays + nextMonthDays
    }
    
    init() {
        getSelectedMonthDays()
    }
    
    func selectDate(_ date: Date) {
        selectedDay = date
        getSelectedMonthDays()
    }
    
    func showNextMonth() {
        selectedDay = calendar.date(byAdding: .month, value: 1, to: selectedDay)!
        getSelectedMonthDays()
    }
    
    func showPreviousMonth() {
        selectedDay = calendar.date(byAdding: .month, value: -1, to: selectedDay)!
        getSelectedMonthDays()
    }
    
    func getSelectedMonthDays() {
        guard let range = calendar.range(of: .day, in: .month, for: selectedDay),
              let startOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: selectedDay)) else {
            return
        }
        
        // Определяем день недели первого дня месяца (1 - воскресенье, 2 - понедельник, ..., 7 - суббота)
        let firstWeekday = calendar.component(.weekday, from: startOfMonth)
        
        // Если 1 число месяца выпадает на понедельник (то есть firstWeekday == 2), то берем 7 дней из предыдущего месяца
        let daysInPreviousMonth: Int
        if firstWeekday == 2 {
            daysInPreviousMonth = 7
        } else {
            // В противном случае, количество дней зависит от дня недели
            daysInPreviousMonth = (firstWeekday - calendar.firstWeekday + 7) % 7
        }
        
        // Определяем первый день предыдущего месяца
        let previousMonthStart = calendar.date(byAdding: .day, value: -daysInPreviousMonth, to: startOfMonth)!
        
        // Формируем массив дней предыдущего месяца
        previousMonthDays = (0..<daysInPreviousMonth).compactMap { day -> Date? in
            return calendar.date(byAdding: .day, value: day, to: previousMonthStart)
        }
        
        // Формируем массив дней текущего месяца
        selectedMonthDays = range.compactMap { day -> Date? in
            return calendar.date(byAdding: .day, value: day - 1, to: startOfMonth)
        }
        
        // Определяем, сколько дней нужно взять из следующего месяца, чтобы в сумме получилось 42 дня
        let totalDays = previousMonthDays.count + selectedMonthDays.count
        let nextMonthDaysNeeded = 42 - totalDays
        
        // Первый день следующего месяца
        let nextMonthStart = calendar.date(byAdding: .day, value: selectedMonthDays.count, to: startOfMonth)!
        
        // Формируем массив дней следующего месяца
        nextMonthDays = (0..<nextMonthDaysNeeded).compactMap { day -> Date? in
            return calendar.date(byAdding: .day, value: day, to: nextMonthStart)
        }
    }
}
