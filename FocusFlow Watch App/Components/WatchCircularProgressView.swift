//
//  WatchCircularProgressView.swift
//  FocusFlow Watch App
//
//  Created by Dimas on 05/05/23.
//

import SwiftUI

struct WatchCircularProgressView: View {
    let progress: CGFloat
    let lineWidth: CGFloat = 12
    
    var body: some View {
        ZStack {
            Circle()
//                .trim(from: 0, to: progress)
                .stroke(Color.background.secondary, style: StrokeStyle(lineWidth: lineWidth, lineCap: .round))
            
            Circle()
                .trim(from: 0, to: progress)
                .stroke(AngularGradient(gradient: Gradient(colors: [.primaryColor, Color("secondary-foreground"), .primaryColor]),center: .center), style: StrokeStyle(lineWidth: lineWidth, lineCap: .round))
                .rotationEffect(.init(degrees: -90))
        }
        .animation(.default, value: progress)
    }
}

struct WatchCircularProgressView_Previews: PreviewProvider {
    static var previews: some View {
        WatchCircularProgressView(progress: 0.3)
    }
}
