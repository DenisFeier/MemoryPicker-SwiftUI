//
//  ResetPasswordView.swift
//  MemoryPicker
//
//  Created by Denis Feier on 11.08.2025.
//

import SwiftUI

struct ResetPasswordView: View {
    @State private var email = ""
    
    var body: some View {
        VStack {
            CardView {
                VStack(spacing: 16) {
                    Text("Enter your email to reset your password.")
                        .font(.subheadline)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                    InputTextView(
                        placeholder: "Email",
                        text: $email,
                        keyboardType: .emailAddress
                    )
                    MainButton(title: "Send Email", backgroundColor: .limeGreen) {
                            
                        }
                }.padding(16)
            }
            Spacer()
        }
        .padding()
        .navigationTitle("Reset Password")
    }
}

struct ResetPasswordScreen: View {
    var body: some View {
        NavigationStack {
            ResetPasswordView()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .navigationBarTitleDisplayMode(.inline)
                .toolbarBackground(
                    Color.toolbarBackground,
                    for: .navigationBar
                )
                .toolbarBackground(.visible, for: .navigationBar)
                .background(
                    ViewBackground()
                )
        }
    }
}

#Preview {
    ResetPasswordScreen()
}
