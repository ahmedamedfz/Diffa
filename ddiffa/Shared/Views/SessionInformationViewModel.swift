//
//  SessionInformationViewModel.swift
//  ddiffa
//
//  Created by Dimas on 03/05/23.
//

import SwiftUI

extension SessionInformationView {
    class ViewModel: ObservableObject {
        @Published var isExpanded: Bool = false
        
        @Published var isProjectFocused = false
        @Published var needToHandleKeyboardDissmiss = false
        
        @Published var projectQuery = ""
        @Binding var tags: [Tag]
        @Binding var tagQuery: String
        
        init(
            isExpanded: Binding<Bool>,
//            projectQuery: Binding<String>,
            tags: Binding<[Tag]>,
            tagQuery: Binding<String>
        ) {
//            self._isExpanded = isExpanded
//            self._projectQuery = projectQuery
            self._tags = tags
            self._tagQuery = tagQuery
        }
        
        func updateView() {
            objectWillChange.send()
        }
    }
}

struct PomodoroNotStartedScreenView_Previews: PreviewProvider {
    static var previews: some View {
        PomodoroNotStartedScreenView()
            .preferredColorScheme(.dark)
    }
}
