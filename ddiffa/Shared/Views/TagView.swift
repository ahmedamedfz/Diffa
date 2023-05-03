//
//  TagView.swift
//  ddiffa
//
//  Created by Dimas on 01/05/23.
//

import SwiftUI

struct TagView: View {
    
    let tag: Tag
    
    var isRemovable: Bool
    
    var body: some View {
        HStack(alignment: .center, spacing: 8) {
            Text(tag.name ?? "No name")
                .font(.system(.footnote, design: .rounded))
                .foregroundColor(Color("\(tag.colorString ?? "rose")-foreground"))
            
            if isRemovable {
                Image(systemName: "xmark.circle.fill")
                    .resizable()
                    .frame(width: 12, height: 12)
                    .foregroundColor(Color("\(tag.colorString ?? "rose")-foreground"))
            }
        }
            .padding(
                EdgeInsets(top: 6, leading: 16, bottom: 6, trailing: 16)
            )
            .background { Color("\(tag.colorString ?? "rose")-background") }
            .cornerRadius(100)
            .fixedSize()
    }
}

//struct TagView_Previews: PreviewProvider {
//    static var previews: some View {
//        TagView(tag: Tag(name: "Work", colorString: "orange"))
//    }
//}
