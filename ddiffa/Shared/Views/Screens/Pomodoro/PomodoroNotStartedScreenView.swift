//
//  PomodoroNotStartedScreenView.swift
//  ddiffa
//
//  Created by Dimas on 26/04/23.
//

import SwiftUI
import CoreData

enum FocusedField {
    case tag, projectField, information
}

struct PomodoroNotStartedScreenView: View {
    
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @State var tags: [Tag] = []
    
    @FetchRequest(sortDescriptors: [
        SortDescriptor(\.startTime)
    ]) var lastPomodoroSessions: FetchedResults<Pomodoro>
    
    @State private var projectQuery = ""
    @State private var tagQuery = ""
    @State private var isExpandInformation = false
    
    @FocusState var focusedField: FocusedField?
    
    var currentSession: Pomodoro?
    
    init() {
        currentSession = Pomodoro(context: managedObjectContext)
    }
    
    var body: some View {
        ZStack {
            Color.background.base
                .ignoresSafeArea()
            
            VStack {
                Text(currentSession?.project?.name ?? "Default name")
                
                HStack {
                    ForEach(currentSession!.project?.arrayOfTags() ?? []) { tag in
                        TagView(tag: tag)
                    }
                }
            }
        }
        .onTapGesture {
            focusedField = nil
            isExpandInformation = false
            
            print("isExpand: \(isExpandInformation)")
        }
        .safeAreaInset(edge: .bottom) {
            SessionInformationView(
                focusedField: $focusedField,
                isExpanded: $isExpandInformation,
                projectQuery: $projectQuery,
                tags: $tags,
                tagQuery: $tagQuery,
                currentSession: currentSession
            )
            .focused($focusedField, equals: .information)
            .onTapGesture {
                withAnimation {
                    isExpandInformation = true
                }
                print("isExpand: \(isExpandInformation)")
            }
        }
    }
}

struct PomodoroNotStartedScreenView_Previews: PreviewProvider {
    static var previews: some View {
        PomodoroNotStartedScreenView()
            .preferredColorScheme(.dark)
    }
}
