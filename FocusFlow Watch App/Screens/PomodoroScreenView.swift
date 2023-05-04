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
    
//    @State var progress: Double = 0
    @State var passedSeconds: Int = 0
    
    /// The target duration
    @State var duration: Int = 0

    var body: some View {
        VStack {
//            CircularProgressWatchView(progress: sessionManager.progress - 0.04, lineWidth: 16)
//                .frame(width: 64)
            
            VStack(alignment: .leading) {
                Text("Elapsed Time")
                    .font(.system(.body, design: .rounded))
                    .foregroundColor(.text.secondary)
                
                Text(TimeInterval.secondsToHourMinFormat(time: TimeInterval(passedSeconds))!)
                    .font(.system(.title2))
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.top, 16)
            .scenePadding(.horizontal)
            
            
            ProgressBarView(value: $sessionManager.progress)
                .padding(.top, 32)
                .scenePadding(.horizontal)
            
            Spacer()
        }
        .onAppear {
            self.passedSeconds = Int(Date.now.timeIntervalSince(sessionManager.session.startTime!))
        }
        .onReceive(sessionManager.timer) { _ in
            passedSeconds += 1
            sessionManager.updateProgress(with: passedSeconds)
        }
        .navigationTitle("On Going")
//        .navigationBarTitleDisplayMode(.large)
    }
}

struct SessionScreenView_Previews: PreviewProvider {
    static var previews: some View {
        let project = PersistenceController.projectsPreview.first!
        let sessionManager = PomodoroSessionManager.preview
        sessionManager.startNewSession(for: project, withDurationTarget: 1 * 60)
        
        return PomodoroScreenView()
            .environmentObject(sessionManager)
    }
}
