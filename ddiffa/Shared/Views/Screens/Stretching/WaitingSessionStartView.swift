//
//  WaitingSessionStartView.swift
//  ddiffa
//
//  Created by Angelica Patricia on 03/05/23.
//

import SwiftUI

struct WaitingSessionStartView: View {
    var index : Int
    var mainStretch : MainStretch
    var subStretch: SubStretch {mainStretch.substretch[index]}
    
    
    @State private var timerFinished = false
    @State private var isTimerRunning = true
    private var waitingTimer : WaitingTimer? {WaitingTimer(timerFinished: $timerFinished)}
    
    var body: some View {
        VStack (spacing: 50) {
            Rectangle()
                .frame(width: 360, height: 200)
                .foregroundColor(.primaryColor)
                .cornerRadius(10)
            
            
            VStack(spacing: 5) {
                Text("Ready To Go!")
                    .font(.system(.title, design: .rounded))
                    .foregroundColor(.text.primary)
                Text(subStretch.title + " | " + String(subStretch.duration) + " sec")
                    .font(.system(.title3, design: .rounded))
                    .foregroundColor(.text.tertiary)
                
                Image(systemName: "questionmark.circle")
                    .font(.system(.title3, design: .rounded))
                    .foregroundColor(.text.tertiary)
            }
            
            waitingTimer
                .navigationDestination(isPresented: $timerFinished) {
                    OnGoingMovementView(index: index, mainStretch: mainStretch)
                }
            
            // MARK: Start Now
            Button(action: {
                //isTimerRunning = false
                waitingTimer?.stopTimer()
            }, label: {
                NavigationLink(destination: OnGoingMovementView(index: index, mainStretch: mainStretch))
                {
                    HStack {
                        Text("Start now")
                        Image(systemName: "chevron.right")
                    }
                    .foregroundColor(.text.tertiary)
                    .font(.system(.title3, design: .rounded))
                }

            })
            
        }
        .padding()
        .preferredColorScheme(.dark)
        .onReceive([isTimerRunning].publisher.first()) { (value) in
            if !value {
                waitingTimer?.stopTimer()
            }
        }
    }
}
