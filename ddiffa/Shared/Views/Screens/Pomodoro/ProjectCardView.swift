//
//  ProjectCardView.swift
//  ddiffa
//
//  Created by Dinda Alifiya Ramadhina on 02/05/23.
//

import SwiftUI

struct ProjectCardView: View {
    
    let projectName: String
    //    let tag1: String
    let tags: [String]
    
    
    var body: some View {
        ZStack {
            HStack (spacing :4) {
                VStack(spacing: 4) {
                    HStack(spacing: 6) {
                        Image(systemName: "circle.fill")
                            .font(.system(size: 6))
                            .foregroundColor(Color(red: 34/255, green: 197/255, blue: 94/255))
                        
                        Text ("Mini Challenge 1")
                            .font(.system(.body, design: .rounded))
                            .foregroundColor(.text.primary)
                            .frame(width: 156, height: 25, alignment: .leading)
                    }
                    
                    
                    ScrollView(.horizontal) {
                        HStack {
                            ForEach(tags, id: \.self) { tag in
                                Text (tag)
                                    .font(.system(.footnote, design: .rounded))
                                    .foregroundColor(Color(red: 249/255, green: 115/255, blue: 22/255))
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 2)
//                                    .frame(width: 60, height: 22, alignment: .center)
                                    .background(Color(red: 249/255, green: 115/255, blue: 2/255, opacity: 0.16))
                                    .cornerRadius(100)
                                
                            }
                        }
                    }
                    //                    .frame(width: 168, height: 25, alignment: .leading)
                    
                    
                }
                
                
                Image(systemName: "play")
                    .resizable()
                    .fixedSize()
                    .foregroundColor(.text.primary)
                    .frame(width: 20, height: 20, alignment: .center)
            }
            .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 12))
            .frame(width: 220, height: 67, alignment: .leading)
            .background (Color.background.secondary)
            .cornerRadius(8)
            
            
            
            
            
            
        }
    }
    
    
    
    struct ProjectCardView_Privews: PreviewProvider {
        static var previews: some View {
            ProjectCardView(projectName: "Pre-thesis", tags: ["College", "Programming"])
        }
    }
}


