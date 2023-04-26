//
//  TagCloudView.swift
//  ddiffa
//
//  Created by Ahmad Fariz on 27/04/23.
//

import SwiftUI

import SwiftUI

struct TagCloudView: View {
    let tags: [String]
    let spacing: CGFloat
    let generateRandomTagColor: () -> Color
    let onDelete: (String) -> Void
    
    @State private var tagSizes: [String: CGSize] = [:]
    
    var body: some View {
        ScrollView(.horizontal) {
            ZStack(alignment: .topLeading) {
                ForEach(tags, id: \.self) { tag in
                    TagView(tag: tag, color: generateRandomTagColor(), onDelete: { onDelete(tag) })
                        .background(
                            GeometryReader { proxy in
                                Color.clear.onAppear {
                                    tagSizes[tag] = proxy.size
                                }
                            }
                        )
                        .offset(offset(for: tag))
                }
            }
            .frame(height: height)
        }
    }
    
    private func offset(for tag: String) -> CGSize {
        guard let index = tags.firstIndex(of: tag) else { return .zero }
        var x: CGFloat = 0
        var y: CGFloat = 0
        var maxHeight: CGFloat = 0
        for i in 0..<index {
            let otherTag = tags[i]
            guard let size = tagSizes[otherTag] else { continue }
            if x + size.width + spacing > UIScreen.main.bounds.width {
                x = 0
                y += maxHeight + spacing
                maxHeight = 0
            }
            x += size.width + spacing
            maxHeight = max(maxHeight, size.height)
        }
        return CGSize(width: x, height: y)
    }
    
    private var height: CGFloat {
        var x: CGFloat = 0
        var y: CGFloat = 0
        var maxHeight: CGFloat = 0
        for tag in tags {
            guard let size = tagSizes[tag] else { continue }
            if x + size.width + spacing > UIScreen.main.bounds.width {
                x = 0
                y += maxHeight + spacing
                maxHeight = 0
            }
            x += size.width + spacing
            maxHeight = max(maxHeight, size.height)
        }
        return y + maxHeight
    }
}
