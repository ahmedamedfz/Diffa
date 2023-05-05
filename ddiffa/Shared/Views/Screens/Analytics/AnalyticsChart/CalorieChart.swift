//
//  CalorieChart.swift
//  Protocol
//
//  Created by Angelica Patricia on 04/05/23.
//

import SwiftUI
import Charts

struct CalorieChart: View {
    let exerciseDatas = ExerciseData.all
    var body: some View {
        VStack {
            Chart {
                ForEach(exerciseDatas) { exerciseData in
                    BarMark(
                        x: .value("Date", exerciseData.date, unit: .day),
                        y: .value("Calories Burn", exerciseData.caloriesburn)
                    )
                }
                .foregroundStyle(Color.accentColor.gradient)
                .cornerRadius(15)
            }
        }
        .padding()
    }
}

struct CalorieChart_Previews: PreviewProvider {
    static var previews: some View {
        CalorieChart()
    }
}
