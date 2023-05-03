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
    
    var body: some View {
        ZStack {
            Color.background.base
                .ignoresSafeArea()
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
                tags: $tags
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
    }
}
