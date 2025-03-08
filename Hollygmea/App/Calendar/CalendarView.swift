//
//  CalendarView.swift
//  Hollygmea
//

import SwiftUI
import Foundation
import CoreData

struct CalendarView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: []) var trainings: FetchedResults<Training>
    
    @ObservedObject var manager: CalendarManager
    
    var todayTrainings: [Training] {
        trainings.filter { training in
            training.date?.isSameDay(as: manager.selectedDay) ?? false
        }
    }
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: true) {
            VStack(spacing: 24.flexible()) {
                calendarView
                
                trainingsView
                
                Spacer(minLength: 0)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 24.flexible())
            .padding(.horizontal, 16.flexible())
        }
        .padding(.top, 0.2)
        .setDefaultBackground()
    }
    
    var calendarView: some View {
        VStack(spacing: 16.flexible()) {
            HStack(spacing: 0) {
                Button {
                    vibrate()
                    manager.showPreviousMonth()
                } label: {
                    Image(.backButton)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 16.flexible(), height: 16.flexible())
                }
                
                Spacer()
                
                Text(manager.selectedDay.formatted(.dateTime.month(.wide).year()).uppercased())
                    .font(.montserrat(15.flexible(), weight: .heavy))
                    .foregroundStyle(.white)
                
                Spacer()
                
                Button {
                    vibrate()
                    manager.showNextMonth()
                } label: {
                    Image(.forwardButton)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 16.flexible(), height: 16.flexible())
                }
            }
            
            calendarGridView
            
            NavigationLink(destination: AddTrainingView(date: manager.selectedDay)) {
                GreenButton(icon: .addTrainingIcon, title: "ADD TRAINING") {}
                    .disabled(true)
            }
        }
        .padding(.vertical, 20.flexible())
        .padding(.horizontal, 16.flexible())
        .background {
            RoundedRectangle(cornerRadius: 16.flexible(), style: .continuous)
                .fill(.darkPurple)
        }
    }
    
    var calendarGridView: some View {
        GeometryReader { geometry in
            let columnWidth = (geometry.size.width - 12) / 7
            let columns: [GridItem] = Array(repeating: .init(.fixed(columnWidth), spacing: 2), count: 7)
            
            LazyVGrid(columns: columns, spacing: 2.flexible()) {
                ForEach(manager.calendarDays, id: \.self) { date in
                
                    RoundedRectangle(cornerRadius: 8, style: .continuous)
                        .fill(date.isSameDay(as: manager.selectedDay) ? .highlightedPurple : .lightPurple)
                        .frame(width: columnWidth, height: columnWidth)
                        .overlay {
                            Text(date.formatted(.dateTime.day()))
                                .font(.montserrat(16.flexible(), weight: .heavy))
                                .foregroundStyle(.white.opacity(date.isSameMonth(as: manager.selectedDay) ? 1 : 0.52))
                        }
                        .overlay(alignment: .topTrailing) {
                            if trainings.contains(where: { $0.date?.isSameDay(as: date) ?? false }) {
                                Circle()
                                    .fill(.toggleGreen)
                                    .frame(width: 8)
                                    .padding([.top, .trailing], 6)
                            }
                        }
                        .onTapGesture {
                            vibrate()
                            manager.selectDate(date)
                        }
                }
            }
            .frame(maxWidth: .infinity)
        }
        .aspectRatio(CGSize(width: 320, height: 274), contentMode: .fit)
    }
    
    var trainingsView: some View {
        VStack(spacing: 8.flexible()) {
            Text(manager.selectedDay.formatted(.dateTime.day().month(.wide).year()))
                .font(.montserrat(18.flexible(), weight: .heavy))
                .foregroundStyle(.white)
        
            if todayTrainings.isEmpty {
                Text("There are no scheduled training sessions on this day.")
                    .font(.montserrat(15.flexible(), weight: .medium))
                    .foregroundStyle(.white.opacity(0.52))
                    .multilineTextAlignment(.center)
            } else {
                ForEach(todayTrainings, id: \.self) { training in
                    trainingCell(training)
                }
            }
        }
    }
    
    func trainingCell(_ training: Training) -> some View {
        HStack(spacing: 12.flexible()) {
            VStack(spacing: 2.flexible()) {
                Text(training.title?.uppercased() ?? "Unknown")
                    .font(.montserrat(15.flexible(), weight: .heavy))
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text((training.date ?? manager.selectedDay).formatted(.dateTime.day(.twoDigits).month(.abbreviated).hour(.twoDigits(amPM: .omitted)).minute(.twoDigits)))
                    .font(.montserrat(15.flexible(), weight: .medium))
                    .foregroundStyle(.white.opacity(0.52))
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            
            VStack {
                if training.completed {
                    Image(.roundCheck)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20.flexible(), height: 20.flexible())
                } else {
                    Circle()
                        .fill(.white.opacity(0.32))
                        .frame(width: 20.flexible())
                }
            }
            .contentShape(.rect)
            .onTapGesture {
                training.completed.toggle()
                do {
                    try viewContext.save()
                } catch {
                    print("Context save error")
                }
            }
        }
        .padding(.all, 16.flexible())
        .background {
            RoundedRectangle(cornerRadius: 16.flexible(), style: .continuous)
                .fill(.darkPurple)
        }
    }
}
