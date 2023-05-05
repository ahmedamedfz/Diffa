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
                    sessionManager.discardSession()
                    mainVM.goToHomeScreen()
                } label: {
                    Image(systemName: "trash")
                        .frame(height: 40)
                }
                .tint(.red)
                .buttonStyle(.bordered)
                
                Button {
                    
                } label: {
                    Image(systemName: "stop.fill")
                        .frame(height: 40)
                }
                .tint(.text.secondary)
                .buttonStyle(.bordered)
            }
            
            Button {
                sessionManager.pauseSession()
                selectedTab = .session
            } label: {
                Image(systemName: "pause.fill")
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
