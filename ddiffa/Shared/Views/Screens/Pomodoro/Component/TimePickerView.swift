//
//  Home.swift
//  TimerPicker
//
//  Created by Falah Hasbi Assidiqi on 28/04/23.
//

import SwiftUI
import NotificationCenter

struct TimePickerView: View {
    
//    @StateObject var timerManager = TimerManager()
    @EnvironmentObject var timerManager: TimerManager
    @State private var play: Bool = false
    let colorCircle = Gradient(colors: [
        Color(red: 68/255, green: 60/255, blue: 255/255),
        Color(red: 127/255, green: 54/255, blue: 245/255)
    ])
    
    var body: some View {
            
            timePicker
    }
    
    var timePicker: some View {

            VStack {
                if timerManager.timerMode == .initial {
                    Text("How long you want\n  your session last?")
                        .font(.title3)
                        .padding()
                        .foregroundColor(.text.primary)
                        .frame(height: 90)
                    timerSlider()
                } else {
                    timerSlider()

                    HStack(spacing: 22) {
                        Circle()
                            .fill(Color(red: 241/255, green: 245/255, blue: 249/255, opacity: 0.65))
                            .frame(width: 74, height: 74)
                            .overlay(
                                Image(systemName: "stop.fill")
                                    .resizable()
                                    .frame(width: 34, height: 34)
                                    .foregroundColor(.primaryColor)

                            )
                            .onTapGesture(perform: {
                                timerManager.reset()
                            })
                        Circle()
                            .fill(Color(red: 241/255, green: 245/255, blue: 249/255, opacity: 0.65))
                            .frame(width: 74, height: 74)
                            .overlay(
                                Image(systemName: timerManager.timerMode == .pause ? "play.fill" : "pause.fill")
                                    .resizable()
                                    .frame(width: 34, height: 34)
                                    .foregroundColor(.primaryColor)

                            )
                            .onTapGesture(perform: {timerManager.timerMode == .running ? timerManager.pause() : timerManager.start()})
                    }
                }
            }

    }
    
    // MARK: Timer Slider
    @ViewBuilder
    func timerSlider() -> some View {
        GeometryReader { proxy in
            
            let widthSlider = proxy.size.width
            
            ZStack {
                // MARK: Clock
                ForEach(1...60, id: \.self) { index in
                    Rectangle()
                        .fill(index % 5 == 0 ? .white : .gray)
                        .frame(width: 2, height: index % 5 == 0 ? 10 : 5)
                        .offset(y: (widthSlider - 90) / 1.6)
                        .rotationEffect(.init(degrees: Double(index) * 6))
                }
                
                // MARK: Clock Text
                let clockText = [30, 45, 60, 15]
                ForEach(clockText.indices, id: \.self) { index in
                    
                    Text("\(clockText[index])")
                        .font(.caption.bold())
                        .foregroundColor(.white)
                        .rotationEffect(.init(degrees: Double(index) * -90))
                        .offset(y: (widthSlider - 90) / 1.9)
                        .rotationEffect(.init(degrees: Double(index) * 90))
                }
                
                // MARK: Circle Slider
                Circle()
                    .stroke(.white.opacity(0.06), lineWidth: 32)
                
                if timerManager.timerMode == .running {
                    Circle()
                        .trim(from: 0, to: CGFloat(timerManager.toProgress))
                        .stroke(LinearGradient(gradient: colorCircle, startPoint: .trailing, endPoint: .leading), style: StrokeStyle(lineWidth: 32, lineCap: .round, lineJoin: .round))
                        .rotationEffect(.init(degrees: -90))
                        .onChange(of: timerManager.secondsLeft) { _ in
                            timerManager.toProgress = CGFloat(timerManager.secondsLeft) / 3600
                        }
                } else {
                    Circle()
                        .trim(from: 0, to: CGFloat(timerManager.toProgress))
                        .stroke(LinearGradient(gradient: colorCircle, startPoint: .trailing, endPoint: .leading), style: StrokeStyle(lineWidth: 32, lineCap: .round, lineJoin: .round))
                        .rotationEffect(.init(degrees: -90))
                    
                    if timerManager.timerMode == .initial {
                        Circle()
                            .fill(.white)
                            .frame(width: 30, height: 30)
                        // Rotating image inside circle
                            .offset(x: widthSlider / 2)
                            .rotationEffect(.init(degrees: timerManager.toAngle))
                            .gesture(
                                DragGesture()
                                    .onChanged({ value in
                                        timerManager.onDrag(value: value)
                                    })
                            )
                            .rotationEffect(.init(degrees: -90))
                    }
                }
                 
                // MARK: Minutes Text
                VStack {
                    Text(timerManager.timerMode == .initial ? "\(timerManager.getTimeDifference()) : 00" : timerManager.secondsToMinutesAndSeconds(seconds: timerManager.secondsLeft))
                        .font(.largeTitle.bold())
                        .foregroundColor(.text.primary)
                    
                    Text(timerManager.timerMode == .initial ? "Minutes" : "Elapsed Time")
                        .foregroundColor(.text.secondary)
                        .font(.body)
                }
            }
        }
//        .frame(width: screenBounds().width / 1.4, height: timerManager.timerMode == .initial ? screenBounds().height / 1.4 : screenBounds().height / 2)
    }
}

struct TimePicker_Privews: PreviewProvider {
    static var previews: some View {
        TimePickerView()
            .environmentObject(TimerManager())
    }
}
