//
//  ScreenUtils.swift
//  MemoryPicker
//
//  Created by Denis Feier on 16.08.2025.
//

import SwiftUI

struct GradientTextExample: View {
    var body: some View {
        Text("Memory Picker")
            .font(.largeTitle)
            .fontWeight(.bold)
            .foregroundStyle(
                LinearGradient(
                    colors: [
                        Color(red: 0.0, green: 0.898, blue: 0.471),
                        Color(red: 0.024, green: 0.149, blue: 0.22)
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
            .frame(maxWidth: .infinity, alignment: .center)
    }
}

struct LoginBackground: View {
    var body: some View {
        Color.clear.background(
            Image("backgroundImg").resizable().scaledToFill()
        ).ignoresSafeArea()
    }
}
