//
//  RegisterView.swift
//  MemoryPicker
//
//  Created by Denis Feier on 11.08.2025.
//

import SwiftUI
import Combine
import Alamofire

private struct RegisterView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var appState: AuthVM
    @State private var name = ""
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var isLoading = false
    @State private var errorMessage = ""
    @State private var hasError: Bool = false
    
    var body: some View {
        VStack {
            GradientMemoryPickerTitle()
                .padding(.bottom, 16)
            
            CardView {
                VStack(spacing: 16) {
                    VStack(spacing: 12) {
                        InputTextView(
                            placeholder: "Name",
                            text: $name
                        )
                        InputTextView(
                            placeholder: "Email",
                            text: $email,
                            keyboardType: .emailAddress
                        )
                        InputTextView(
                            placeholder: "Password",
                            text: $password,
                            isSecure: true
                        )
                        InputTextView(
                            placeholder: "Re-Password",
                            text: $confirmPassword,
                            isSecure: true
                        )
                    }
                    MainButton(
                        title: isLoading ? "Registering..." : "Register",
                        backgroundColor: .limeGreen,
                        action: {
                            registerAction()
                        })
                    .disabled(isLoading)
                }.padding(16)
            }
            Spacer()
        }
        .padding()
        .navigationTitle("Register")
        .alert("Error!", isPresented: $hasError) {
            Button("OK", role: .cancel) {
                self.hasError = false
                self.errorMessage = ""
            }
        } message: {
            Text(errorMessage)
        }
    }
    
    private func registerAction() {
        isLoading = true
        appState.register(
            username: name,
            email: email,
            password: password,
            confirmPassword: confirmPassword
        ) { result in
            DispatchQueue.main.async {
                isLoading = false
                switch result {
                case .success:
                    dismiss()
                case .failure(let error):
                    self.hasError = true
                    self.errorMessage = error.errorDescription ?? "Unknown error"
                }
            }
        }
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
