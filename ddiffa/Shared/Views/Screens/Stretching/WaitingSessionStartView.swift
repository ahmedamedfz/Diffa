//
//  WaitingSessionStartView.swift
//  ddiffa
//
//  Created by Angelica Patricia on 28/04/23.
//

import SwiftUI

struct WaitingSessionStartView: View {
    var body: some View {
        ZStack {
            Color.background.base
                .ignoresSafeArea()
            
            VStack (spacing: 50) {
                Rectangle()
                    .frame(width: 360, height: 200)
                    .foregroundColor(.primaryColor)
                    .cornerRadius(10)
                
                
                VStack(spacing: 5) {
                    Text("Ready To Go!")
                        .font(.system(.title, design: .rounded))
                        .foregroundColor(.text.primary)
                    
                    Text("Clockwise Arm Swings | 20 secs")
                        .font(.system(.title3, design: .rounded))
                        .foregroundColor(.text.tertiary)
                    
                    Image(systemName: " questionmark.circle")
                        .font(.system(.title3, design: .rounded))
                        .foregroundColor(.text.tertiary)
                }
                
//                WaitingTimer()
                
                // MARK: Start Now
                Button(action: {
                    }, label: {
                    NavigationLink(destination: EmptyView())
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
        }
        .preferredColorScheme(.dark)
    }
}

struct WaitingSessionStartView_Previews: PreviewProvider {
    static var previews: some View {
        WaitingSessionStartView()
    }
}
