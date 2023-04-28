//
//  StretchingListCard.swift
//  ddiffa
//
//  Created by Angelica Patricia on 28/04/23.
//

import SwiftUI

struct StretchingListCard: View {
    var stretch: Stretch
    var body: some View {
        ZStack {
            
            Image(stretch.image_thumbnail)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 200, height: 120)
            
            LinearGradient(gradient: Gradient(colors: [Color(.white).opacity(0),Color.primaryColor]), startPoint: UnitPoint(x: 2, y: 0), endPoint: UnitPoint(x: 2, y: 1.2))
            
            HStack {
                VStack (alignment: .leading){
                    
                    Spacer()
                    Text("\(stretch.title)")
                        .font(.system(.body, design: .rounded))
                    HStack {
                        Image(systemName: "timer")
                        Text("\(stretch.duration) mins")
                    }
                    .font(.system(.caption2, design: .rounded))
                }
                .foregroundColor(.text.primary)
                Spacer()
            }
            .shadow(radius: 2)
            .padding()
            
        }
        .frame(width: 200, height: 120)
        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
    }
}

struct StretchingListCard_Previews: PreviewProvider {
    static var previews: some View {
        StretchingListCard(stretch: Stretch.all[2])
    }
}
