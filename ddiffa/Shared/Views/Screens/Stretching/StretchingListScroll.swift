//
//  StretchingListScroll.swift
//  ddiffa
//
//  Created by Angelica Patricia on 28/04/23.
//

import SwiftUI

struct StretchingListScroll: View {
    var stretchs: [Stretch]
    var body: some View {
        VStack(spacing: 25) {
            VStack(alignment: .leading, spacing:10) {
                Text("Upper Stretch")
                    .font(.system(.title3, design: .rounded))
                    .bold()
                    .foregroundColor(.text.primary)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 10) {
                        ForEach(stretchs.filter({ $0.category == "Upper Stretch" })) {
                            stretch in StretchingListCard(stretch:stretch)
                        }
                    }
                }
            }
            VStack(alignment: .leading, spacing:10) {
                Text("Lower Stretch")
                    .font(.system(.title3, design: .rounded))
                    .bold()
                    .foregroundColor(.text.primary)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 10) {
                        ForEach(stretchs.filter({ $0.category == "Lower Stretch" })) {
                            stretch in StretchingListCard(stretch:stretch)
                        }
                    }
                }
            }
            VStack(alignment: .leading, spacing:10) {
                Text("Back Stretch")
                    .font(.system(.title3, design: .rounded))
                    .bold()
                    .foregroundColor(.text.primary)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 10) {
                        ForEach(stretchs.filter({ $0.category == "Back Stretch" })) {
                            stretch in StretchingListCard(stretch:stretch)
                        }
                    }
                }
            }
        }
    }
}

struct StretchingListScroll_Previews: PreviewProvider {
    static var previews: some View {
        StretchingListScroll(stretchs: Stretch.all)
    }
}
