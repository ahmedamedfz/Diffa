//
//  StretchingBetweenSessionView.swift
//  Protocol
//
//  Created by Angelica Patricia on 04/05/23.
//

import SwiftUI

struct RestBetweenSessionView: View {
    
    var mainStretch: MainStretch
    var index: Int
    var subStretch: SubStretch {mainStretch.substretch[index]}
    var sumTime : Int
    @Binding var totalCount : Int
    @State private var isInfoOpen = false
    @State private var timerFinished = false
    
    var restTimer : RestTimer {RestTimer(timerFinished: $timerFinished, totalCount: $totalCount)}
 
    var body: some View {
        ZStack {
            VStack (spacing: 50){
                Spacer()
                
                Text("Rest")
                    .font(.system(.title, design: .rounded))
                
                restTimer.navigationDestination(isPresented: $timerFinished) {
                    OnGoingMovementView(index: index , mainStretch: mainStretch, sumTime: sumTime+totalCount)
                }
                
                VStack {
                    HStack {
                        Text("Next \(index+1)/3")
                            .font(.system(.body, design: .rounded))
                            .foregroundColor(.text.tertiary)
                        Spacer()
                    }
                    HStack {
                        Text(subStretch.title)
                        Button {
                            self.isInfoOpen = true
                        } label: {
                                Image(systemName: "questionmark.circle")
                        }
                        Spacer()
                        Text("\(subStretch.duration)s")
                    }
                    .font(.system(.title3, design: .rounded))
                    
                    Rectangle()
                        .frame(width: 360, height: 200)
                        .foregroundColor(.primaryColor)
                        .cornerRadius(10)
                }
                .padding()
            }
            if isInfoOpen {
                withAnimation{
                    StretchInfoView(isInfoOpen: $isInfoOpen)
                }
            }
        }
    }
}
