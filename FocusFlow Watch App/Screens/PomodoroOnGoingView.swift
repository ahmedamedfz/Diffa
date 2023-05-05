//
//  PomodoroOnGoingView.swift
//  FocusFlow Watch App
//
//  Created by Dimas on 04/05/23.
//

import SwiftUI
import CoreData
import WatchKit

struct PomodoroOnGoingView: View {
    
    enum Tab {
        case controls, session, nowPlaying
    }
//    @Environment(\.managedObjectContext) var viewContext
    
    @EnvironmentObject var sessionManager: PomodoroSessionManager
    @EnvironmentObject var mainVM: MainViewModel
    
    @State var selectedTab: Tab = .session
    
    var body: some View {
        TabView(selection: $selectedTab) {
            PomodoroControlsScreenView(
                selectedTab: $selectedTab
            )
            .tag(Tab.controls)
            
            PomodoroScreenView()
            .tag(Tab.session)
            
            NowPlayingView()
                .edgesIgnoringSafeArea(.all)
                .tag(Tab.nowPlaying)
        }
        .sheet(isPresented: $sessionManager.isShowingSheet) {
            if sessionManager.isShowingFinishSheet {
                finishSessionConfirmationSheet
            } else {
                discardSessionConfirmationSheet
            }
        }
    }
    
    var discardSessionConfirmationSheet: some View {
        VStack {
            Text("Do you want to delete your current session?")
            
            Spacer()
            
            VStack {
                Button {
                    sessionManager.isShowingSheet = false
                    sessionManager.discardSession()
                    mainVM.goToHomeScreen()
                } label: {
                    Text("Yes, Delete")
                }
                .tint(.red)
                
                Button {
                    sessionManager.isShowingSheet = false
                    selectedTab = .session
                } label: {
                    Text("Cancel")
                }
            }
        }
        .navigationBarHidden(true)
    }
    
    var finishSessionConfirmationSheet: some View {
        VStack {
            Text("Do you want to finish your current session?")
            
            Spacer()
            
            VStack {
                Button {
//                    sessionManager.isShowingSheet = false
                    //                    mainVM.goToHomeScreen()
                    sessionManager.finishSession()
                    
                    sessionManager.isShowingResultSheet = true
                } label: {
                    Text("Yes, Finish")
                }
                .tint(Color.primaryColor)
                
                Button {
                    sessionManager.isShowingSheet = false
                } label: {
                    Text("Cancel")
                }
            }
        }
        .navigationBarHidden(true)
        .sheet(isPresented: $sessionManager.isShowingResultSheet) {
            ScrollView {
                Text("Session Finished!")
                    .font(.system(.title3, design: .rounded))
                    .padding(.bottom, 6)
                
                Text("🎉")
                    .font(.largeTitle)
                
                HStack {
                    Text("Duration:")
                        .font(.system(.caption2, design: .rounded))
                        .foregroundColor(.text.secondary)
                    
                    Text(TimeInterval.secondsToHourMinFormat(time: TimeInterval(sessionManager.passedSeconds))!)
                        .font(.system(.body, design: .rounded))
                }
                
                Button {
                    sessionManager.isShowingSheet = false
                    mainVM.goToHomeScreen()
                } label: {
                    Text("Dismiss")
                }
                .buttonStyle(.borderedProminent)
                .tint(Color.primaryColor)
            }
            .navigationBarHidden(true)
        }
    }
    
}

struct PomodoroOnGoingView_Previews: PreviewProvider {
    static var previews: some View {
        let sessionManager = WatchPreviewFactory()
                                .makeSessionManager(withDurationTarget: 5 * 60)
        
        return PomodoroOnGoingView()
            .environmentObject(sessionManager)
            .environmentObject(MainViewModel())
    }
}
