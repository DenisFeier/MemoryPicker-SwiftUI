//
//  LoginView.swift
//  MemoryPicker
//
//  Created by Denis Feier on 11.08.2025.
//

import SwiftUI
import Combine

struct LoginView: View {
    @EnvironmentObject var appState: AppState
    @State private var email = ""
    @State private var password = ""

    var body: some View {
        VStack {
            TextField("Email", text: $email)
                .textFieldStyle(.roundedBorder)
                .padding()

            SecureField("Password", text: $password)
                .textFieldStyle(.roundedBorder)
                .padding()

            Button("Login") {
                // Perform authentication...
                appState.isLoggedIn = true
            }
            .buttonStyle(.borderedProminent)
            .padding()

            NavigationLink("Register", destination: RegisterView())
            NavigationLink("Forgot Password?", destination: ResetPasswordView())
        }
        .padding()
        .navigationTitle("Login")
    }
}

#Preview {
    NavigationStack {
        LoginView()
    }
}
