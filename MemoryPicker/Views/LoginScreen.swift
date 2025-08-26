//
//  LoginView.swift
//  MemoryPicker
//
//  Created by Denis Feier on 11.08.2025.
//

import SwiftUI
import Combine
import Alamofire

private struct LoginView: View {
    @EnvironmentObject var appState: AuthVM
    @State private var email = ""
    @State private var password = ""
    @State private var isLoading = false
    @State private var errorMessage = ""
    @State private var hasError: Bool = false

    var body: some View {
        VStack {
            VStack {
                GradientMemoryPickerTitle()
                    .padding(.bottom, 16)
                
                CardView {
                    VStack(spacing: 16) {
                        VStack(spacing: 12) {
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
                        }
                        MainButton(
                            title: isLoading ? "Logging in..." : "Login",
                            backgroundColor: .limeGreen,
                            action: {
                                loginAction()
                            })
                        .disabled(isLoading)
                        HStack {
                            Text("Don’t have an account?")
                            NavigationLink(destination: RegisterScreen()) {
                                Text("Sign UP")
                                    .foregroundColor(
                                        Color.limeGreen
                                    )
                            }
                        }
                    }.padding(16)
                }
            }
            Spacer()
            CardView {
                HStack {
                    Text("Forgat your password?")
                    NavigationLink(destination: ResetPasswordScreen()) {
                        Text("Reset password")
                            .foregroundColor(Color.deepRed)
                    }
                }
                .padding(16)
                .frame(maxWidth: .infinity, alignment: .center)
            }
        }
        .padding()
        .navigationTitle("Login")
        .alert(isPresented: $hasError) {
            Alert(
                title: Text("Login Error"),
                message: Text(self.errorMessage),
                dismissButton: .default(Text("OK")) {
                    self.hasError = false
                    self.errorMessage = ""
                }
            )
        }
    }
    
    private func loginAction() {
        isLoading = true
        appState.login(email: email, password: password) { result in
            isLoading = false
            switch result {
            case .success:
                break
            case .failure(let error):
                self.hasError = true
                self.errorMessage = error.errorDescription ?? "An unknown error occurred."
            }
        }
    }
}

struct LoginScreen: View {
    var body: some View {
        NavigationStack {
            LoginView()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(
                    LoginBackground()
                )
                .navigationBarHidden(true)
        }
    }
}

#Preview {
    LoginScreen()
}
