//
//  SessionEmptyView.swift
//  FocusFlow Watch App
//
//  Created by Dimas on 04/05/23.
//

import SwiftUI

struct SessionEmptyView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text("No project found")
                    .scenePadding(.leading)
                
                Text("😔")
                    .font(.system(size: 24))
            }
            
            Text("Create a new project in your iPhone first")
                .font(.system(.footnote, design: .rounded))
                .foregroundColor(.text.secondary)
                .scenePadding(.leading)
        }
    }
}

struct SessionEmptyView_Previews: PreviewProvider {
    static var previews: some View {
        
        SessionEmptyView()
            .previewDevice("Apple Watch SE (44mm) (2nd generation)")
    }
}
