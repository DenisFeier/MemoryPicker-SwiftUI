//
//  MainTabView.swift
//  MemoryPicker
//
//  Created by Denis Feier on 11.08.2025.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            HomeTab()
                .tabItem { Label("Home", systemImage: "house") }

            CreateTab()
                .tabItem { Label("Create", systemImage: "camera.fill") }

            ProfileTab()
                .tabItem { Label("Profile", systemImage: "person") }

            NetworkTab()
                .tabItem { Label("Network", systemImage: "person.3.fill") }
        }
    }
}

#Preview {
    MainTabView()
}
