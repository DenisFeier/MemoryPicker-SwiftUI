//
//  MainButton.swift
//  MemoryPicker
//
//  Created by Denis Feier on 16.08.2025.
//

import SwiftUI

struct MainButton: View {
    let title: String
    let backgroundColor: Color
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.headline)
                .foregroundColor(.black)
                .padding(.vertical, 12)
                .padding(.horizontal, 56)
                .background(backgroundColor)
                .cornerRadius(30)
        }
    }
}
