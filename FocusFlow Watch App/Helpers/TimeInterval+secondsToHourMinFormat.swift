//
//  TimeInterval+secondsToHourMinFormat.swift
//  FocusFlow Watch App
//
//  Created by Dimas on 05/05/23.
//

import Foundation

extension TimeInterval {
    static func secondsToHourMinFormat(time: TimeInterval) -> String? {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.minute, .second]
        formatter.zeroFormattingBehavior = .pad
        return formatter.string(from: time)
    }
}
