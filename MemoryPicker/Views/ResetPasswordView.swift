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
            Text("Enter your email to reset your password.")
                .font(.subheadline)
                .multilineTextAlignment(.center)
                .padding(.horizontal)

            TextField("Email", text: $email)
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal)

            Button("Send Reset Link") {
                // Send reset request...
            }
            .buttonStyle(.borderedProminent)
            .padding()

            Spacer()
        }
        .padding(.top)
        .navigationTitle("Reset Password")
    }
}
