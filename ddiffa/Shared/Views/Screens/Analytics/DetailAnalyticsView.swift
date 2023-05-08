//
//  DetailAnalyticsView.swift
//  ddiffa
//
//  Created by Ahmad Fariz on 07/05/23.
//

import SwiftUI

struct DetailAnalyticsView: View {
    @State private var frequency = Frequency.daily
    
    var body: some View {
        ZStack {
            VStack{
                Picker("Choose the frequency", selection: $frequency) {
                    ForEach(Frequency.allCases, id: \.self) {frequency in
                        Text(frequency.rawValue)
                    }
                }
                .pickerStyle(.segmented)
                ScrollView {
                    VStack (spacing: 20) {
                        Text("Stretching")
                            .font(.system(.title, design: .rounded))
                            .foregroundColor(.text.primary)
                            .bold()
                            .padding(.top)
                        
                        ZStack {
                            VStack (spacing: 20) {
                                Text("Frequency")
                                    .font(.system(.title2, design: .rounded))
                                    .foregroundColor(.text.primary)
                                    .bold()
                                    .padding(.top)
                                
                                FrequentChart(frequencies: $frequency)
                                    .frame(width: 360, height: 170)
                                    .cornerRadius(10)
                                    .foregroundColor(Color.background.translucent)
                                
                            }
                            
                        }
                        .padding()
                        .frame(width: 380, height: 330)
                        .background(Color.background.secondary)
                        .cornerRadius(10)
                        
                    }
                    //Markdown: Pomodoro
                    VStack (spacing: 20) {
                        Text("Pomodoro")
                            .font(.system(.title, design: .rounded))
                            .foregroundColor(.text.primary)
                            .bold()
                        
                        ZStack {
                            VStack (spacing: 20) {
                                Text("Time")
                                    .font(.system(.title2, design: .rounded))
                                    .foregroundColor(.text.primary)
                                    .bold()
                                
                                HStack {
                                    VStack (alignment: .leading) {
                                        Text("Total")
                                            .font(.system(.headline, design: .rounded))
                                            .foregroundColor(.text.secondary)
                                            .bold()
                                        HStack (alignment: .bottom){
                                            Text("3.2")
                                                .font(.system(.title, design: .rounded))
                                                .foregroundColor(.text.primary)
                                                .bold()
                                            Text("mins")
                                                .font(.system(.title3, design: .rounded))
                                                .foregroundColor(.text.secondary)
                                        }
                                        Text("10 June 2023")
                                            .font(.system(.callout, design: .rounded))
                                            .foregroundColor(.text.secondary)
                                    }
                                    
                                    Spacer()
                                }
                                
                                Rectangle()
                                    .frame(width: 360, height: 170)
                                    .cornerRadius(10)
                                    .foregroundColor(Color.background.translucent)
                                
                            }
                            
                        }
                        .padding()
                        .frame(width: 380, height: 330)
                        .background(Color.background.secondary)
                        .cornerRadius(10)
                    }
                }
            }
        }
    }
}


struct DetailAnalyticsView_Previews: PreviewProvider {
    static var previews: some View {
        DetailAnalyticsView()
    }
}
