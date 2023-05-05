//
//  OnGoingTimer.swift
//  ddiffa
//
//  Created by Angelica Patricia on 04/05/23.
//

import SwiftUI

struct OnGoingTimer: View {
    var subStretch: SubStretch
    @Binding var timerFinished: Bool
    @State var start = true
    @State private var count: Int?
    @State private var to: CGFloat?
    @State private var duration: CGFloat?
    @State var time = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    var body: some View {
        VStack {
            Text(String(format: "%02d:%02d", (count ?? 0) / 60, (count ?? 0) % 60))
                .font(.system(size: 64, design: .rounded))
                .foregroundColor(.text.primary)
                .bold()
            
            ZStack {
                Circle()
                    .trim(from: 0, to: 1)
                    .stroke(Color.gray.opacity(0.1), style: StrokeStyle(lineWidth: 32, lineCap: .round))
                    .frame(width: 140, height: 140)
                
                Circle()
                    .trim(from: 0, to: to ?? 0)
                    .stroke(AngularGradient(gradient: Gradient(colors: [.primaryColor,.secondaryColor, .primaryColor]),center: .center), style: StrokeStyle(lineWidth: 32, lineCap: .round))
                    .frame(width: 140, height: 140)
                    .rotationEffect(.init(degrees: -90))
                
                VStack {
                    Button(action: {
                        start.toggle()
                    }) {
                        Image(systemName: start ? "pause.fill" : "play.fill")
                            .font(.system(.largeTitle, design: .rounded))
                            .foregroundColor(.text.secondary)
                    }
                }
            }
        }
        
        .onAppear{
            count = subStretch.duration
            duration = CGFloat(subStretch.duration)
            to = CGFloat(subStretch.duration)
        }
        .onReceive(self.time) { (_) in
           if self.start {
               if count != 0 {
                   count! -= 1
                   withAnimation(.default) {
                       to = CGFloat(count ?? 0)/(duration ?? 0)
                   }
               }
               else {
                   self.start.toggle()
                   self.timerFinished = true
                   
               }
           }
        }
        .preferredColorScheme(.dark)
    }
    func stopTimer() {
            self.time.upstream.connect().cancel()
        }
}
