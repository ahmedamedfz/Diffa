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
    var sumTime : Int = 0
    
    var body: some View {
        NavigationStack{
            VStack (spacing: 30) {
                
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
                    ForEach(allStretchs, id: \.self) { allStretch in
                        Text(allStretch.first!.category)
                            .padding(.top)
                            .font(.system(.title3, design: .rounded))
                            .bold()
                            .foregroundColor(.text.primary)
                            .listRowBackground(Color.clear)
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 20) {
                                ForEach(allStretch) { someMainStretch in
                                    NavigationLink {
                                        WaitingSessionStartView(index: 0, mainStretch: someMainStretch, sumTime: sumTime)
                                    } label: {
                                        StretchingCard(mainStretch: someMainStretch)
                                    }
                                }
                            }
                        }
                        
                    }
                    .padding(.leading, 30)
                    
                }
                Spacer()
            }.padding(.top, 20)
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct StretchingScroll_Previews: PreviewProvider {
    static var previews: some View {
        StretchingScroll(allStretchs: MainStretch.allStretch)
    }
}
