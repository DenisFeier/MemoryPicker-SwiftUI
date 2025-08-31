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
    @StateObject private var registerVM = RegisterVM()
    
    var body: some View {
        VStack {
            GradientMemoryPickerTitle()
                .padding(.bottom, 16)
            
            CardView {
                VStack(spacing: 16) {
                    VStack(spacing: 12) {
                        InputTextView(
                            placeholder: "Name",
                            text: $registerVM.name
                        )
                        InputTextView(
                            placeholder: "Email",
                            text: $registerVM.email,
                            keyboardType: .emailAddress
                        )
                        InputTextView(
                            placeholder: "Password",
                            text: $registerVM.password,
                            isSecure: true
                        )
                        InputTextView(
                            placeholder: "Re-Password",
                            text: $registerVM.confirmPassword,
                            isSecure: true
                        )
                    }
                    MainButton(
                        title: registerVM.isLoading ? "Registering..." : "Register",
                        backgroundColor: .limeGreen,
                        action: {
                            registerVM.register(authVM: appState)
                        })
                    .disabled(registerVM.isLoading)
                }.padding(16)
            }
            Spacer()
        }
        .padding()
        .navigationTitle("Register")
        .alert("Error!", isPresented: $registerVM.hasError) {
            Button("OK", role: .cancel) {
                registerVM.hasError = false
                registerVM.errorMessage = ""
            }
        } message: {
            Text(registerVM.errorMessage)
        }
        .alert("Success!", isPresented: $registerVM.showSuccessAlert) {
            Button("OK") {
                dismiss()
            }
        } message: {
            Text("User with name \(registerVM.name) was registered successfully.")
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
