//
//  PedometerObserver.swift
//  PedometerExample
//
//  Created by WataruSuzuki on 2021/05/28.
//

import Foundation
import Combine
import CoreMotion

class PedometerObserver: ObservableObject {
    let pedometer = CMPedometer()
    
    @Published var monitoring: CMPedometerData = CMPedometerData()
    @Published var monitoringError: Error? = nil
    
    @Published var histories: CMPedometerData = CMPedometerData()
    @Published var queryError: Error? = nil
    
    init() {
        guard CMPedometer.isStepCountingAvailable() else {
            return
        }
        let now = Date()
        let calendar = Calendar(identifier: .gregorian)
        let components = calendar.dateComponents([.year, .month, .day], from: now)
        let today = calendar.date(from: components)
        self.pedometer.startUpdates(from: today!) { data, error in
            guard error == nil, let data = data else {
                self.monitoringError = error
                return
            }
            self.monitoring = data
        }
        
        let start = Date(timeIntervalSinceNow: -24 * 60 * 60)
        self.pedometer.queryPedometerData(from: start, to: Date()) { (data, error) in
            guard error == nil, let data = data else {
                self.queryError = error
                return
            }
            self.histories = data
        }
    }
}
