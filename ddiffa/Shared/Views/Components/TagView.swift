//
//  TagView.swift
//  ddiffa
//
//  Created by Ahmad Fariz on 27/04/23.
//

import Foundation
import SwiftUI

struct TagView: View {
    let tag: String
    let color: Color
    let onDelete: () -> Void
    
    var body: some View {
        Text(tag)
            .fixedSize()
            .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 25))
            .background(
                color.overlay(
                    Button(action: onDelete) {
                        Image(systemName: "xmark.circle.fill")
                            .resizable()
                            .frame(width: 15, height: 15)
                            .foregroundColor(.white)
                    }
                    .padding(5),
                    alignment: .trailing
                )
            )
            .foregroundColor(.white)
            .clipShape(Capsule())
    }
}
