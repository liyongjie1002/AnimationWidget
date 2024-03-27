//
//  ClockView.swift
//  WidgetKitDemo
//
//  Created by 李永杰 on 2024/3/22.
//

import SwiftUI

struct ContentView: View {
    @State private var currentTime = Date()

    var body: some View {
        Text(getFormattedTime())
            .font(.largeTitle)
            .foregroundColor(.black)
            .onAppear {
                startTimer()
            }
    }

    private func startTimer() {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            updateTime()
        }
    }

    private func updateTime() {
        currentTime = Date()
    }

    private func getFormattedTime() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        return formatter.string(from: currentTime)
    }
}
