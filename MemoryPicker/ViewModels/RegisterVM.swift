//
//  RegisterVM.swift
//  MemoryPicker
//
//  Created by Denis Feier on 26.08.2025.
//

import SwiftUI
import Combine
import Alamofire

class RegisterVM: ObservableObject {
    @Published var name: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var confirmPassword: String = ""
    @Published var isLoading: Bool = false
    @Published var errorMessage: String = ""
    @Published var hasError: Bool = false
    @Published var showSuccessAlert = false

    func register(authVM: AuthVM) {
        isLoading = true
        authVM.register(
            username: name,
            email: email,
            password: password,
            confirmPassword: confirmPassword
        ) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success:
                    self?.errorMessage = ""
                    self?.hasError = false
                    self?.showSuccessAlert = true
                case .failure(let error):
                    self?.hasError = true
                    self?.showSuccessAlert = false
                    self?.errorMessage = error.errorDescription ?? "An unknown error occurred."
                }
            }
        }
    }
}
