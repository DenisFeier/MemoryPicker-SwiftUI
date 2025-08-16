//
//  CardView.swift
//  MemoryPicker
//
//  Created by Denis Feier on 12.08.2025.
//

import SwiftUI

struct CardView<Content: View>: View {
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        content
            .padding()
            .background(Color.cardWrapper.opacity(0.8))
            .cornerRadius(20)
    }
}
