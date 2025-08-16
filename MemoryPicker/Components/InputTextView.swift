//
//  InputTextView.swift
//  MemoryPicker
//
//  Created by Denis Feier on 16.08.2025.
//

import SwiftUI

private let INNER_CORNER_RADIUS: CGFloat = 16

struct InputTextView: View {
    let placeholder: String
    @Binding var text: String
    var isSecure: Bool = false
    var keyboardType: UIKeyboardType = .default
    
    var body: some View {
        Group {
            if isSecure {
                SecureField(placeholder, text: $text)
            } else {
                TextField(placeholder, text: $text)
                    .keyboardType(keyboardType)
            }
        }
        .padding(8)
        .padding(.horizontal, 16)
        .background(Color.inputGray)
        .cornerRadius(INNER_CORNER_RADIUS)
        .overlay(
            RoundedRectangle(cornerRadius: INNER_CORNER_RADIUS)
                .stroke(Color.black.opacity(0.6), lineWidth: 1)
        )
    }
}
