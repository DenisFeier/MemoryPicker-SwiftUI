//
//  ViewBackground.swift
//  MemoryPicker
//
//  Created by Denis Feier on 16.08.2025.
//

import SwiftUI

struct ViewBackground: View {
    var body: some View {
        LinearGradient(
            gradient: Gradient(colors: [
                Color(hex: "F2994A").opacity(0.4),
                Color(hex: "FCB601").opacity(0.4),
                Color(hex: "932D0D").opacity(0.2)
            ]),
            startPoint: .topTrailing,
            endPoint: .bottomLeading
        )
        .ignoresSafeArea()
    }
}

#Preview {
    ViewBackground()
}
