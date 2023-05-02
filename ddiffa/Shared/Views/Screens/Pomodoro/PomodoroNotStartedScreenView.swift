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
                projectQuery: $projectQuery,
                tags: $tags,
                tagQuery: $tagQuery
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

struct SessionInformationView: View {
    
    //    @FocusState private var focusedField: FocusedField?
    
    var focusedField: FocusState<FocusedField?>.Binding
    
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @FetchRequest var projectResults: FetchedResults<Project>

    @Binding var isExpanded: Bool
    @Binding var tags: [Tag]
    
    @StateObject private var vm: ViewModel
    
    init(
        focusedField: FocusState<FocusedField?>.Binding,
        isExpanded: Binding<Bool>,
        projectQuery: Binding<String>,
        tags: Binding<[Tag]>,
        tagQuery: Binding<String>
    ) {
        let request: NSFetchRequest<Project> = Project.fetchRequest()
        request.fetchLimit = 2
        request.sortDescriptors = []

        _projectResults = FetchRequest(fetchRequest: request)
        
        self.focusedField = focusedField
        self._tags = tags
        self._isExpanded = isExpanded
        self._vm = StateObject(
            wrappedValue: ViewModel(isExpanded: isExpanded,
//                                    projectQuery: projectQuery,
                                    tags: tags,
                                    tagQuery: tagQuery)
        )
    }
    
    var tagViews: some View {
        VStack {
            
            if !isExpanded {
                if tags.isEmpty {
                    Text("Add Tag")
                        .foregroundColor(.text.tertiary)
                        .padding(EdgeInsets(top: 6, leading: 16, bottom: 6, trailing: 16))
                        .overlay {
                            RoundedRectangle(cornerRadius: 16)
                                .inset(by: 1.5) // inset value should be same as lineWidth in .stroke
                                .stroke(Color.primaryColor, lineWidth: 1.5)
                        }
                } else {
                    EmptyView()
                }
            } else {
                HStack(spacing: 8) {
                    ForEach(vm.tags, id: \.self) { tag in
                        TagView(tag: tag)
                    }
                }
            }
        }
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            
            // MARK: Tag when not active
            
            ScrollView(.horizontal) {
                tagViews
            }
            .scrollIndicators(.never)
            .frame(height: !isExpanded ? nil : 0)
            .opacity(isExpanded ? 0 : 1)
            .clipped()
            
            // MARK: Project
            
            Text("Project")
                .font(.system(.title3, design: .rounded))
                .foregroundColor(.text.primary)
                .frame(height: isExpanded ? nil : 0)
                .opacity(isExpanded ? 1 : 0)
            
            HStack(spacing: 16) {
                TextField(text: $vm.projectQuery) {
                    Text("Tap to add your project")
                }
                .padding(.horizontal, 16)
                .frame(height: 56)
                .background(Color.background.secondary)
                .cornerRadius(8)
                .focused(focusedField, equals: .projectField)
                .overlay {
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(focusedField.wrappedValue == .projectField ? Color.primaryColor : Color.clear, lineWidth: 1.5)
                }
                .onTapGesture {
                    withAnimation(.easeIn(duration: 3)) {
                        focusedField.wrappedValue = .projectField
                    }
                    print("isExpand: \(isExpanded)")
                }
                .onChange(of: vm.projectQuery) { newValue in
                    projectResults.nsPredicate = newValue.isEmpty ? nil :
                    NSPredicate(format: "name CONTAINS[c] %@", newValue)
                    print("-----")
                    projectResults.forEach { project in
                        print(project.name)
                    }
                    vm.updateView()
                }
                
                Button {
                    print("implement: start pomodoro")
                } label: {
                    Image(systemName: "play.fill")
                        .resizable()
                        .frame(width: 16, height: 16)
                        .tint(.white)
                        .frame(width: 56, height: 56)
                        .background {
                            Color.primaryColor
                                .cornerRadius(100)
                        }
                }
            }
            .padding(.top, 16)
            .overlay {
                if !projectResults.isEmpty && !vm.projectQuery.isEmpty && focusedField.wrappedValue == .projectField {
                    VStack(alignment: .leading, spacing: 0) {
                        ForEach(projectResults, id: \.objectID) { project in
                            Text(project.name ?? "No name")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding()
                                .background(Color.background.base)
                                .onTapGesture {
                                    vm.projectQuery = project.name ?? "dim"
                                    print("pro: \(vm.projectQuery)")
                                    focusedField.wrappedValue = .none
                                }
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .offset(y: -50)
                }
            }
            
            // MARK: Tag when active
            
            VStack(alignment: .leading, spacing: 0) {
                Text("Tag")
                    .font(.system(.title3, design: .rounded))
                    .foregroundColor(.text.primary)
                    .padding(
                        EdgeInsets(top: 24, leading: 0, bottom: 16, trailing: 0)
                    )
                
                ScrollView(.horizontal) {
                    HStack(spacing: 8) {
                        HStack(spacing: 8) {
                            Image(systemName: "magnifyingglass")
                                .resizable()
                                .frame(width: 12, height: 12)
                            
                            TextField(
                                "",
                                text: $vm.tagQuery,
                                prompt:
                                    Text(focusedField.wrappedValue == .tag ?
                                         "                           "
                                         : "Add more tags")
                                    .foregroundColor(.white)
                            )
                            .tint(.white)
                            .focused(focusedField, equals: .tag)
                            .font(.system(.footnote, design: .rounded))
                        }
                        .padding(.horizontal, 16)
                        .frame(width: isExpanded ? nil : 0, height: 30)
                        .background {
                            if focusedField.wrappedValue == .tag {
                                Color.background.secondary
                            } else {
                                Color.primaryColor
                            }
                        }
                        .cornerRadius(100)
                        .overlay(
                            RoundedRectangle(cornerRadius: 100)
                                .inset(by: 1.5) // inset value should be same as lineWidth in .stroke
                                .stroke(focusedField.wrappedValue == .tag ? Color.primaryColor : .clear, lineWidth: 1.5)
                        )
                        
                        tagViews
                    }
                }
                .scrollIndicators(.never)
            }
            .frame(height: isExpanded ? nil : 0)
            .opacity(isExpanded ? 1 : 0)
            
        }
        .onSubmit {
            vm.needToHandleKeyboardDissmiss = true
        }
        .onChange(of: isExpanded, perform: { newValue in
            if newValue == false {
                focusedField.wrappedValue = nil
            }
        })
        .onChange(of: focusedField.wrappedValue, perform: { newValue in
            withAnimation(.default.delay(0.1)) {
                if newValue == .projectField {
                    vm.isProjectFocused = true
                } else {
                    vm.isProjectFocused = false
                }
                print(vm.isProjectFocused)
                
                if newValue != nil {
                    isExpanded = true
                }
            }
        })
        .padding(EdgeInsets(top: 16, leading: 16, bottom: 24, trailing: 16))
        .frame(maxWidth: .infinity)
        .background{Color.background.translucent}
    }
}

extension SessionInformationView {
    class ViewModel: ObservableObject {
        @Published var isExpanded: Bool = false
        
        @Published var isProjectFocused = false
        @Published var needToHandleKeyboardDissmiss = false
        
        @Published var projectQuery = ""
        @Binding var tags: [Tag]
        @Binding var tagQuery: String
        
        init(
            isExpanded: Binding<Bool>,
//            projectQuery: Binding<String>,
            tags: Binding<[Tag]>,
            tagQuery: Binding<String>
        ) {
//            self._isExpanded = isExpanded
//            self._projectQuery = projectQuery
            self._tags = tags
            self._tagQuery = tagQuery
        }
        
        func updateView() {
            objectWillChange.send()
        }
    }
}

struct PomodoroNotStartedScreenView_Previews: PreviewProvider {
    static var previews: some View {
        PomodoroNotStartedScreenView()
            .preferredColorScheme(.dark)
    }
}
