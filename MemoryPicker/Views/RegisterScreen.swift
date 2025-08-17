//
//  RegisterView.swift
//  MemoryPicker
//
//  Created by Denis Feier on 11.08.2025.
//

import SwiftUI

private struct RegisterView: View {
    @EnvironmentObject var appState: AppState
    @State private var name = ""
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""

    var body: some View {
        VStack {
            GradientMemoryPickerTitle()
                .padding(.bottom, 16)
            
            CardView {
                VStack(spacing: 16) {
                    VStack(spacing: 12) {
                        InputTextView(
                            placeholder: "Name",
                            text: $name,
                            keyboardType: .emailAddress
                        )
                        InputTextView(
                            placeholder: "Email",
                            text: $email,
                            keyboardType: .emailAddress
                        )
                        InputTextView(
                            placeholder: "Password",
                            text: $password,
                            isSecure: true,
                        )
                        InputTextView(
                            placeholder: "Re-Password",
                            text: $confirmPassword,
                            isSecure: true,
                        )
                    }
                    MainButton(
                        title: "Login",
                        backgroundColor: .limeGreen) {
                        appState.isLoggedIn = true
                    }
                }.padding(16)
            }
            Spacer()
        }
        .padding()
        .navigationTitle("Register")
    }
}

struct RegisterScreen: View {
    var body: some View {
        NavigationStack {
            RegisterView()
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
    RegisterScreen()
}
