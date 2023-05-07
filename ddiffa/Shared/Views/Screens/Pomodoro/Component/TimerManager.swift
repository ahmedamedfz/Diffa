//
//  TimerManager.swift
//  TimerPicker
//
//  Created by Falah Hasbi Assidiqi on 30/04/23.
//

import Foundation
import SwiftUI
import UserNotifications

class TimerManager: ObservableObject {
    
    // MARK: Properties
    @Published var timerMode: TimerMode = .initial
    @Published var secondsLeft = UserDefaults.standard.integer(forKey: "timerLength")
    @Published var startAngle: Double = 0.0
    @Published var toAngle: Double = 180
    @Published var startProgress:CGFloat = 0.0
    @Published var toProgress: CGFloat = 0.5
    @Published var minutes: Double = 0.0
    @State private var notificationDate: Date = Date()
    var timer = Timer()
    
    func setTimerLength(minutes: Int) {
        let defaults = UserDefaults.standard
        defaults.set(minutes, forKey: "timerLength")
        secondsLeft = minutes
    }
    
    func start() {
        timerMode = .running
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { timer in
            if self.secondsLeft == 0 {
                self.reset()
            }
            self.secondsLeft -= 1
        })
    }
    
    func reset() {
        self.timerMode = .initial
        self.secondsLeft = UserDefaults.standard.integer(forKey: "timerLength")
        timer.invalidate()
    }
    
    func pause() {
        self.timerMode = .pause
        timer.invalidate()
    }
    
    func secondsToMinutesAndSeconds(seconds: Int) -> String {
        let minutes = "\((seconds % 3600) / 60)"
        let seconds = "\((seconds % 3600) % 60)"
        
        let minuteStamp = minutes.count > 1 ? minutes : "0" + minutes
        let secondStamp = seconds.count > 1 ? seconds : "0" + seconds
        
        return "\(minuteStamp) : \(secondStamp)"
    }
    
    func onDrag(value: DragGesture.Value, fromSlider: Bool = false) {
        
        // Converting translation into Angle
        let vector = CGVector(dx: value.location.x, dy: value.location.y)
        
        // Removing the button radius, button diameter = 30, radius = 15
        let radians = atan2(vector.dy - 15, vector.dx - 15)
        
        // Converting into angle
        var angle = radians * 180 / .pi
        if angle < 0 {
            angle += 360
        }
        
        // Progress
        let progress = angle / 360
        
        let difference = getTimeDifference()
        
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.prepare()
        generator.impactOccurred(intensity: CGFloat(Float(difference) / 60 * 0.7) + 0.3)
        
        if fromSlider {
            // Update from values
            startAngle = angle
            startProgress = progress

        } else {
            // Update to values
            toAngle = angle
            toProgress = progress
        }
    }
    
    func getTime(angle: Double) -> Date {
        let progress = angle / 30
        
        //it will be 6.05 ( 6 is hours, 0.5 is minutes)
        let minutes = Int(progress)
        
        // why 12, since we're going to update time for each 5 minutes not for each minutes
        // 0.1 = 5 minutes
        let reminder = (progress.truncatingRemainder(dividingBy: 1) * 12).rounded()
        
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm:ss"
        
        if let date = formatter.date(from: "\(minutes) : \(Int(reminder)):00"){
            return date
        }
        return .init()
    }
    
    func getTimeDifference() -> Int {
        let startMinute = Int(startAngle / 6)
        
        let endMinute = Int(toAngle / 6)
        
        var difference = endMinute - startMinute
        
        if difference < 0 {
            difference += 60
        }
        return difference
    }
    
    func requestAuth() {
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
        UNUserNotificationCenter.current().requestAuthorization(options: options) { (success, error) in
            if let error = error {
                print("Error: \(error)")
            } else {
                print("Success")
            }
        }
    }
    
    func scheduledNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Ini judul notif"
        content.subtitle = "ini sub judulnya"
        content.sound = .default
        content.badge = 1
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(secondsLeft), repeats: false)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request)
    }
}
