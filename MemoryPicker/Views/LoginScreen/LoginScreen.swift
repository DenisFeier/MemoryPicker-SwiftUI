//
//  LoginView.swift
//  MemoryPicker
//
//  Created by Denis Feier on 11.08.2025.
//

import SwiftUI
import Combine

private struct LoginView: View {
    @EnvironmentObject var appState: AppState
    @State private var email = ""
    @State private var password = ""
    
    var body: some View {
        VStack {
            VStack {
                CardView {
                    GradientTextExample()
                }.padding(.bottom, 16)
                
                CardView {
                    VStack {
                        VStack {
                            InputTextView(
                                placeholder: "Email",
                                text: $email,
                                keyboardType: .emailAddress
                            ).padding(.bottom, 8)
                            InputTextView(
                                placeholder: "Password",
                                text: $password,
                                isSecure: true,
                            )
                        }
                        .padding(.horizontal, 4)
                        MainButton(
                            title: "Login",
                            backgroundColor: .limeGreen) {
                            appState.isLoggedIn = true
                        }.padding(.vertical, 16)
                        HStack {
                            Text("Don’t have an account?")
                            NavigationLink(destination: RegisterView()) {
                                Text("Sign UP")
                                    .foregroundColor(
                                        Color.limeGreen
                                    )
                            }
                        }
                    }
                    .padding(.vertical, 8)
                }
            }
            Spacer()
            CardView {
                HStack {
                    Text("Forgat your password?")
                    NavigationLink(destination: ResetPasswordView()) {
                        Text("Reset password")
                            .foregroundColor(Color.deepRed)
                    }
                }.frame(maxWidth: .infinity, alignment: .center)
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
