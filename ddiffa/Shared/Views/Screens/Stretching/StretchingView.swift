//
//  StretchingScroll.swift
//  ddiffa
//
//  Created by Angelica Patricia on 03/05/23.
//


import SwiftUI

struct StretchingScroll: View {
    var allStretchs = MainStretch.allStretch
    @State private var path = NavigationPath()
    
    var body: some View {
        NavigationStack{
            VStack (spacing: 0) {
                
                VStack(spacing:0) {
                    Text("Stretch")
                        .foregroundColor(.text.primary)
                        .font(.system(.largeTitle, design: .rounded))
                        .bold()
                    Text("To keep you fresh, do this stretch!")
                        .foregroundColor(.text.secondary)
                        .font(.system(.title2, design: .rounded))
                }
                
                VStack(alignment: .leading, spacing: 10) {
                    List(allStretchs, id: \.self) { allStretch in
                        Text(allStretch.first!.category)
                            .font(.system(.title3, design: .rounded))
                            .bold()
                            .foregroundColor(.text.primary)
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 10) {
                                ForEach(allStretch) { someMainStretch in
                                    NavigationLink {
                                        WaitingSessionStartView(index: 0, mainStretch: someMainStretch)
                                    } label: {
                                        StretchingCard(mainStretch: someMainStretch)
                                    }
                                }
                            }
                        }
                        .listRowSeparator(.hidden)
                    }
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .preferredColorScheme(.dark)
    }
}

struct StretchingScroll_Previews: PreviewProvider {
    static var previews: some View {
        StretchingScroll(allStretchs: MainStretch.allStretch)
    }
}
