//
//  OnGoingMovementView.swift
//  ddiffa
//
//  Created by Angelica Patricia on 04/05/23.
//

import SwiftUI
import Combine

struct OnGoingMovementView: View {
    @State private var timerFinished = false
    @State private var isTimerRunning = true
    @State private var isInfoOpen = false
    @State private var totalCount:Int = 5
    
    var index: Int
    var mainStretch : MainStretch
    var currentSubStretch: SubStretch {mainStretch.substretch[index]}
    var sumTime: Int
    private var onGoingTimer : OnGoingTimer? {OnGoingTimer(subStretch: currentSubStretch, timerFinished: $timerFinished)}
    
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack (spacing: 30) {
                    ZStack (alignment: .bottom) {
                        //Ganti Animation
                        Rectangle()
                            .frame(width: 336, height: 284)
                            .foregroundColor(.primaryColor)
                            .cornerRadius(10)
                        HStack {
                            Spacer()
                            
                            Button {
                                self.isInfoOpen = true
                            } label: {
                                    Image(systemName: "questionmark.circle")
                                    .foregroundColor(.white)
                                    .padding()
                                    .padding(.trailing,10)
                            }
                        }
                    }
                    VStack (spacing: 0) {
                        Text(currentSubStretch.title)
                            .font(.system(.title, design: .rounded))
                            .foregroundColor(.text.primary)
                            .padding(.bottom,-20)
                        ZStack {
                            onGoingTimer
                                .navigationDestination(isPresented: $timerFinished) {
                                    if index == mainStretch.substretch.count-1 {
                                       FinishedView(sumTime: sumTime + currentSubStretch.duration)
                                    } else {
                                        RestBetweenSessionView(mainStretch: mainStretch, index: index + 1, sumTime: sumTime + currentSubStretch.duration, totalCount: $totalCount)
                                    }
                                }
                        }
                        .padding()
                        
                    }
                }
                .padding()
                
                if isInfoOpen {
                    withAnimation{
                        StretchInfoView(isInfoOpen: $isInfoOpen)
                    }
                }
            }
        }
        .onReceive([isTimerRunning].publisher.first()) { (value) in
            if !value {
                onGoingTimer?.stopTimer()
            }
        }
    }
}