//
//  PomodoroControlsScreenView.swift
//  FocusFlow Watch App
//
//  Created by Dimas on 05/05/23.
//

import SwiftUI

struct PomodoroControlsScreenView: View {
    @EnvironmentObject var sessionManager: PomodoroSessionManager
    @EnvironmentObject var mainVM: MainViewModel
    
    @Binding var selectedTab: PomodoroOnGoingView.Tab
    
    var body: some View {
        VStack {
            HStack(spacing: 8) {
                Button {
                    sessionManager.isShowingSheet = true
                    sessionManager.isShowingFinishSheet = false
                } label: {
                    Image(systemName: "trash")
                        .frame(height: 40)
                }
                .tint(.red)
                .buttonStyle(.bordered)
                
                Button {
                    sessionManager.isShowingSheet = true
                    sessionManager.isShowingFinishSheet = true
                } label: {
                    Image(systemName: "stop.fill")
                        .frame(height: 40)
                }
                .tint(.text.secondary)
                .buttonStyle(.bordered)
            }
            
            Button {
                if sessionManager.isPaused {
                    sessionManager.resumeSession()
                    withAnimation {
                        selectedTab = .session
                    }
                } else {
                    sessionManager.pauseSession()
                    withAnimation {
                        selectedTab = .session
                    }
                }
            } label: {
                Image(systemName: sessionManager.isPaused ? "play.fill" :  "pause.fill")
                    .frame(height: 40)
            }
            .tint(.primaryColor)
            .buttonStyle(.borderedProminent)
        }
        .navigationTitle("Controls")
        
    }
}

struct PomodoroControlsScreenView_Previews: PreviewProvider {
    static var previews: some View {
        let sessionManager = WatchPreviewFactory()
            .makeSessionManager()
        let mainVM = MainViewModel()
        
        PomodoroControlsScreenView(selectedTab: .constant(.session))
            .environmentObject(sessionManager)
            .environmentObject(mainVM)
    }
}
