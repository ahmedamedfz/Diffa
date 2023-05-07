//
//  WaitingScreenView.swift
//  FocusFlow Watch App
//
//  Created by Dimas on 05/05/23.
//

import SwiftUI

struct WaitingScreenView: View {
    
    @EnvironmentObject private var stretchingManager: StretchSessionManager
    
//    var timer = Timer.publish(every: 1, on: .main, in: .common)
//        .autoconnect()
//
    var body: some View {
        ZStack {
            WatchCircularProgressView(progress: CGFloat(stretchingManager.passedTime) / 5)
            
            Text(stretchingManager.passedTime <= 1 ? "Get Ready" : "\(5 - Int(stretchingManager.totalTime))")
                .id(stretchingManager.passedTime)
                .transition(stretchingManager.passedTime <= 1 ? .identity : .springToTop)
                .font(.system(size: 24, design: .rounded))
        }
        .padding(.top, 12)
//        .onReceive(stretchingManager.timer) { _ in
//            withAnimation {
////                stretchingManager.passedTime += 1
////
////                if stretchingManager.passedTime >= 5 {
////                    timer.upstream.connect().cancel()
////                }
//            }
//
////            passedTime /
//
//            print(stretchingManager.passedTime)
//        }
    }
}

struct WaitingScreenView_Previews: PreviewProvider {
    
    static var previews: some View {
        let stretchingManager = StretchSessionManager()
        stretchingManager.startStretching(MainStretch.backAll.first!)
        
        return WaitingScreenView()
            .environmentObject(stretchingManager)
    }
}

struct SpringToTopModifier: ViewModifier {
    let offset: Double
    
    func body(content: Content) -> some View {
        content
            .opacity(offset == 0 ? 1 : 0)
            .offset(y: offset)
            .animation(
                .interpolatingSpring(
                    mass: 1.9,
                    stiffness: 500,
                    damping: 30,
                    initialVelocity: 10
                ),
                value: offset
            )
    }
}

struct FadeModifier: ViewModifier {
    let duration: Double
    let scaledBy: Double
    
    func body(content: Content) -> some View {
        content
            .opacity(scaledBy)
            .scaleEffect(x: scaledBy, y: scaledBy)
            .animation(.easeInOut(duration: duration), value: scaledBy)
    }
}

extension AnyTransition {
    static var springToTop: AnyTransition {
        .asymmetric(
            insertion: .modifier(
                active: SpringToTopModifier(offset: 12),
                identity: SpringToTopModifier(offset: 0)
            ),
            removal: .modifier(
                active: FadeModifier(duration: 0.25, scaledBy: 0),
                identity: FadeModifier(duration: 0.25, scaledBy: 1)
            )
        )
    }
}
