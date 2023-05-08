//
//  ExerciseDataModel.swift
//  Protocol
//
//  Created by Angelica Patricia on 04/05/23.
//

import Foundation

struct ExerciseFrequency: Identifiable {
    let id = UUID()
    let date: Date
    let frequency: Int
}

struct ExerciseData: Identifiable {
    let id = UUID()
    let date: Date
    let frequency: Int
    let heartratemin: Int
    let heartratemax: Int
    let caloriesburn: Int
}

extension Date {
    static func from(year: Int, month: Int, day: Int) -> Date {
        let components = DateComponents(year: year, month: month, day: day)
        return Calendar.current.date(from: components)!
    }
}

extension ExerciseData {
    static let all: [ExerciseData] = [
        .init(date: Date.from(year: 2023, month: 1, day: 1), frequency: 2, heartratemin: 170, heartratemax: 210, caloriesburn: 130),
        .init(date: Date.from(year: 2023, month: 1, day: 2), frequency: 5, heartratemin: 130, heartratemax: 200, caloriesburn: 100),
        .init(date: Date.from(year: 2023, month: 1, day: 3), frequency: 4, heartratemin: 160, heartratemax: 210, caloriesburn: 70),
        .init(date: Date.from(year: 2023, month: 1, day: 4), frequency: 1, heartratemin: 130, heartratemax: 190, caloriesburn: 90),
        .init(date: Date.from(year: 2023, month: 1, day: 5), frequency: 5, heartratemin: 160, heartratemax: 200, caloriesburn: 120),
        .init(date: Date.from(year: 2023, month: 1, day: 6), frequency: 7, heartratemin: 150, heartratemax: 200, caloriesburn: 150),
        .init(date: Date.from(year: 2023, month: 1, day: 7), frequency: 2, heartratemin: 120, heartratemax: 170, caloriesburn: 130)
    ]

}
