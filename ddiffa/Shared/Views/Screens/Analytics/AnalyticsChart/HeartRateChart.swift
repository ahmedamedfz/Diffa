//
//  HeartRateChart.swift
//  Protocol
//
//  Created by Angelica Patricia on 04/05/23.
//

import SwiftUI
import Charts

struct HeartRateChart: View {
    let exerciseDatas = ExerciseData.all
    var body: some View {
        VStack {
            Chart {
                ForEach(exerciseDatas) { exerciseData in
                    BarMark(
                        x: .value("Date", exerciseData.date, unit: .day),
                        yStart: .value("Heart Rate Min", exerciseData.heartratemin),
                        yEnd: .value("Heart Rate Max", exerciseData.heartratemax)                    )
                }
                .foregroundStyle(Color.accentColor.gradient)
                .cornerRadius(15)
                
            }
            .chartYScale(domain: 110...215)
        }
        .padding()
    }
}

struct HeartRateChart_Previews: PreviewProvider {
    static var previews: some View {
        HeartRateChart()
    }
}
