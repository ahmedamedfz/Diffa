//
//  StretchingMainScreenView.swift
//  FocusFlow Watch App
//
//  Created by Dimas on 05/05/23.
//

import SwiftUI
import HealthKit

struct StretchingMainScreenView: View {
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                Text("Upper Body")
                    .font(.system(.title3, design: .rounded))
                    .foregroundColor(.text.primary)
                    .padding(.bottom, 4)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 12) {
                        ForEach(MainStretch.allStretch[0]) { stretch in
                            NavigationLink {
                                StretchingOnGoingScreenView(chosenStretch: stretch)
                            } label: {
                                WatchStretchingCard(mainStretch: stretch)
                            }
                            .buttonStyle(.borderless)
                            .cornerRadius(8)
                        }
                    }
                }
                
                Text("Lower Body")
                    .font(.system(.title3, design: .rounded))
                    .foregroundColor(.text.primary)
                    .padding(
                        EdgeInsets(top: 16, leading: 0, bottom: 4, trailing: 0)
                    )
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 12) {
                        ForEach(MainStretch.allStretch[1]) { stretch in
                            NavigationLink {
                                StretchingOnGoingScreenView(chosenStretch: stretch)
                            } label: {
                                WatchStretchingCard(mainStretch: stretch)
                            }
                            .buttonStyle(.borderless)
                            .cornerRadius(8)
                        }
                    }
                }
                
                Text("Back Body")
                    .font(.system(.title3, design: .rounded))
                    .foregroundColor(.text.primary)
                    .padding(
                        EdgeInsets(top: 16, leading: 0, bottom: 4, trailing: 0)
                    )
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 12) {
                        ForEach(MainStretch.allStretch[2]) { stretch in
                            NavigationLink {
                                StretchingOnGoingScreenView(chosenStretch: stretch)
                            } label: {
                                WatchStretchingCard(mainStretch: stretch)
                            }
                            .buttonStyle(.borderless)
                            .cornerRadius(8)
                        }
                    }
                }
                
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .navigationTitle("Stretch")
    }
}

struct StretchingScreenView_Previews: PreviewProvider {
    static var previews: some View {
        StretchingMainScreenView()
    }
}
