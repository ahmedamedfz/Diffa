//
//  AnalyticsView.swift
//  ddiffa
//
//  Created by Angelica Patricia on 04/05/23.
//

import SwiftUI

struct AnalyticsView: View {
    
    @State private var frequency = "Daily"
    var frequencies = ["Daily", "Weekly", "Monthly"]
    @State private var isPopUpOpen = false

    var body: some View {
        ZStack {
            VStack (spacing: 30) {
                HStack{
                    Spacer()
                    Button {
                        self.isPopUpOpen = true
                    } label: {
                        Image(systemName: "info.circle")
                            .imageScale(.large)
                            .foregroundColor(Color(red: 150/255, green: 97/255, blue: 32/255))
                    }
                }
                
                HStack {
                    Image(systemName: "person.circle.fill")
                        .font(.system(size: 64, design: .rounded))
                        .foregroundColor(.text.primary)
                    
                    VStack (alignment: .leading) {
                        HStack {
                            Text("Fallah's")
                            Spacer()
                            Image(systemName: "pencil")
                        }
                            .font(.system(.largeTitle, design: .rounded))
                            .foregroundColor(.text.primary)
                            .bold()
                        
                        Text("appleid_apple.com")
                            .font(.system(.title3, design: .rounded))
                            .foregroundColor(.text.secondary)
                    }
                    
                    
                }
                
                VStack {
                    Picker("Choose the frequency", selection: $frequency) {
                        ForEach(frequencies, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                    
                    DetailAnalyticsView()
                }
               
            }
            .padding()
            
            if isPopUpOpen {
                withAnimation{
                    LoginView(isPopUpOpen: $isPopUpOpen)
                }
            }
            
        }
    }
}

struct AnalyticsView_Previews: PreviewProvider {
    static var previews: some View {
        AnalyticsView()
    }
}
