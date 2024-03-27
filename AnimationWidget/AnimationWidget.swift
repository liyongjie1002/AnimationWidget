//
//  AnimationWidget.swift
//  AnimationWidget
//
//  Created by 李永杰 on 2024/3/26.
//

import WidgetKit
import SwiftUI
import ClockHandRotationKit

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date())
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date())
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
}

struct AnimationWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        GeometryReader { reader in
            ZStack() {
                Image("animation_")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .clockHandRotationEffect(period: .custom(10), in: .current, anchor: .zero)
                    .mask {
                        Capsule(style: .circular)   // 胶囊
                            .frame(width: 100,height: 100)
                    }
            }
            .frame(width: reader.size.width, height: reader.size.height)
            .background(Color(red: 30/255.0, green: 26/255.0, blue: 21/255.0))
        }
    }
}

struct AnimationWidget: Widget {
    let kind: String = "AnimationWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            AnimationWidgetEntryView(entry: entry)
        }
        .supportedFamilies([.systemMedium])
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}
