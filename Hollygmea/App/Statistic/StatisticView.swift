//
//  StatisticView.swift
//  Hollygmea
//

import SwiftUI

struct StatisticView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: []) var trainings: FetchedResults<Training>
    
    @ObservedObject var manager: CalendarManager
    
    var currentMonthTrainings: [Training] {
        trainings.filter { training in
            training.date?.isSameMonth(as: manager.selectedDay) ?? false
        }
    }
    
    var maxTrainingsPerDay: Int {
        let grouped = Dictionary(grouping: currentMonthTrainings) { training in
            Calendar.current.startOfDay(for: training.date ?? Date())
        }
        
        return grouped.values.map { $0.count }.max() ?? 0
    }
    
    var currentMontsDays: Int {
        return manager.calendar.range(of: .day, in: .month, for: Date())?.count ?? 0
    }
    
    var lastSixMonthsTrainings: [(key: Date, value: Int)] {
        let calendar = Calendar.current
        let now = Date()
        
        guard let sixMonthsAgo = calendar.date(byAdding: .month, value: -5, to: calendar.startOfDay(for: now)) else {
            return []
        }
        
        let filteredTrainings = trainings.filter { training in
            guard let date = training.date else { return false }
            return date >= sixMonthsAgo
        }
        
        let groupedTrainings = Dictionary(grouping: filteredTrainings) { training in
            let components = calendar.dateComponents([.year, .month], from: training.date ?? Date())
            return calendar.date(from: components) ?? Date()
        }.mapValues { $0.count }
        
        var allMonths: [(key: Date, value: Int)] = []
        for monthOffset in 0...5 {
            if let monthDate = calendar.date(byAdding: .month, value: -monthOffset, to: now) {
                let components = calendar.dateComponents([.year, .month], from: monthDate)
                let startOfMonth = calendar.date(from: components) ?? Date()
                let count = groupedTrainings[startOfMonth] ?? 0
                allMonths.append((key: startOfMonth, value: count))
            }
        }
        
        return allMonths.sorted { $0.key > $1.key }
    }
    
    var body: some View {
        VStack(spacing: 8.flexible()) {
            
            VStack(spacing: 12.flexible()) {
                Text("TRAININGS IN THIS MONTH")
                    .font(.montserrat(15.flexible(), weight: .heavy))
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                
                Text("\(currentMonthTrainings.count)")
                    .font(.montserrat(52.flexible(), weight: .black))
                    .foregroundStyle(.white)
            }
            .padding(.horizontal, 16.flexible())
            .padding(.vertical, 20.flexible())
            .background {
                RoundedRectangle(cornerRadius: 16.flexible(), style: .continuous)
                    .fill(.darkPurple)
            }
            
            HStack(spacing: 8.flexible()) {
                VStack(spacing: 12.flexible()) {
                    Text("AVERAGE PER DAY")
                        .font(.montserrat(15.flexible(), weight: .heavy))
                        .foregroundStyle(.white)
                        .multilineTextAlignment(.center)
                    
                    Text(String(format: "%.2f", Double(currentMonthTrainings.count) / Double(currentMontsDays)))
                        .font(.montserrat(52.flexible(), weight: .black))
                        .foregroundStyle(.white)
                }
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 16.flexible())
                .padding(.vertical, 20.flexible())
                .background {
                    RoundedRectangle(cornerRadius: 16.flexible(), style: .continuous)
                        .fill(.darkPurple)
                }
                
                VStack(spacing: 12.flexible()) {
                    Text("MAXIMUM PER DAY")
                        .font(.montserrat(15.flexible(), weight: .heavy))
                        .foregroundStyle(.white)
                        .multilineTextAlignment(.center)
                    
                    Text("\(maxTrainingsPerDay)")
                        .font(.montserrat(52.flexible(), weight: .black))
                        .foregroundStyle(.white)
                }
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 16.flexible())
                .padding(.vertical, 20.flexible())
                .background {
                    RoundedRectangle(cornerRadius: 16.flexible(), style: .continuous)
                        .fill(.darkPurple)
                }
            }
            
            VStack(spacing: 12.flexible()) {
                Text("TRAININGS PER MONTH")
                    .font(.montserrat(15.flexible(), weight: .heavy))
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                
                chartView
            }
            .padding(.horizontal, 16.flexible())
            .padding(.vertical, 20.flexible())
            .background {
                RoundedRectangle(cornerRadius: 16.flexible(), style: .continuous)
                    .fill(.darkPurple)
            }
            
            Spacer(minLength: 0)
        }
        .padding(.horizontal, 16.flexible())
        .padding(.vertical, 24.flexible())
        .setDefaultBackground()
    }
    
    var chartView: some View {
        GeometryReader { geometry in
            let maxCount = max(1, lastSixMonthsTrainings.max(by: { $0.value < $1.value })?.value ?? 0)
            
            HStack(spacing: 0) {
                ForEach(lastSixMonthsTrainings.reversed(), id: \.key) { date, count in
                    VStack(spacing: 4.flexible()) {
                        Spacer(minLength: 0)
                        
                        Text("\(count)")
                            .font(.montserrat(14.flexible(), weight: .black))
                            .foregroundStyle(.white)
                        
                        Color.lightGreen
                            .frame(width: 24.flexible(), height: (geometry.size.height / 1.5) * (Double(count) / Double(maxCount)))
                            .clipShape(
                                .rect(
                                    topLeadingRadius: 8.flexible(),
                                    topTrailingRadius: 8.flexible(),
                                    style: .continuous
                                )
                            )
                        
                        Text(date.formatted(.dateTime.month(.abbreviated)))
                            .font(.montserrat(12.flexible(), weight: .medium))
                            .foregroundStyle(.white.opacity(0.52))
                    }
                    .frame(maxWidth: .infinity)
                }
            }
        }
        .padding(.vertical, 8.flexible())
        .frame(height: 224.flexible())
        .background {
            RoundedRectangle(cornerRadius: 16.flexible(), style: .continuous)
                .fill(.lightPurple)
        }
    }
}
