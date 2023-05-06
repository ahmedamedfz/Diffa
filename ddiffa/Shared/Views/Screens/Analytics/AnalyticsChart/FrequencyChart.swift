//
//  FrequencyChart.swift
//  Protocol
//
//  Created by Angelica Patricia on 04/05/23.
//

import SwiftUI
import Charts

struct FrequencyChart: View {
    let exerciseDatas = ExerciseData.all
    var body: some View {
        VStack {
            Chart {
                ForEach(exerciseDatas) { exerciseData in
                    BarMark(
                        x: .value("Date", exerciseData.date, unit: .day),
                        y: .value("Frequency", exerciseData.frequency)
                    )
                }
                .foregroundStyle(Color.accentColor.gradient)
                .cornerRadius(15)
            }
        }
        .padding()
    }
}

struct FrequencyChart_Previews: PreviewProvider {
    static var previews: some View {
        FrequencyChart()
    }
}
