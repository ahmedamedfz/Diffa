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
    
    var index: Int
    var mainStretch : MainStretch
    var currentSubStretch: SubStretch {mainStretch.substretch[index]}
    private var onGoingTimer : OnGoingTimer? {OnGoingTimer(subStretch: currentSubStretch, timerFinished: $timerFinished)}
    
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack (spacing: 50) {
                    ZStack (alignment: .bottom) {
                        //Ganti Animation
                        Rectangle()
                            .frame(width: 336, height: 284)
                            .foregroundColor(.primaryColor)
                            .cornerRadius(10)
                        HStack {
                            Spacer()
                            Image(systemName: "questionmark.circle")
                                .foregroundColor(.text.secondary)
                                .padding()
                                .padding(.trailing,25)
                        }
                    }
                    VStack (spacing: 0) {
                        Text(currentSubStretch.title)
                            .font(.system(.title2, design: .rounded))
                            .foregroundColor(.text.primary)
                            .padding(.bottom,-5)
                        ZStack {
                            onGoingTimer
                                .navigationDestination(isPresented: $timerFinished) {
                                    if index == mainStretch.substretch.count-1 {
                                       FinishedView()
                                    } else {
                                        RestBetweenSessionView(mainStretch: mainStretch, index: index + 1)
                                    }
                                }
                        }
                        .padding()
                    }
                }
                .padding()
            }
            .preferredColorScheme(.dark)
        }
        .onReceive([isTimerRunning].publisher.first()) { (value) in
            if !value {
                onGoingTimer?.stopTimer()
            }
        }
    }
}

