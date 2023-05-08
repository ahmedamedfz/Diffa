//
//  StretchingOnGoingScreenView.swift
//  FocusFlow Watch App
//
//  Created by Dimas on 05/05/23.
//

import SwiftUI

struct StretchingOnGoingScreenView: View {
    let chosenStretch: MainStretch
//    @State var currentIndex = 0
    
    @EnvironmentObject var stretchingManager: StretchSessionManager
    
    var body: some View {
        TabView(selection: $stretchingManager.currentIndex) {
            WaitingScreenView()
                .tag(0)
            
            StretchingView(stretch: chosenStretch.substretch[0])
                .tag(1)
            
            RestScreenView()
                .tag(2)
            
            StretchingView(stretch: chosenStretch.substretch[1])
                .tag(3)
            
            RestScreenView()
                .tag(4)
            
            StretchingView(stretch: chosenStretch.substretch[2])
                .tag(5)
            
//            Text("Finish")
//                .tag(2)
        }
        .scrollDisabled(true)
        .tabViewStyle(.page(indexDisplayMode: .never))
        .onAppear {
            stretchingManager.startStretching(chosenStretch)
        }
        .onReceive(stretchingManager.timer) { _ in
            stretchingManager.updateStretching()
        }
//        .toolbar(.hidden, for: .navigationBar)
        .navigationBarBackButtonHidden(true)
        .sheet(isPresented: $stretchingManager.isShowingSummaryView) {
            SummaryView()
        }
        .environmentObject(stretchingManager)
//        .allowsHitTesting(false)
    }
}

struct StretchingOnGoingScreenView_Previews: PreviewProvider {
    static var previews: some View {
        StretchingOnGoingScreenView(chosenStretch: MainStretch.lowerAll.first!)
    }
}
