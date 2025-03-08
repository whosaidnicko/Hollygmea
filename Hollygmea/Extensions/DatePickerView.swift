//
//  DatePickerView.swift
//  HollywoodSports
//

import SwiftUI

struct DatePickerView<Label: View>: View {
    
    @State private var popoverPresented: Bool = false
    
    @Binding var date: Date
    var minDate: Date = Calendar.current.date(from: DateComponents(year: 1920, month: 1, day: 1)) ?? Date()
    var maxDate: Date = Date.distantFuture
    var label: (Date) -> Label

    var body: some View {
        label(date)
            .contentShape(.rect)
            .onTapGesture {
                popoverPresented = true
            }
            .popover(isPresented: $popoverPresented, attachmentAnchor: .point(.center)) {
                DatePicker("", selection: $date, in: minDate...maxDate, displayedComponents: .date)
                    .labelsHidden()
                    .datePickerStyle(.graphical)
                    .frame(width: 320)
                    .presentationCompactAdaptation(.popover)
            }
    }
}

struct TimePickerView<Label: View>: View {
    
    @State private var popoverPresented: Bool = false
    
    @Binding var date: Date
    var label: (Date) -> Label

    var body: some View {
        label(date)
            .contentShape(.rect)
            .onTapGesture {
                popoverPresented = true
            }
            .popover(isPresented: $popoverPresented, attachmentAnchor: .point(.center)) {
                DatePicker("", selection: $date, displayedComponents: .hourAndMinute)
                    .labelsHidden()
                    .datePickerStyle(.wheel)
                    .frame(width: 300)
                    .presentationCompactAdaptation(.popover)
            }
    }
}
