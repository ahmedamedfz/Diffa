//
//  ContentView.swift
//  ddiffa
//
//  Created by Ahmad Fariz on 25/04/23.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var vm = ContentViewModel()
    
    var body: some View {
        if vm.hasFinishedOnboarding {
            TabbedScreenView()
        } else {
            OnboardingScreenView(finishedOnboardingHandler: vm.finishOnboarding)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
