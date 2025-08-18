//
//  LoginView.swift
//  MemoryPicker
//
//  Created by Denis Feier on 11.08.2025.
//

import SwiftUI
import Combine

private struct LoginView: View {
    @EnvironmentObject var appState: AuthVM
    @State private var email = ""
    @State private var password = ""
    
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
                                isSecure: true,
                            )
                        }
                        MainButton(
                            title: "Login",
                            backgroundColor: .limeGreen) {
                                appState.login(
                                    email: email.trim(),
                                    password: password.trim()
                                )
                        }
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
