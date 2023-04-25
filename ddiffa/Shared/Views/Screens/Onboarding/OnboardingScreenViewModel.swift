//
//  OnboardingScreenViewModel.swift
//  ddiffa
//
//  Created by Dimas on 25/04/23.
//

import Foundation

class OnboardingScreenViewModel: ObservableObject {
    
    // MARK: - Dependencies
    
    private let finishedOnboardingHandler: () -> ()
    
    // MARK: - Properties
    
    @Published var currentIndex: Int = 0
    
    private let models = OnboardingModel.models
    
    var callout: String {
        models[currentIndex].callout
    }
    
    var title: String {
        models[currentIndex].title
    }
    
    var body: String {
        models[currentIndex].body
    }
    
    var imageName: String {
        "onboarding-illustration-\(currentIndex + 1)"
    }
    
    var isLastIndex: Bool {
        currentIndex == models.count - 1
    }
    
    var slidesCount: Int {
        models.count
    }
    
    // MARK: - Methods
    
    init(finishedOnboardingHandler: @escaping () -> ()) {
        self.finishedOnboardingHandler = finishedOnboardingHandler
    }
    
    func next() {
        if currentIndex < models.count - 1 {
            currentIndex += 1
        } else {
            finish()
        }
    }
    
    func back() {
        if currentIndex > 0 {
            currentIndex -= 1
        }
    }
    
    func finish() {
        finishedOnboardingHandler()
    }
    
}
