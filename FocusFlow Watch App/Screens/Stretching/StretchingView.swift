//
//  StretchingView.swift
//  FocusFlow Watch App
//
//  Created by Dimas on 06/05/23.
//

import SwiftUI

struct StretchingView: View {
    @EnvironmentObject private var stretchingManager: StretchSessionManager
    let stretch: SubStretch
    
//    var timer = Timer.publish(every: 1, on: .main, in: .common)
//        .autoconnect()
//    @State var passedTime = 0
    @State var isShowingDescription = false

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            
            HStack(alignment: .top) {
                Text(stretch.title)
                    .lineLimit(nil)
                    .fixedSize(horizontal: false, vertical: true)
                    .font(.system(.title2, design: .rounded, weight: .semibold))
                
                Spacer()
                
                Button {
                    isShowingDescription = true
                } label: {
                    Image(systemName: "info.circle")
                        .padding(
                            EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
                        )
                }
                .buttonStyle(.plain)
            }
            
            Spacer()
            
//            VStack(alignment: .leading) {
//                Text("Elapsed Time")
//                    .font(.system(.body, design: .rounded))
//                    .foregroundColor(.text.secondary)
                
            Text(TimeInterval.secondsToHourMinFormat(time: TimeInterval(stretch.duration - stretchingManager.passedTime))!)
                    .font(.system(.title2))
//                    .foregroundColor(<#T##color: Color?##Color?#>)
//            }
            
            Text("101 bpm")
                .font(.system(.title3))
                .foregroundColor(.red)
            
            Text("101 cal")
                .font(.system(.title3))
                .foregroundColor(.green)
        }
        .sheet(isPresented: $isShowingDescription) {
            ScrollView {
                VStack(alignment: .leading) {
                    Text(stretch.title)
                        .lineLimit(nil)
                        .fixedSize(horizontal: false, vertical: true)
                        .font(.system(.title2, design: .rounded, weight: .semibold))
                        .padding(.vertical)
                    
                    Text(stretch.description)
                }
                .frame(maxWidth: .infinity)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
//        .onReceive(stretchingManager.timer) { _ in
//                stretchingManager.updateSession()
//        }
    }
}

struct StretchingView_Previews: PreviewProvider {
    
    static var previews: some View {
        let stretchingManager = StretchSessionManager()
        stretchingManager.startStretching(MainStretch.backAll.first!, fromIndex: 1)
        
        return StretchingView(stretch: MainStretch.backAll.first!.substretch.first!)
            .environmentObject(stretchingManager)
    }
}
