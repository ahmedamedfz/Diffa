//
//  PomodoroNotStartedScreenView.swift
//  ddiffa
//
//  Created by Dimas on 26/04/23.
//

import SwiftUI

enum FocusedField {
    case tag, project, information
}

struct PomodoroNotStartedScreenView: View {
    
    // MOCK
    @State var tagsMock = [
        Tag(name: "Work", colorString: "orange"),
        Tag(name: "Programming", colorString: "rose")
    ]
    
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
        }
        .safeAreaInset(edge: .bottom) {
            SessionInformationView(
                focusedField: $focusedField,
                isExpanded: $isExpandInformation,
                projectQuery: $projectQuery,
                tags: $tagsMock,
                tagQuery: $tagQuery
            )
            .focused($focusedField, equals: .information)
            .onTapGesture {
                withAnimation {
                    isExpandInformation = true
                }
            }
        }
    }
}

struct SessionInformationView: View {
    
    //    @FocusState private var focusedField: FocusedField?
    
    var focusedField: FocusState<FocusedField?>.Binding
    
    @ObservedObject private var vm: ViewModel
    
    init(
        focusedField: FocusState<FocusedField?>.Binding,
        isExpanded: Binding<Bool>,
        projectQuery: Binding<String>,
        tags: Binding<[Tag]>,
        tagQuery: Binding<String>
    ) {
        self.focusedField = focusedField
        self._vm = ObservedObject(
            wrappedValue: ViewModel(isExpanded: isExpanded,
                                    projectQuery: projectQuery,
                                    tags: tags,
                                    tagQuery: tagQuery)
        )
    }
    
    var tagViews: some View {
        HStack(spacing: 8) {
            ForEach(vm.tags, id: \.self) { tag in
                Text(tag.name)
                    .font(.system(.footnote, design: .rounded))
                    .foregroundColor(Color("\(tag.colorString)-foreground"))
                    .padding(
                        EdgeInsets(top: 6, leading: 16, bottom: 6, trailing: 16)
                    )
                    .background { Color("\(tag.colorString)-background") }
                    .cornerRadius(100)
                    .fixedSize()
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
            .frame(height: !vm.isExpanded ? nil : 0)
            .opacity(vm.isExpanded ? 0 : 1)
            .clipped()
            
            // MARK: Project
            
            Text("Project")
                .font(.system(.title3, design: .rounded))
                .foregroundColor(.text.primary)
                .frame(height: vm.isExpanded ? nil : 0)
                .opacity(vm.isExpanded ? 1 : 0)
            
            HStack(spacing: 16) {
                TextField(text: $vm.projectQuery) {
                    Text("Tap to add your project")
                }
                .padding(.horizontal, 16)
                .frame(height: 56)
                .background(Color.background.secondary)
                .cornerRadius(8)
                .focused(focusedField, equals: .project)
                .overlay {
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(focusedField.wrappedValue == .project ? Color.primaryColor : Color.clear, lineWidth: 1.5)
                }
                .onTapGesture {
                    withAnimation(.easeIn(duration: 3)) {
                        focusedField.wrappedValue = .project
                    }
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
                        .frame(width: vm.isExpanded ? nil : 0, height: 30)
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
            .frame(height: vm.isExpanded ? nil : 0)
            .opacity(vm.isExpanded ? 1 : 0)
            
        }
        .onSubmit {
            vm.needToHandleKeyboardDissmiss = true
        }
        .onChange(of: vm.isExpanded, perform: { newValue in
            if newValue == false {
                focusedField.wrappedValue = nil
            }
        })
        .onChange(of: focusedField.wrappedValue, perform: { newValue in
            withAnimation(.default.delay(0.1)) {
                if newValue == .project {
                    vm.isProjectFocused = true
                } else {
                    vm.isProjectFocused = false
                }
                print(vm.isProjectFocused)
                
                if newValue != nil {
                    vm.isExpanded = true
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
        @Binding var isExpanded: Bool
        
        @Published var isProjectFocused = false
        @Published var needToHandleKeyboardDissmiss = false
        
        @Binding var projectQuery: String
        @Binding var tags: [Tag]
        @Binding var tagQuery: String
        
        init(isExpanded: Binding<Bool>, projectQuery: Binding<String>, tags: Binding<[Tag]>, tagQuery: Binding<String>) {
            self._isExpanded = isExpanded
            self._projectQuery = projectQuery
            self._tags = tags
            self._tagQuery = tagQuery
        }
    }
}

struct PomodoroNotStartedScreenView_Previews: PreviewProvider {
    static var previews: some View {
        PomodoroNotStartedScreenView()
            .preferredColorScheme(.dark)
    }
}

// MARK: Mocks

struct Tag: Hashable {
    let name: String
    let colorString: String
}
