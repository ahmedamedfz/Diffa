//
//  StretchingBetweenSessionView.swift
//  ddiffa
//
//  Created by Angelica Patricia on 28/04/23.
//

import SwiftUI

struct StretchingBetweenSessionView: View {
    var body: some View {
        ZStack {
            Color.background.base
                .ignoresSafeArea()
            
            VStack (spacing: 50){
                Spacer()
                
                Text("Rest")
                    .font(.system(.title, design: .rounded))
                
                RestTimer()
                
                VStack {
                    HStack {
                        Text("Next 2/5")
                            .font(.system(.body, design: .rounded))
                            .foregroundColor(.text.tertiary)
                        Spacer()
                    }
                    HStack {
                        Text("Jumping Jacks")
                        Image(systemName: "questionmark.circle")
                        Spacer()
                        Text("20s")
                    }
                    .font(.system(.title3, design: .rounded))
                    
                    Rectangle()
                        .frame(width: 360, height: 200)
                        .foregroundColor(.primaryColor)
                        .cornerRadius(10)
                }
                .padding()
            }
        }.preferredColorScheme(.dark)
    }
}

struct StretchingBetweenSessionView_Previews: PreviewProvider {
    static var previews: some View {
        StretchingBetweenSessionView()
    }
}
