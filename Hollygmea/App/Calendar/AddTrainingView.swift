//
//  AddTrainingView.swift
//  Hollygmea
//

import SwiftUI
import CoreData

struct AddTrainingView: View {
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.managedObjectContext) private var viewContext
    
    @State private var trainingTitle: String = ""
    @State private var repetitiveTraining: Bool = true
    @State private var weekdays: Set<Weekday> = []
    @State private var enableNotifications: Bool = true
    
    @State private var showReminderPicker: Bool = false
    @State private var selectedReminder: ReminderDelay = .oneHour
    
    @State var date: Date
    
    var body: some View {
        VStack {
            VStack(spacing: 24.flexible()) {
                VStack(spacing: 8.flexible()) {
                    BrandTextField(placeholder: "TRAINING TITLE", text: $trainingTitle)
                    
                    datePicker
                }
                
                VStack(spacing: 8.flexible()) {
                    Toggle(isOn: $repetitiveTraining) {
                        Text("REPETITIVE TRAINING")
                            .font(.montserrat(14.flexible(), weight: .heavy))
                            .foregroundStyle(.white)
                    }
                    .toggleStyle(BrandToggleStyle())
                    .simultaneousGesture(TapGesture().onEnded { _ in
                        UIApplication.shared.endEditing()
                    })
                    
                    if repetitiveTraining {
                        weekdaysView
                    }
                }
                
                VStack(spacing: 8.flexible()) {
                    Toggle(isOn: $enableNotifications) {
                        Text("ENABLE NOTIFICATIONS")
                            .font(.montserrat(14.flexible(), weight: .heavy))
                            .foregroundStyle(.white)
                    }
                    .toggleStyle(BrandToggleStyle())
                    .simultaneousGesture(TapGesture().onEnded { _ in
                        UIApplication.shared.endEditing()
                    })
                    
                    if enableNotifications {
                        BrandSinglePicker(
                            items: ReminderDelay.allCases,
                            selection: $selectedReminder,
                            isOpen: $showReminderPicker,
                            title: selectedReminder.title) { reminder in
                                Text(reminder.title)
                                    .font(.montserrat(15.flexible(), weight: .semibold))
                                    .foregroundStyle(.white.opacity(0.52))
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .frame(height: 44.flexible())
                            }
                    }
                }
                .zIndex(3)
                
                GreenButton(title: "SAVE TRAINING", size: .medium) {
                    saveNewTraining()
                }
                .disabled(trainingTitle.isEmpty)
            }
            .padding(.all, 16.flexible())
            .background {
                RoundedRectangle(cornerRadius: 16.flexible(), style: .continuous)
                    .fill(.darkPurple)
            }
            
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .padding(.all, 16.flexible())
        .navigationContent("NEW TRAINING", showBackButton: true)
        .setDefaultBackground()
    }
    
    var datePicker: some View {
        HStack(spacing: 8.flexible()) {
            DatePickerView(date: $date) { date in
                Text(date.formatted(.dateTime.month(.twoDigits).day(.twoDigits).year()))
                    .font(.montserrat(15.flexible(), weight: .semibold))
                    .foregroundStyle(.white)
                    .frame(height: 52.flexible())
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 16.flexible())
                    .background {
                        RoundedRectangle(cornerRadius: 8.flexible(), style: .continuous)
                            .fill(.lightPurple)
                    }
            }
            .simultaneousGesture(TapGesture().onEnded { _ in
                UIApplication.shared.endEditing()
            })
            
            TimePickerView(date: $date) { date in
                Text(date.formatted(.dateTime.hour(.twoDigits(amPM: .omitted)).minute(.twoDigits)))
                    .font(.montserrat(15.flexible(), weight: .semibold))
                    .foregroundStyle(.white)
                    .frame(width: 100.flexible(), height: 52.flexible())
                    .background {
                        RoundedRectangle(cornerRadius: 8.flexible(), style: .continuous)
                            .fill(.lightPurple)
                    }
            }
            .simultaneousGesture(TapGesture().onEnded { _ in
                UIApplication.shared.endEditing()
            })
        }
    }
    
    var weekdaysView: some View {
        HStack(spacing: 12.flexible()) {
            VStack(spacing: 6.flexible()) {
                weekdayCheckbox(.monday)
                weekdayCheckbox(.wednesday)
                weekdayCheckbox(.friday)
                weekdayCheckbox(.sunday)
            }
            VStack(spacing: 6.flexible()) {
                weekdayCheckbox(.tuesday)
                weekdayCheckbox(.thursday)
                weekdayCheckbox(.saturday)
                Spacer()
                    .frame(height: 16.flexible())
            }
        }
    }
    
    func weekdayCheckbox(_ weekday: Weekday) -> some View {
        HStack(spacing: 4.flexible()) {
            if weekdays.contains(weekday) {
                Image(.squareCheck)
                    .resizable()
                    .scaledToFit()
                    .padding(.all, 1.flexible())
            } else {
                RoundedRectangle(cornerRadius: 4.flexible(), style: .continuous)
                    .fill(.white.opacity(0.32))
                    .aspectRatio(contentMode: .fit)
                    .padding(.all, 1.flexible())
            }
            
            Text(weekday.title.uppercased())
                .font(.montserrat(13.flexible(), weight: .semibold))
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .frame(height: 16.flexible())
        .contentShape(.rect)
        .onTapGesture {
            if weekdays.contains(weekday) {
                weekdays.remove(weekday)
            } else {
                weekdays.insert(weekday)
            }
        }
    }
    
    func saveNewTraining() {
        let training = Training(context: viewContext)
        training.title = trainingTitle
        training.date = date
        training.completed = false
        training.weekdaysId = repetitiveTraining ? weekdays.map(\.rawValue) : []
        training.reminderId = enableNotifications ? selectedReminder.rawValue : ReminderDelay.none.rawValue
        
        do {
            try viewContext.save()
        } catch {
            print(error)
        }
        
        dismiss()
    }
}
