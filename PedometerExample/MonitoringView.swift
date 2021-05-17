//
//  MonitoringView.swift
//  PedometerExample
//
//  Created by WataruSuzuki on 2021/05/28.
//

import SwiftUI

struct MonitoringView: View {
    @ObservedObject var pedometer: PedometerObserver
    
    var body: some View {
        VStack {
            Text("steps: \(pedometer.monitoring.numberOfSteps)")
            Text("distance: \(pedometer.monitoring.distance?.doubleValue ?? 0)")
        }
    }
}

struct MonitoringView_Previews: PreviewProvider {
    static var previews: some View {
        MonitoringView(pedometer: PedometerObserver())
    }
}
