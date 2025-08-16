//
//  RegisterView.swift
//  MemoryPicker
//
//  Created by Denis Feier on 11.08.2025.
//

import SwiftUI

struct RegisterView: View {
    @EnvironmentObject var appState: AppState
    @State private var name = ""
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""

    var body: some View {
        VStack {
            TextField("Full Name", text: $name)
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal)

            TextField("Email", text: $email)
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal)

            SecureField("Password", text: $password)
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal)

            SecureField("Confirm Password", text: $confirmPassword)
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal)

            Button("Register") {
                // Perform registration...
                appState.isLoggedIn = true
            }
            .buttonStyle(.borderedProminent)
            .padding()

            Spacer()
        }
        .padding(.top)
        .navigationTitle("Register")
    }
}
