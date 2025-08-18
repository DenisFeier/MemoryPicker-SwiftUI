//
//  MemoryPickerApp.swift
//  MemoryPicker
//
//  Created by Denis Feier on 11.08.2025.
//

import SwiftUI

@main
struct MemoryPickerApp: App {
    @StateObject private var appState = AuthVM()

    var body: some Scene {
        WindowGroup {
            ZStack {
                if appState.isAuthenticated {
                    MainTabView()
                        .environmentObject(appState)
                        .transition(.move(edge: .trailing).combined(with: .opacity))
                } else {
                    AuthFlowView()
                        .environmentObject(appState)
                        .transition(.move(edge: .leading).combined(with: .opacity))
                }
            }
            .animation(.easeInOut(duration: 0.35), value: appState.isAuthenticated)
        }
    }
}
