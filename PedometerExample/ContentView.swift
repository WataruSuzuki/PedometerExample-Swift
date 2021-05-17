//
//  ContentView.swift
//  PedometerExample
//
//  Created by WataruSuzuki on 2021/05/28.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            MonitoringView()
                .tabItem { Text("Monitoring") }
            QueryHistoryView()
                .tabItem { Text("Query histories") }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
