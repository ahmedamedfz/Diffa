//
//  StretchingCard.swift
//  ddiffa
//
//  Created by Angelica Patricia on 03/05/23.
//

import SwiftUI

struct StretchingCard: View {
    var mainStretch: MainStretch
    var body: some View {
        
        ZStack {
            Image(mainStretch.thumbnail)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 200, height: 120)
            
            LinearGradient(gradient: Gradient(colors: [Color(.white).opacity(0),Color.primaryColor]), startPoint: UnitPoint(x: 2, y: 0), endPoint: UnitPoint(x: 2, y: 1.2))
            
            HStack {
                VStack (alignment: .leading){
                    
                    Spacer()
                    Text(mainStretch.title)
                        .font(.system(.body, design: .rounded))
                    HStack (spacing: 5) {
                        Image(systemName: "timer")
                        Text(String(mainStretch.duration)+" minutes")
                    }
                    .font(.system(.caption2, design: .rounded))
                }
                .foregroundColor(.white)
                Spacer()
            }
            .shadow(radius: 2)
            .padding()
            
        }
        .frame(width: 200, height: 120)
        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))

    }
}
