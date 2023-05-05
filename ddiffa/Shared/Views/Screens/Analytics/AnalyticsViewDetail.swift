//
//  DetailAnalyticsView.swift
//  ddiffa
//
//  Created by Angelica Patricia on 04/05/23.
//

import SwiftUI

struct DetailAnalyticsView: View {
    var body: some View {
        ZStack {
            ScrollView {
                VStack (spacing: 20) {
                    Text("Exercise")
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
                            
                            HStack {
                                VStack (alignment: .leading) {
                                    Text("Total")
                                        .font(.system(.headline, design: .rounded))
                                        .foregroundColor(.text.secondary)
                                        .bold()
                                    HStack (alignment: .bottom){
                                        Text("4")
                                            .font(.system(.title, design: .rounded))
                                            .foregroundColor(.text.primary)
                                            .bold()
                                        Text("Workout")
                                            .font(.system(.title3, design: .rounded))
                                            .foregroundColor(.text.secondary)
                                    }
                                    Text("10 June 2023")
                                        .font(.system(.callout, design: .rounded))
                                        .foregroundColor(.text.secondary)
                                }
                                
                                Spacer()
                            }
                            
                            FrequencyChart()
                                .frame(width: 360, height: 170)
                                .cornerRadius(10)
                                .foregroundColor(Color.background.translucent)
                            
                        }
                        
                    }
                    .padding()
                    .frame(width: 380, height: 330)
                    .background(Color.background.secondary)
                    .cornerRadius(10)
                    
                    ZStack {
                        VStack (spacing: 20) {
                            Text("Calorie")
                                .font(.system(.title2, design: .rounded))
                                .foregroundColor(.text.primary)
                                .bold()
                                .padding(.top)
                            
                            HStack {
                                VStack (alignment: .leading) {
                                    Text("Total")
                                        .font(.system(.headline, design: .rounded))
                                        .foregroundColor(.text.secondary)
                                        .bold()
                                    HStack (alignment: .bottom){
                                        Text("287")
                                            .font(.system(.title, design: .rounded))
                                            .foregroundColor(.text.primary)
                                            .bold()
                                        Text("Kcal")
                                            .font(.system(.title3, design: .rounded))
                                            .foregroundColor(.text.secondary)
                                    }
                                    Text("10 June 2023")
                                        .font(.system(.callout, design: .rounded))
                                        .foregroundColor(.text.secondary)
                                }
                                
                                Spacer()
                            }
                            
                            CalorieChart()
                                .frame(width: 360, height: 170)
                                .cornerRadius(10)
                                .foregroundColor(Color.background.translucent)
                            
                        }
                        
                    }
                    .padding()
                    .frame(width: 380, height: 330)
                    .background(Color.background.secondary)
                    .cornerRadius(10)
                    
                    ZStack {
                        VStack (spacing: 20) {
                            Text("Heart Rate")
                                .font(.system(.title2, design: .rounded))
                                .foregroundColor(.text.primary)
                                .bold()
                                .padding(.top)
                            
                            HStack {
                                VStack (alignment: .leading) {
                                    Text("Total")
                                        .font(.system(.headline, design: .rounded))
                                        .foregroundColor(.text.secondary)
                                        .bold()
                                    HStack (alignment: .bottom){
                                        Text("180")
                                            .font(.system(.title, design: .rounded))
                                            .foregroundColor(.text.primary)
                                            .bold()
                                        Text("bpm")
                                            .font(.system(.title3, design: .rounded))
                                            .foregroundColor(.text.secondary)
                                    }
                                    Text("10 June 2023")
                                        .font(.system(.callout, design: .rounded))
                                        .foregroundColor(.text.secondary)
                                }
                                
                                Spacer()
                            }
                            
                            HeartRateChart()
                                .frame(width: 360, height: 170)
                                .cornerRadius(10)
                                .foregroundColor(Color.background.translucent)
                            
                        }
                        
                    }
                    .padding()
                    .frame(width: 380, height: 330)
                    .background(Color.background.secondary)
                    .cornerRadius(10)
                    
                    Divider()
                        .overlay(.gray)
                        .padding()
                }
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
                    
                    ZStack {
                        VStack (spacing: 20) {
                            Text("Project Distribution")
                                .font(.system(.title2, design: .rounded))
                                .foregroundColor(.text.primary)
                                .bold()
                            
                            Circle()
                                .foregroundColor(Color.background.translucent)
                                .frame(width: 400)
                            
                            HStack(spacing: 30) {
                                HStack {
                                    Rectangle()
                                        .foregroundColor(.red)
                                        .frame(width:10, height: 10)
                                    
                                    Text("Label 1")
                                }
                                
                                HStack {
                                    Rectangle()
                                        .foregroundColor(.yellow)
                                        .frame(width:10, height: 10)
                                    
                                    Text("Label 1")
                                }
                                
                                HStack {
                                    Rectangle()
                                        .foregroundColor(.green)
                                        .frame(width:10, height: 10)
                                    
                                    Text("Label 1")
                                }
                            }
                            
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

struct DetailAnalyticsView_Previews: PreviewProvider {
    static var previews: some View {
        DetailAnalyticsView()
    }
}
