//
//  WatchStretchingCard.swift
//  FocusFlow Watch App
//
//  Created by Dimas on 05/05/23.
//

import SwiftUI

struct WatchStretchingCard: View {
    var mainStretch: MainStretch
    var body: some View {
//        NavigationLink(destination: Text("TODO")) {
            ZStack {
                Image(mainStretch.thumbnail)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 150, height: 100)
                
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
                    .foregroundColor(.text.primary)
                    Spacer()
                }
                .shadow(radius: 2)
                .padding()
                
            }
//            .padding()
            .frame(width: 150, height: 100)
//        }
//        .buttonStyle(.borderless)
    }
}

struct WatchStretchingCard_Previews: PreviewProvider {
    static var previews: some View {
        WatchStretchingCard(mainStretch: MainStretch.allStretch[0][0])
    }
}
