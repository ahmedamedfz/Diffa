//
//  FrequencyChart.swift
//  Protocol
//
//  Created by Angelica Patricia on 04/05/23.
//

import SwiftUI
import Charts

struct FrequentChart: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(entity: StretchingFrequency.entity(), sortDescriptors: []) private var stretchingFrequencies: FetchedResults<StretchingFrequency>
    @Binding var frequencies : Frequency
    
    var body: some View {
        VStack (alignment: .leading) {
            HStack{
                VStack{
                    Text("Total")
                        .font(.system(.headline, design: .rounded))
                        .foregroundColor(.text.secondary)
                        .bold()
                    let frequency = stretchingFrequencies.count
                    Text("\(frequency)")
                        .font(.system(.title, design: .rounded))
                        .foregroundColor(.text.primary)
                        .bold()
                    Text("Stretch")
                        .font(.system(.title3, design: .rounded))
                        .foregroundColor(.text.secondary)
                    let freqtest:String = {
                        switch frequencies {
                        case .daily:
                            return "Week \(Calendar.current.component(.weekOfMonth, from: Date()))"
                        case .weekly:
                            return DateFormatter().monthSymbols[Calendar.current.component(.month, from: Date()) - 1]
                        case .monthly:
                            return "\(Calendar.current.component(.year, from: Date()))"
                        }
                    }()
                    Text(freqtest)
                        .font(.system(.callout, design: .rounded))
                        .foregroundColor(.text.secondary)
                }
                Chart {
                    ForEach(stretchingFrequencies, id: \.self) { stretchingFrequency in
                        let calendar = Calendar.current
                        let currentDate = Date()
                        let date: Date = {
                            switch frequencies {
                            case .daily:
                                return calendar.date(byAdding: .day, value: -7, to: currentDate) ?? currentDate
                            case .weekly:
                                return calendar.date(byAdding: .weekOfYear, value: -4, to: currentDate) ?? currentDate
                            case .monthly:
                                return calendar.date(byAdding: .month, value: -12, to: currentDate) ?? currentDate
                            }
                        }()
                        let frequency: Int = {
                                    switch frequencies {
                                    case .daily:
                                        return stretchingFrequencies.filter { $0.day == stretchingFrequency.day }.count
                                    case .weekly:
                                        let week = Calendar.current.component(.weekOfYear, from: stretchingFrequency.day ?? Date())
                                        return stretchingFrequencies.filter { Calendar.current.component(.weekOfYear, from: $0.day ?? Date()) == week }.count
                                    case .monthly:
                                        let month = Calendar.current.component(.month, from: stretchingFrequency.day ?? Date())
                                        return stretchingFrequencies.filter { Calendar.current.component(.month, from: $0.day ?? Date()) == month }.count
                                    }
                                }()
                        BarMark(
                            x: .value("Date", date, unit: { () -> Calendar.Component in
                                switch frequencies {
                                case .daily:
                                    return .weekday
                                case .weekly:
                                    return .month
                                case .monthly:
                                    return .year
                                }
                            }()),
                            y: .value("Frequency", frequency))
                    }
                }
            }
        }
        .padding()
    }
}


