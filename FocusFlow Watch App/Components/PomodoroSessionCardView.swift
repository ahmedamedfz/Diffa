//
//  PomodoroSessionCardView.swift
//  FocusFlow Watch App
//
//  Created by Dimas on 04/05/23.
//

import SwiftUI
import CoreData

struct PomodoroSessionCardView: View {
    let project: Project
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                HStack(spacing: 6) {
                    Circle()
                        .fill(Color("\(project.color ?? "rose")-foreground"))
                        .frame(width: 6)
                    
                    Text("\(project.name ?? "No project")")
                        .font(.system(.body, design: .rounded))
                        .foregroundColor(.text.primary)
                }
                
                if project.arrayOfTags().isEmpty {
                    Text("No tag")
                        .font(.system(size: 12, design: .rounded))
                        .foregroundColor(.text.tertiary)
                        .padding(.leading, 12)
                } else {
                    ScrollView(.horizontal) {
                        HStack(spacing: 4) {
                            ForEach(project.arrayOfTags().sorted {$0.name ?? "" < $1.name ?? ""}) { tag in
                                HStack(spacing: 0) {
                                    Text(tag.name ?? "")
                                        .foregroundColor(Color("\(tag.colorString ?? "rose")-foreground"))
                                    if project.arrayOfTags().sorted(by: {$0.name ?? "" < $1.name ?? ""}).last != tag {
                                        Text(",")
                                    }
                                }
                                .font(.system(size: 12, design: .rounded))
                            }
                        }
                    }
//                    .padding(.leading, 12)
                }
            }
            
            Spacer()
            
            Image(systemName: "play.fill")
                .foregroundColor(.primaryColor)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.vertical, 8)
        .scenePadding(.horizontal)
        .background {Color.background.primary}
        .cornerRadius(8)
    }
}

struct PomodoroSessionCardView_Previews: PreviewProvider {
    static var previews: some View {
        let session = PersistenceController.pomodoroSessionsPreview.first!
        
        return PomodoroSessionCardView(
            project: session.project!
        )
            
    }
}
