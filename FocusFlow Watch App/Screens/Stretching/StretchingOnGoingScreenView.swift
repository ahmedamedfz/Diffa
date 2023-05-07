//
//  StretchingOnGoingScreenView.swift
//  FocusFlow Watch App
//
//  Created by Dimas on 05/05/23.
//

import SwiftUI

class StretchSessionManager: ObservableObject {
    var mainStretch: MainStretch!
    
    @Published var currentIndex = 0
    @Published var passedTime: Int = 0
    @Published var totalTime: Int = 0
    
    var timer = Timer.publish(every: 1, on: .main, in: .common)
        .autoconnect()
    
    init() {}
    
    func startStretching(_ stretch: MainStretch, fromIndex: Int = 0) {
        mainStretch = stretch
        currentIndex = fromIndex
    }
    
    func updateStretching() {
        passedTime += 1
        totalTime += 1
        
        if currentIndex == 0 && passedTime == 6 { // go to rest 1
            currentIndex += 1
            passedTime = 0
        } else if currentIndex == 1 && passedTime == mainStretch.substretch[0].duration+1 {
            currentIndex += 1
            passedTime = 0
        } else if currentIndex == 2 && passedTime == 6 {
            currentIndex += 1
            passedTime = 0
        } else if currentIndex == 3 && passedTime == mainStretch.substretch[1].duration+1 {
            currentIndex += 1
            passedTime = 0
        } else if currentIndex == 4 && passedTime == 6 {
            currentIndex += 1
            passedTime = 0
        } else if currentIndex == 5 && passedTime == mainStretch.substretch[2].duration+1 {
            timer.upstream.connect().cancel()
            finishStretching()
        }
    }
    
    func finishStretching() {
        print("TODO: finish stretching")
    }
}

struct StretchingOnGoingScreenView: View {
    let chosenStretch: MainStretch
//    @State var currentIndex = 0
    
    @StateObject private var stretchingManager = StretchSessionManager()
    
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
        .environmentObject(stretchingManager)
        .onReceive(stretchingManager.timer) { _ in
            stretchingManager.updateStretching()
        }
//        .toolbar(.hidden, for: .navigationBar)
        .navigationBarBackButtonHidden(true)
//        .allowsHitTesting(false)
    }
}

struct StretchingOnGoingScreenView_Previews: PreviewProvider {
    static var previews: some View {
        StretchingOnGoingScreenView(chosenStretch: MainStretch.lowerAll.first!)
    }
}
