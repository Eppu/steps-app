//
//  HealthManager.swift
//  steps-app
//
//  Created by Eetu Eskelinen on 14.11.2023.
//

import Foundation
import HealthKit
import Firebase

extension Date {
    static var startOfDay: Date {
        Calendar.current.startOfDay(for: Date())
    }
}

extension Double {
    func formattedString() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.maximumFractionDigits = 0
        
        return numberFormatter.string(from: NSNumber(value :self))!
    }
}

class HealthManager: ObservableObject {
    
    let healthStore = HKHealthStore()
    
    @Published var activities: [String : Activity] = [:]
    
    @Published var previousDaysSteps: [StepEntry] = []
    
    init() {
        let steps = HKQuantityType(.stepCount)
        
        let healthTypes: Set = [steps]
        
        Task {
            do {
                try await healthStore.requestAuthorization(toShare: [], read: healthTypes)
                fetchTodaysSteps()
                fetchPreviousDaysStepsFromDB()
                //                fetchMockSteps()
            } catch {
                print("Error fetching HealthKit data", error.localizedDescription)
            }
        }
    }
    
    func fetchMockSteps() {
        print("Fetching mock steps")
        let activity = Activity(id: 0, title: "Steps today", subtitle: "Something", image: "figure.walk", amount: "7364")
        DispatchQueue.main.async {
            self.activities["todaySteps"] = activity
        }
        // Store the step count
        UserManager().saveOrUpdateStepEntry(stepCount: 7364)
    }
    
    func fetchTodaysSteps() {
        let steps = HKQuantityType(.stepCount)
        
        // This only works on a real device with real HealthKit data
        let predicate = HKQuery.predicateForSamples(withStart: .startOfDay, end: Date() )
        let query = HKStatisticsQuery(quantityType: steps, quantitySamplePredicate: predicate ) { _, result, error in
            guard let quantity = result?.sumQuantity(), error == nil else {
                print("Failed to fetch steps", error?.localizedDescription ?? "Unknown error")
                return;
            }
            
            let stepCount = quantity.doubleValue(for: .count())
            
            let activity = Activity(id: 0, title: "Steps today", subtitle: "Something", image: "figure.walk", amount: stepCount.formattedString())
            DispatchQueue.main.async {
                self.activities["todaySteps"] = activity
            }
            self.activities["todaySteps"] = activity
            // Store the step count
            print("Stepcount:", stepCount)
            print(Int(stepCount))
            if (stepCount > 0) {
                UserManager().saveOrUpdateStepEntry(stepCount: stepCount)
            }
        }
        
        healthStore.execute(query)
    }
    
    func fetchPreviousDaysStepsFromDB() {
        print("fetching previous days steps from DB")
        let userManager = UserManager()
        
        userManager.getStepEntriesForUser() { [weak self] (entries, error) in
            if let error = error {
                print("Error loading step entries: \(error.localizedDescription)")
            } else if let entries = entries {
                self?.previousDaysSteps = entries
                print("Loaded step entries: \(entries)")
            }
        }
        
    }
    
    
    
}
