//
//  OnboardingModel.swift
//  ddiffa
//
//  Created by Dimas on 25/04/23.
//

import Foundation

struct OnboardingModel {
    let callout: String
    let title: String
    let body: String
}

extension OnboardingModel {
    static let models = [
        OnboardingModel(
            callout: "POMODORO TIMER",
            title: "Boost Your Productivity",
            body: "Stay focused and productive with our Pomodoro Timer. 25-minute work intervals and short breaks help avoid burnout."
        ),
        OnboardingModel(
            callout: "iCLOUD SYNC",
            title: "Sync Across Devices",
            body: "Get seamless access to our app on any device. Syncs with iPhone and Apple Watch. Stay productive anywhere."
        ),
        OnboardingModel(
            callout: "GUIDED EXERCISE",
            title: "Take a Break and Stretch",
            body: "Recharge with guided exercises that can be done anywhere, anytime. Stretch you body and log your exercise to Apple Health."
        )
    ]
}
