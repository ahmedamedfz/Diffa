//
//  ProgressDotIndicator.swift
//  ddiffa
//
//  Created by Dimas on 25/04/23.
//

import SwiftUI

struct ProgressDotIndicator: View {
    
    private var currentIndex: Int
    private var total: Int
    
    /// - Parameters:
    ///   - currentIndex: Index for the active state. Starts from 0
    ///   - total: Total number of the states
    init(currentIndex: Int, total: Int) {
        self.currentIndex = currentIndex
        self.total = total
    }
    
    var body: some View {
        HStack(spacing: 8) {
            ForEach(0..<total, id: \.self) { i in
                RoundedRectangle(cornerSize: .init(width: 100, height: 100))
                    .fill(currentIndex == i ? Color.primaryColor : Color.primaryTransluctent48)
                    .frame(
                        width: currentIndex == i ? 40 : 12,
                        height: 12
                    )
            }
        }
    }
}

struct ProgressDotIndicator_Previews: PreviewProvider {
    static var previews: some View {
       ProgressDotIndicator(currentIndex: 0, total: 3)
            
    }
}
