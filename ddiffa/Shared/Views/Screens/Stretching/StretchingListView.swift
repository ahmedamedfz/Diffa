//
//  StretchingListView.swift
//  ddiffa
//
//  Created by Angelica Patricia on 28/04/23.
//

import SwiftUI

struct StretchingListView: View {
    var body: some View {
        ZStack {
            Color.background.base
                .ignoresSafeArea()
            
            VStack(spacing:0) {
                Text("Stretch")
                    .foregroundColor(.text.primary)
                    .font(.system(.largeTitle, design: .rounded))
                    .bold()
                Text("To keep you fresh, do this stretch!")
                    .foregroundColor(.text.tertiary)
                    .font(.system(.title2, design: .rounded))
                StretchingListScroll(stretchs: Stretch.all)
                    .padding([.top,.leading],25)
            }
        }
        .preferredColorScheme(.dark)
    }
}

struct StretchingListView_Previews: PreviewProvider {
    static var previews: some View {
        StretchingListView()
    }
}
