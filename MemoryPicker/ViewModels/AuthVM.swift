//
//  AppState.swift
//  MemoryPicker
//
//  Created by Denis Feier on 11.08.2025.
//

import Combine
import Foundation
import Alamofire
import SwiftyJSON

class AuthVM: ObservableObject {
    
    @Published var token: String? {
        didSet {
            if let token = token {
                saveToken(token)
                isAuthenticated = isTokenValid(token)
            } else {
                clearToken()
                isAuthenticated = false
            }
        }
    }
    
    @Published var isAuthenticated: Bool = false

    init() {
        if let savedToken = loadToken() {
            token = savedToken
            isAuthenticated = isTokenValid(savedToken)
        }
    }
    
    func login(
        email: String,
        password: String,
        completion: @escaping (Result<String, NatworkAPIError>) -> Void
    ) {
        let trimmedEmail = email.trim()
        let trimmedPassword = password.trim()
        
        if trimmedEmail.isEmpty || trimmedPassword.isEmpty {
            completion(.failure(
                NatworkAPIError.userError("Email and password are required.")
            ))
            return
        }
        
        AuthService.shared.login(email: trimmedEmail, password: trimmedPassword) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let token):
                    self.token = token
                    completion(.success(token))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
    
    func register(
        username: String,
        email: String,
        password: String,
        confirmPassword: String,
        completion: @escaping (Result<Void, NatworkAPIError>) -> Void
    ) {
        let trimmedUsername = username.trim()
        let trimmedEmail = email.trim()
        let trimmedPassword = password.trim()
        let trimmedConfirmPassword = confirmPassword.trim()
        
        if trimmedUsername.isEmpty || trimmedEmail.isEmpty || trimmedPassword.isEmpty || trimmedConfirmPassword.isEmpty {
            completion(.failure(NatworkAPIError.userError("All fields are required.")))
            return
        }
        
        if trimmedPassword != trimmedConfirmPassword {
            completion(.failure(NatworkAPIError.userError("Passwords do not match.")))
            return
        }
        
        AuthService.shared.register(username: trimmedUsername, email: trimmedEmail, password: trimmedPassword) { result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    completion(.success(()))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
    
    func logout() {
        token = nil
        isAuthenticated = false
    }
}
