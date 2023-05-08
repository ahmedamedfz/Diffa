//
//  AnalyticsView.swift
//  ddiffa
//
//  Created by Angelica Patricia on 04/05/23.
//

import SwiftUI

struct AnalyticsView: View {
    
    //@State private var frequency = "Daily"
    
    @State private var isPopUpOpen = false
    @State private var userNames = ""
    @State private var userEmail = ""
    @State private var isOn = false
    
    init() {
        // Retrieve saved user data from UserDefaults
        let defaults = UserDefaults.standard
        self._userNames = State(initialValue: defaults.string(forKey: "userNames") ?? "")
        self._userEmail = State(initialValue: defaults.string(forKey: "userEmail") ?? "")
    }
    
    var body: some View {
        ZStack {
            VStack (spacing: 30) {
                HStack {
                    Image(systemName: "person.circle.fill")
                        .font(.system(size: 64, design: .rounded))
                        .foregroundColor(.text.primary)
                    
                    VStack (alignment: .leading) {
                        HStack {
                            Text(userNames)
                            Spacer()
                            if userNames.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                                Button {
                                    self.isPopUpOpen = true
                                } label: {
                                    Image(systemName: "info.circle")
                                        .imageScale(.small)
                                        .foregroundColor(Color.background.base)
                                }
                            }
                        }
                        .font(.system(.largeTitle, design: .rounded))
                        .foregroundColor(.text.primary)
                        .bold()
                        
                        Text(userEmail)
                            .font(.system(.title3, design: .rounded))
                            .foregroundColor(.text.secondary)
                    }
                    
                    
                }
                
                VStack {
                    
                    Toggle(isOn: $isOn){
                        Text("debug")
                    }
                    if isOn {
                        DetailAnalyticsView()
                    } else {
                        AnalyticsDetailView()
                    }
                }
                
            }
            .padding()
            
            if isPopUpOpen {
                withAnimation {
                    ZStack{
                        LoginView(isPopUpOpen: $isPopUpOpen, userNames: $userNames, userEmail: $userEmail)
                            .onDisappear {
                                // Save user data to UserDefaults when the login view is dismissed
                                let defaults = UserDefaults.standard
                                defaults.set(userNames, forKey: "userNames")
                                defaults.set(userEmail, forKey: "userEmail")
                            }
                    }
                }
                
            }
            
        }
    }
}

enum Frequency: String, CaseIterable {
    case daily = "Daily"
    case weekly = "Weekly"
    case monthly = "Monthly"
}
