//
//  EditOngoingBanner.swift
//  ddiffa
//
//  Created by Ahmad Fariz on 26/04/23.
//
import SwiftUI

struct EditOngoingBanner: View {
    @State var projectName: String
    @State var isEditingProjectName = false
    @State var projectTags: [String] = ["work", "study", "project"]
    @State var isAddingTag = false
    @State var newTag = ""
    
    var generateRandomTagColor: Color {
        Color(hue: Double.random(in: 0...1), saturation: 0.6, brightness: 0.6)
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            if isEditingProjectName {
                            TextField("Project Name", text: $projectName, onCommit: {
                                isEditingProjectName = false
                            })
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                        } else {
                            HStack{
                                Text(projectName)
                                Image(systemName: "square.and.pencil").foregroundColor(.gray)
                            }.onTapGesture {
                                isEditingProjectName = true
                            }
                        }
            TagCloudView(tags: projectTags, spacing: 10, generateRandomTagColor: { generateRandomTagColor }, onDelete: { tag in projectTags.removeAll(where: { $0 == tag }) })
            Button(action: { isAddingTag.toggle() }) {
                Image(systemName: "plus.circle.fill")
                    .resizable()
                    .frame(width: 30, height: 30)
            }
            if isAddingTag {
                TextField("New Tag", text: $newTag, onCommit: {
                    if !newTag.isEmpty {
                        projectTags.append(newTag)
                        newTag = ""
                        isAddingTag = false
                    }
                })
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
        }
        .padding()
        .frame(width: 300.00)
        .background(Color(.white))
        .cornerRadius(8).shadow(radius: 10)
    }
}
