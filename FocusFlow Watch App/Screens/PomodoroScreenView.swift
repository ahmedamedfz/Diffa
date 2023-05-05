//
//  SessionScreenView.swift
//  FocusFlow Watch App
//
//  Created by Dimas on 04/05/23.
//

import SwiftUI

extension TimeInterval {
    static func secondsToHourMinFormat(time: TimeInterval) -> String? {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.minute, .second]
        formatter.zeroFormattingBehavior = .pad
        return formatter.string(from: time)
    }
}

struct PomodoroScreenView: View {
    
    @EnvironmentObject var sessionManager: PomodoroSessionManager
    
    @State private var pausedOpacity = 1.0
    
    /// The target duration
    @State var duration: Int = 0

    var body: some View {
        VStack(alignment: .leading) {
            Text(sessionManager.session.project?.name ?? "No Project")
                .font(.system(.title2))
                .scenePadding(.horizontal)
            
            Spacer()
            
            VStack(alignment: .leading) {
                Text("Elapsed Time")
                    .font(.system(.body, design: .rounded))
                    .foregroundColor(.text.secondary)
                
                Text(TimeInterval.secondsToHourMinFormat(time: TimeInterval(sessionManager.passedSeconds))!)
                    .font(.system(.title2))
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .scenePadding(.horizontal)
            
            Spacer()
            
            ProgressBarView(value: $sessionManager.progress)
                .scenePadding(.horizontal)
         
            if sessionManager.isPaused {
                Text("Paused")
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.top, 4)
                .opacity(pausedOpacity)
                .animation(
                    Animation
                        .easeInOut(duration: 0.6)
                        .repeatForever(autoreverses: true),
                    value: pausedOpacity
                )
                .onAppear { self.pausedOpacity = 0.3 }
            }
        }
        .onReceive(sessionManager.timer) { _ in
            sessionManager.updateProgress()
            
            print(sessionManager.passedSeconds)
        }
        .navigationTitle("On Going")
    }
}

struct SessionScreenView_Previews: PreviewProvider {
    static var previews: some View {
        let sessionManager = WatchPreviewFactory().makeSessionManager(withDurationTarget: 1 * 60)
        
        return PomodoroScreenView()
            .environmentObject(sessionManager)
    }
}
