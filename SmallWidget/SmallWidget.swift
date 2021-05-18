//
//  SmallWidget.swift
//  SmallWidget
//
//  Created by watsuzuk on 2021/05/28.
//

import WidgetKit
import SwiftUI
import Intents
import CoreMotion

struct Provider: IntentTimelineProvider {
    let pedometer = CMPedometer()
    func placeholder(in context: Context) -> PedometerEntry {
        PedometerEntry(date: Date(), configuration: ConfigurationIntent(), pedometerData: CMPedometerData())
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (PedometerEntry) -> ()) {
        queryTodaysPedometerData { data in
            let entity = PedometerEntry(date: Date(), configuration: configuration, pedometerData: data)
            completion(entity)
        }
    }
    
    private func queryTodaysPedometerData(completion: @escaping (CMPedometerData) -> ()) {
        guard CMPedometer.isStepCountingAvailable() else {
            completion(CMPedometerData())
            return
        }
        let now = Date()
        let calendar = Calendar(identifier: .gregorian)
        let components = calendar.dateComponents([.year, .month, .day], from: now)
        let today = calendar.date(from: components)
        self.pedometer.queryPedometerData(from: today!, to: Date()) { (data, error) in
            guard error == nil, let data = data else {
                completion(CMPedometerData())
                return
            }
            completion(data)
        }
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [PedometerEntry] = []
        let refresh = Calendar.current.date(byAdding: .minute, value: 15, to: Date()) ?? Date()
        
        queryTodaysPedometerData { data in
            let entity = PedometerEntry(date: Date(), configuration: configuration, pedometerData: data)
            entries.append(entity)
            let timeline = Timeline(entries: entries, policy: .after(refresh))
            completion(timeline)
        }
    }
}

struct PedometerEntry: TimelineEntry {
    var date: Date
    let configuration: ConfigurationIntent
    let pedometerData: CMPedometerData
}

struct SmallWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        VStack {
            Text("steps: \(entry.pedometerData.numberOfSteps.intValue)")
            Text(String(format: "%.2f km", (entry.pedometerData.distance?.doubleValue ?? 0.0) / 1000.0))
        }
    }
}

@main
struct SmallWidget: Widget {
    let kind: String = "SmallWidget"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            SmallWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}

struct SmallWidget_Previews: PreviewProvider {
    static var previews: some View {
        SmallWidgetEntryView(entry: PedometerEntry(date: Date(), configuration: ConfigurationIntent(), pedometerData: CMPedometerData()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
