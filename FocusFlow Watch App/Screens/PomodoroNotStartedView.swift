//
//  PomodoroNotStartedView.swift
//  FocusFlow Watch App
//
//  Created by Dimas on 04/05/23.
//

import SwiftUI

struct PomodoroNotStartedView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var mainVM: MainViewModel
    
    @FetchRequest(
        fetchRequest: PersistenceController.projectsRequest
    ) var projects: FetchedResults<Project>
    
    let pomodoroSessionManager = PomodoroSessionManager.shared
    
    // TODO: delete
    @FetchRequest(entity: Pomodoro.entity(), sortDescriptors: []) var sessions: FetchedResults<Pomodoro>
    
    @State var numberOfMinutes = 25
    @State var isShowingDurationPicker = false
    @State var scrollAmount = 0.0
    
    var body: some View {
        VStack {
            if projects.isEmpty {
                SessionEmptyView()
            } else {
                content
            }
        }
        .navigationTitle("FocusFlow")
    }
    
    var content: some View {
        ScrollView {
            
            VStack(alignment: .leading) {
                Text("Continue your last\nsessions with duration:")
                    .font(.system(.footnote, design: .rounded))
                    .foregroundColor(.text.secondary)
                    .scenePadding(.horizontal)
                
                Button {
                    isShowingDurationPicker.toggle()
                } label: {
                    HStack {
                        Text("\(numberOfMinutes) minutes")
                            .foregroundColor(.text.primary)
                            .font(.system(.caption, design: .rounded, weight: .semibold))
                        
                        Spacer()
                        
                        Image(systemName: "chevron.right")
                    }
                    .padding(8)
                }
                .buttonStyle(BorderedButtonStyle(tint: .primaryColor))
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            ForEach(projects.sorted(by: { projectA, projectB in
                let sessionsA = projectA.pomodoroSessions ?? []
                let latestSessionA = sessionsA.sorted { $0.finishedTime ?? .now > $1.finishedTime ?? .now }.first
                
                let sessionsB = projectB.pomodoroSessions ?? []
                let latestSessionB = sessionsB.sorted { $0.finishedTime ?? .now > $1.finishedTime ?? .now }.first
                
                return latestSessionA?.finishedTime ?? .now > latestSessionB?.finishedTime ?? .now
            })) { project in
                PomodoroSessionCardView(project: project)
                    .onTapGesture {
                        // call startNewSession
                        pomodoroSessionManager.startNewSession(for: project, withDurationTarget: numberOfMinutes * 60)
                        
                        // handle change to screen pomodoro
                        mainVM.goToPomodoroOngoingScreen()
                    }
            }
            
        }
        .offset(y: scrollAmount)
        .sheet(isPresented: $isShowingDurationPicker) {
            sheet
        }
    }
    
    var sheet: some View {
        Picker("", selection: $numberOfMinutes) {
            ForEach(1...60, id: \.self) {
                Text("\($0)")
                    .onTapGesture {
                        isShowingDurationPicker = false
                    }
            }
            .offset(y: scrollAmount)
        }
    }
}

struct PomodoroNotStartedView_Previews: PreviewProvider {
    static var previews: some View {
        PomodoroNotStartedView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
