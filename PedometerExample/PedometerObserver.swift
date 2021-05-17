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
    
    @Published var histories: CMPedometerData = CMPedometerData()
    @Published var queryError: Error? = nil
    
    init() {
        guard CMPedometer.isStepCountingAvailable() else {
            return
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
