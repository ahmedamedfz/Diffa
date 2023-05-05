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
    
    var body: some View {
        VStack {
            HStack(spacing: 8) {
                Button {
                    sessionManager.discardSession()
                    mainVM.goToHomeScreen()
                    
                    print(mainVM)
                    
                    print("trash tapped")
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
        
        PomodoroControlsScreenView()
            .environmentObject(sessionManager)
            .environmentObject(mainVM)
    }
}
