//
//  WaitingTimer.swift
//  ddiffa
//
//  Created by Angelica Patricia on 28/04/23.
//

import SwiftUI

struct WaitingTimer: View {
    @State var start = true
    @State var to : CGFloat = 5
    @State var count = 5
    @State var time = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            Circle()
                .trim(from: 0, to: 1)
                .stroke(Color.gray.opacity(0.05), style: StrokeStyle(lineWidth: 32, lineCap: .round))
                .frame(width: 157, height: 157)
            
            Circle()
                .trim(from: 0, to: self.to)
                .stroke(AngularGradient(gradient: Gradient(colors: [.primaryColor,.secondaryColor, .primaryColor]),center: .center), style: StrokeStyle(lineWidth: 32, lineCap: .round))
                .frame(width: 157, height: 157)
                .rotationEffect(.init(degrees: -90))
            
            VStack {
                Text("\(self.count)")
                    .font(.system(.largeTitle, design: .rounded))
                    .foregroundColor(.text.tertiary)
            }
        }
        .onReceive(self.time) { (_) in
           if self.start {
               if self.count != 0 {
                   self.count -= 1
                   withAnimation(.default.speed(2)) {
                       self.to = CGFloat(self.count)/5
                   }
               }
               else {
                   self.start.toggle()
               }
           }
        }
    }
}

struct WaitingTimer_Previews: PreviewProvider {
    static var previews: some View {
        WaitingTimer()
    }
}
