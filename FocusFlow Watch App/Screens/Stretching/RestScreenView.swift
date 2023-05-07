//
//  RestScreenView.swift
//  FocusFlow Watch App
//
//  Created by Dimas on 07/05/23.
//

import SwiftUI

struct RestScreenView: View {
    
    @EnvironmentObject private var stretchingManager: StretchSessionManager
 
    var body: some View {
        ZStack {
            WatchCircularProgressView(progress: CGFloat(stretchingManager.passedTime) / 5)
            
            Text(stretchingManager.passedTime <= 1 ? "Continue in" : "\(5 - Int(stretchingManager.passedTime))")
                .font(.system(size: 24, design: .rounded))
                .id(stretchingManager.passedTime)
                .transition(stretchingManager.passedTime <= 1 ? .identity : .springToTop)
        }
        .padding(.top, 12)
//        .navigationTitle("Rest")
    }
}

struct RestScreenView_Previews: PreviewProvider {
    
    static var previews: some View {
        let stretchingManager = StretchSessionManager()
        stretchingManager.startStretching(MainStretch.backAll.first!)
        
        return RestScreenView()
            .environmentObject(stretchingManager)
    }
}
