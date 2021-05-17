//
//  QueryHistoryView.swift
//  PedometerExample
//
//  Created by WataruSuzuki on 2021/05/28.
//

import SwiftUI

struct QueryHistoryView: View {
    @ObservedObject var pedometer: PedometerObserver
    
    var body: some View {
        VStack {
            Text("steps: \(pedometer.histories.numberOfSteps)")
            Text("distance: \(pedometer.histories.distance?.doubleValue ?? 0)")
        }
    }
}

struct QueryHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        QueryHistoryView(pedometer: PedometerObserver())
    }
}
