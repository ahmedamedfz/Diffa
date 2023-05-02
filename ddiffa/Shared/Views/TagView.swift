//
//  TagView.swift
//  ddiffa
//
//  Created by Dimas on 01/05/23.
//

import SwiftUI

struct TagView: View {
    
    let tag: Tag
    
    var body: some View {
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

struct TagView_Previews: PreviewProvider {
    static var previews: some View {
        TagView(tag: Tag(name: "Work", colorString: "orange"))
    }
}
