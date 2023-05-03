//
//  SessionInformationView.swift
//  ddiffa
//
//  Created by Dimas on 03/05/23.
//

import SwiftUI
import CoreData

struct SessionInformationView: View {
    
    //    @FocusState private var focusedField: FocusedField?
    
    var focusedField: FocusState<FocusedField?>.Binding
    
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @FetchRequest(fetchRequest: PomodoroSessionPersistence.projectQueryFetchRequest) var projectResults: FetchedResults<Project>
    @FetchRequest(fetchRequest: PomodoroSessionPersistence.tagQueryFetchRequest) var tagResults: FetchedResults<Tag>

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
        self.focusedField = focusedField
        self._tags = tags
        self._isExpanded = isExpanded
        self._vm = StateObject(
            wrappedValue: ViewModel(isExpanded: isExpanded,
                                    tags: tags,
                                    tagQuery: tagQuery)
        )
    }
    
    var tagViews: some View {
        VStack {
            if !isExpanded {
                if tags.isEmpty {
                    Text("Add Tag")
                        .font(.system(.footnote, design: .rounded))
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
                        TagView(tag: tag, isRemovable: isExpanded)
                            .onTapGesture {
                                if isExpanded {
                                    if let currentSession = vm.currentSession {
                                        vm.remove(tag: tag, from: currentSession)
                                    }
                                }
                            }
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
                    vm.updateView()
                }
                
                Button {
                    vm.startSession()
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
                                    vm.updateSession(in: managedObjectContext, projectObjectID: project.objectID)
                                    
                                    vm.updateView()
                                }
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .overlay {
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray, lineWidth: 1.5)
                    }
                    .offset(y: -57.5)
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
                            .onChange(of: vm.tagQuery) { newValue in
                                tagResults.nsPredicate = newValue.isEmpty ? nil :
                                NSPredicate(format: "name CONTAINS[c] %@", newValue)
                                vm.updateView()
                            }
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
            .overlay {
                if !vm.tagQuery.isEmpty && focusedField.wrappedValue == .tag && tagResults.first?.name != vm.tagQuery {
                    VStack(alignment: .leading, spacing: 0) {
                        
                   
                                Button {
                                    // TODO: change color string dynamically
                                    vm.addNewTag(name: vm.tagQuery,
                                                 colorString: "rose",
                                                 toContext: managedObjectContext)
                                    focusedField.wrappedValue = .none
                                    vm.tagQuery = ""
                                } label: {
                                    HStack(spacing: 8) {
                                        Text("Create new tag")
                                            .foregroundColor(.text.primary)
                                        
                                        TempTagView(name: vm.tagQuery, colorString: "rose")
                                    }
                                    .padding(.horizontal, 16)
                                }
                                
                                Spacer()
                                    .frame(height: 16)
                                
                                ForEach(tagResults, id: \.objectID) { tag in
                                    TagView(tag: tag, isRemovable: false)
                                        .padding(
                                            EdgeInsets(top: 12, leading: 16, bottom: 12, trailing: 16)
                                        )
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .background(Color.background.base)
                                        .onTapGesture {
        //                                    vm.projectQuery = project.name ?? "dim"
        //                                    print("pro: \(vm.projectQuery)")
        //                                    focusedField.wrappedValue = .none
        //                                    vm.updateSession(in: managedObjectContext, projectObjectID: project.objectID)
        //
                                            vm.addTag(tag, to: managedObjectContext)
                                            vm.tagQuery = ""
                                            focusedField.wrappedValue = .none
                                            vm.updateView()
                                        }
                                }
                           
                        
                        
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.vertical, 16)
                    .background(Color.background.base)
                    .overlay {
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray, lineWidth: 1.5)
                    }
                    .offset(y: -87.5)
                }
            }
            
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

//struct SessionInformationView_Previews: PreviewProvider {
//    static var previews: some View {
//        SessionInformationView()
//    }
//}

