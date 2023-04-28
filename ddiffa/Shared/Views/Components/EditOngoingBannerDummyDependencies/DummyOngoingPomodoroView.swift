//
//  DummyOngoingPomodoroView.swift
//  ddiffa
//
//  Created by Ahmad Fariz on 26/04/23.
//

import Foundation

import SwiftUI

struct DummyOngoingPomodoroView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
            Spacer()
            EditOngoingBanner(projectName: "default")
        }
        .padding()
    }
}
struct DummyOngoingPomodoroView_Previews: PreviewProvider {
    static var previews: some View {
        DummyOngoingPomodoroView()
    }
}
