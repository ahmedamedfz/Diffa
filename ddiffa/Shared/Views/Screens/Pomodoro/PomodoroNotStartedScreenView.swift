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
    
    @StateObject var timerManager = TimerManager()
    
    @State var tags: [Tag] = []
    
    @FetchRequest(sortDescriptors: [
        SortDescriptor(\.startTime)
    ]) var lastPomodoroSessions: FetchedResults<Pomodoro>
    
    @State private var projectQuery = ""
    @State private var tagQuery = ""
    @State private var isExpandInformation = false
    
    @FocusState var focusedField: FocusedField?
    
    let projectsNameMock = ["Mini Challenge 1", "Calculus Assignment"]
    let tagsMock = [["Work", "Programming"], ["College"]]
    
    
    var body: some View {
        ZStack {
            Color.background.base
                .ignoresSafeArea()
            
            ScrollView {
                VStack {
                    TimePickerView()
                        .frame(width: 280, height: 375)
                        .padding(.vertical, 24)
                        .padding()
                    if timerManager.timerMode == .initial{
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(0..<2) { index in
                                    ProjectCardView(projectName: projectsNameMock[index], tags: tagsMock[index])
                                }
                            }
                            .frame(height: 67)
                            .padding(.leading, 16)
                        }
                        
                        Spacer()
                            .offset(y: 140)
                    }
                }
            }
            .frame(maxWidth: .infinity)
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
        .environmentObject(timerManager)
    }
}

struct PomodoroNotStartedScreenView_Previews: PreviewProvider {
    static var previews: some View {
        PomodoroNotStartedScreenView()
//            .preferredColorScheme(.dark)
    }
}
