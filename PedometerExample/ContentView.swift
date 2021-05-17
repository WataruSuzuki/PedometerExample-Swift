//
//  ContentView.swift
//  PedometerExample
//
//  Created by WataruSuzuki on 2021/05/28.
//

import SwiftUI

struct ContentView: View {
    let observer = PedometerObserver()
    var body: some View {
        TabView {
            QueryHistoryView(pedometer: observer)
                .tabItem { Text("Query histories") }
            MonitoringView(pedometer: observer)
                .tabItem { Text("Monitoring") }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
