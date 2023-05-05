//
//  RestTimer.swift
//  Protocol
//
//  Created by Angelica Patricia on 04/05/23.
//

import SwiftUI

struct RestTimer: View {
    @Binding var timerFinished: Bool
    @State var start = true
    @State var count = 5
    @State var time = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    var body: some View {
        VStack {
            
            Text(String(format: "%02d:%02d", self.count / 60, self.count % 60))
                .font(.system(size: 64, design: .rounded))
                .bold()
                .padding()
            
            
            HStack {
                // MARK: +5s
                Button(action:
                {
                    self.count += 5
                    print("+5s")
                })
                {
                    Text("+5s")
                        .foregroundColor(.text.primary)
                    .font(.system(.body, design: .rounded))
                    .frame(width: 117, height: 38)
                    .background(Color.primaryTransluctent)
                    .cornerRadius(10)
                    
                }.overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.primaryColor, lineWidth: 2)
                )
                
                // MARK: Skip
                Button(action:
                {
                    self.count = 0
                    print("Skip")
                })
                {
                    Text("Skip")
                    .foregroundColor(.text.primary)
                    .font(.system(.body, design: .rounded))
                    .frame(width: 117, height: 38)
                    .background(Color.primaryColor)
                    .cornerRadius(10)
                    
                }
            }
        }
        .onReceive(self.time) { (_) in
                if self.start {
                    if self.count != 0 {
                        self.count -= 1
                    }
                    else {
                        self.start.toggle()
                        self.timerFinished = true
                    }
                }
            }
    }
}

