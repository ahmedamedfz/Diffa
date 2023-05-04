//
//  ContentView.swift
//  FocusFlow Watch App
//
//  Created by Dimas on 04/05/23.
//

import SwiftUI

struct ContentView: View {
    
    @FetchRequest(fetchRequest: PersistenceController.onGoingSessionRequest) var onGoingPomodoroSession: FetchedResults<Pomodoro>
    
    @EnvironmentObject var mainVM: MainViewModel
    
    let pomodoroSessionManager = PomodoroSessionManager.shared
    
    var body: some View {
        NavigationStack {
            if  !onGoingPomodoroSession.isEmpty || mainVM.appState == .pomodoroSessionOnGoing {
                PomodoroOnGoingView()
                    .environmentObject(pomodoroSessionManager)
            } else if mainVM.appState == .stretchingSessionOngoing {
                Text("TODO: on going stretching view")
            } else {
                PomodoroNotStartedView()
            }
        }
        .onAppear {
            if !onGoingPomodoroSession.isEmpty {
                let session = onGoingPomodoroSession.first!
                pomodoroSessionManager.startNewSession(for: session.project!, withDurationTarget: Int(session.duration))
            }
        }
    }
}

class MainViewModel: ObservableObject {
    
    enum AppState {
        case pomodoroSessionOnGoing
        case stretchingSessionOngoing
        case nothing
    }
    
    @Published var appState: AppState = .nothing
    
    // TODO: handle transition to pomodoro on going
    func goToPomodoroOngoingScreen() {
        appState = .pomodoroSessionOnGoing
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
            .previewDevice("Apple Watch SE (44mm) (2nd generation)")
    }
}
