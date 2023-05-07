//
//  StretchingSessionManager.swift
//  FocusFlow Watch App
//
//  Created by Dimas on 07/05/23.
//

import HealthKit

class StretchSessionManager: NSObject, ObservableObject {
    var mainStretch: MainStretch!
    
    @Published var currentIndex = 0
    @Published var passedTime: Int = 0
    @Published var totalTime: Int = 0
    @Published var running = false
    @Published var isShowingSummaryView = false
    @Published var averageHeartRate: Double = 0
    @Published var heartRate: Double = 0
    @Published var activeEnergy: Double = 0
    @Published var workout: HKWorkout?
    
    let healthStore = HKHealthStore()
    var session: HKWorkoutSession?
    var builder: HKLiveWorkoutBuilder?
    
    var timer = Timer.publish(every: 1, on: .main, in: .common)
        .autoconnect()
    
    func startStretching(_ stretch: MainStretch, fromIndex: Int = 0) {
        mainStretch = stretch
        currentIndex = fromIndex
        startWorkout()
    }
    
    func startWorkout() {
        let configuration = HKWorkoutConfiguration()
        configuration.activityType = .other
        configuration.locationType = .indoor

        // Create the session and obtain the workout builder.
        do {
            session = try HKWorkoutSession(healthStore: healthStore, configuration: configuration)
            builder = session?.associatedWorkoutBuilder()
        } catch {
            // Handle any exceptions.
            return
        }

        // Setup session and builder.
        session?.delegate = self
        builder?.delegate = self

        // Set the workout builder's data source.
        builder?.dataSource = HKLiveWorkoutDataSource(healthStore: healthStore,
                                                     workoutConfiguration: configuration)

        // Start the workout session and begin data collection.
        let startDate = Date()
        session?.startActivity(with: startDate)
        builder?.beginCollection(withStart: startDate) { (success, error) in
            // The workout has started.
        }
    }
    
    /**
     Updates the current state of a stretching routine.

     The function increments the `passedTime` and `totalTime` variables by 1. It then checks if the current index matches certain conditions and updates the `currentIndex` and `passedTime` accordingly.
     
        Returns:
            true if has finished
     */
    func updateStretching() {
        passedTime += 1
        totalTime += 1
        
        if currentIndex == 0 && passedTime == 6 { // go to rest 1
            currentIndex += 1
            passedTime = 0
        } else if currentIndex == 1 && passedTime == mainStretch.substretch[0].duration+1 {
            currentIndex += 1
            passedTime = 0
        } else if currentIndex == 2 && passedTime == 6 {
            currentIndex += 1
            passedTime = 0
        } else if currentIndex == 3 && passedTime == mainStretch.substretch[1].duration+1 {
            currentIndex += 1
            passedTime = 0
        } else if currentIndex == 4 && passedTime == 6 {
            currentIndex += 1
            passedTime = 0
        } else if currentIndex == 5 && passedTime == mainStretch.substretch[2].duration+2 {
            timer.upstream.connect().cancel()
            finishStretching()
            passedTime = 0
        }
    }
    
    // Request authorization to access HealthKit.
    func requestAuthorization() {
        // The quantity type to write to the health store.
        let typesToShare: Set = [
            HKQuantityType.workoutType()
        ]

        // The quantity types to read from the health store.
        let typesToRead: Set = [
            HKQuantityType.quantityType(forIdentifier: .heartRate)!,
            HKQuantityType.quantityType(forIdentifier: .activeEnergyBurned)!,
            HKQuantityType.quantityType(forIdentifier: .distanceWalkingRunning)!,
            HKQuantityType.quantityType(forIdentifier: .distanceCycling)!,
            HKObjectType.activitySummaryType()
        ]

        // Request authorization for those quantity types.
        HKHealthStore().requestAuthorization(toShare: typesToShare, read: typesToRead) { (success, error) in
            // Handle error.
        }
    }

    func updateForStatistics(_ statistics: HKStatistics?) {
        guard let statistics = statistics else { return }

        DispatchQueue.main.async {
            switch statistics.quantityType {
            case HKQuantityType.quantityType(forIdentifier: .heartRate):
                let heartRateUnit = HKUnit.count().unitDivided(by: HKUnit.minute())
                self.heartRate = statistics.mostRecentQuantity()?.doubleValue(for: heartRateUnit) ?? 0
                self.averageHeartRate = statistics.averageQuantity()?.doubleValue(for: heartRateUnit) ?? 0
            case HKQuantityType.quantityType(forIdentifier: .activeEnergyBurned):
                let energyUnit = HKUnit.kilocalorie()
                self.activeEnergy = statistics.sumQuantity()?.doubleValue(for: energyUnit) ?? 0
            default:
                return
            }
        }
    }
    
    func finishStretching() {
        session?.end()
        isShowingSummaryView = true
        print("TODO: finish stretching")
    }
}

// MARK: - HKWorkoutSessionDelegate
extension StretchSessionManager: HKWorkoutSessionDelegate {
    func workoutSession(_ workoutSession: HKWorkoutSession, didChangeTo toState: HKWorkoutSessionState,
                        from fromState: HKWorkoutSessionState, date: Date) {
        DispatchQueue.main.async {
            self.running = toState == .running
        }

        // Wait for the session to transition states before ending the builder.
        if toState == .ended {
            builder?.endCollection(withEnd: date) { (success, error) in
                self.builder?.finishWorkout { (workout, error) in
                    DispatchQueue.main.async {
                        self.workout = workout
                    }
                }
            }
        }
    }

    func workoutSession(_ workoutSession: HKWorkoutSession, didFailWithError error: Error) {

    }
}

// MARK: - HKLiveWorkoutBuilderDelegate
extension StretchSessionManager: HKLiveWorkoutBuilderDelegate {
    func workoutBuilderDidCollectEvent(_ workoutBuilder: HKLiveWorkoutBuilder) {

    }

    func workoutBuilder(_ workoutBuilder: HKLiveWorkoutBuilder, didCollectDataOf collectedTypes: Set<HKSampleType>) {
        for type in collectedTypes {
            guard let quantityType = type as? HKQuantityType else {
                return // Nothing to do.
            }

            let statistics = workoutBuilder.statistics(for: quantityType)

            // Update the published values.
            updateForStatistics(statistics)
        }
    }
}
