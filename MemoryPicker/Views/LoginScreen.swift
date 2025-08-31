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
    @StateObject private var loginVM = LoginVM()

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
                                text: $loginVM.email,
                                keyboardType: .emailAddress
                            )
                            InputTextView(
                                placeholder: "Password",
                                text: $loginVM.password,
                                isSecure: true
                            )
                        }
                        MainButton(
                            title: loginVM.isLoading ? "Logging in..." : "Login",
                            backgroundColor: .limeGreen,
                            action: {
                                loginVM.login(authVM: appState)
                            }
                        )
                        .disabled(loginVM.isLoading)
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
        .alert(isPresented: $loginVM.hasError) {
            Alert(
                title: Text("Login Error"),
                message: Text(loginVM.errorMessage),
                dismissButton: .default(Text("OK")) {
                    loginVM.hasError = false
                    loginVM.errorMessage = ""
                }
            )
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
