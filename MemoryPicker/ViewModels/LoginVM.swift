//
//  LoginVM.swift
//  MemoryPicker
//
//  Created by Denis Feier on 26.08.2025.
//


import SwiftUI
import Combine
import Alamofire

class LoginVM: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var isLoading: Bool = false
    @Published var errorMessage: String = ""
    @Published var hasError: Bool = false
    @Published var isRemembered: Bool = false
    
    init() {
        fetchCredentials()
    }

    private func fetchCredentials() {
        if let credentials = getRememberedCredentials() {
            let email = credentials.email
            let password = credentials.password
            if !email.isEmpty && !password.isEmpty {
                self.email = email
                self.password = password
                self.isRemembered = true
            }
        }
    }
    
    func login(authVM: AuthVM) {
        isLoading = true
        authVM.login(email: email, password: password) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success:
                    guard let self = self else {
                        self?.hasError = true
                        self?.errorMessage = "An unknown error occurred."
                        return
                    }
                    if self.isRemembered {
                        rememberCredentials(email: self.email, password: self.password)
                    } else {
                        forgetCredentials()
                    }
                    self.errorMessage = ""
                    self.hasError = false
                case .failure(let error):
                    self?.hasError = true
                    self?.errorMessage = error.errorDescription ?? "An unknown error occurred."
                }
            }
        }
    }
}
