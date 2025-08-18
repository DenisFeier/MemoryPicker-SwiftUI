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
    @Published var errorMessage: String = "" {
        didSet {
            if errorMessage.isEmpty {
                hasError = false
            } else {
                hasError = true
            }
        }
    }
    @Published var hasError: Bool = false
    
    private let tokenKey = "auth_token"
    
    init() {
        if let savedToken = loadToken() {
            token = savedToken
            isAuthenticated = isTokenValid(savedToken)
        }
    }
    
    func login(email: String, password: String) {
        AuthService.shared.login(email: email, password: password) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let token):
                    self.token = token
                    self.errorMessage = ""
                case .failure(let error):
                    self.errorMessage = error.errorDescription ?? ""
                }
            }
        }
    }
    
    func register(username: String, email: String, password: String, confirmPassword: String, completion: @escaping () -> Void) {
        
        let trimedPassword = password.trim()
        let trimedConfirmPassword = confirmPassword.trim()
        
        guard !username.isEmpty, !email.isEmpty, !trimedPassword.isEmpty, !trimedConfirmPassword.isEmpty else {
            return
        }
        
        guard trimedPassword == trimedConfirmPassword else {
            return
        }
        
        AuthService.shared.register(username: username, email: email, password: password) { result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    self.errorMessage = ""
                    completion()
                case .failure(let error):
                    self.errorMessage = error.errorDescription ?? ""
                }
            }
        }
    }
    
    func logout() {
        token = nil
        isAuthenticated = false
    }
    
    private func isTokenValid(_ token: String) -> Bool {
        let segments = token.split(separator: ".")
        guard segments.count == 3 else { return false }
        
        let payloadSegment = segments[1]
        
        // Fix base64 padding
        var base64 = String(payloadSegment)
            .replacingOccurrences(of: "-", with: "+")
            .replacingOccurrences(of: "_", with: "/")
        while base64.count % 4 != 0 {
            base64.append("=")
        }
        
        guard let payloadData = Data(base64Encoded: base64),
              let json = try? JSON(data: payloadData) else {
            return false
        }
        
        let exp = json["exp"].doubleValue
        let now = Date().timeIntervalSince1970
        return now < exp
    }
    
    // MARK: - Persistence
    private func saveToken(_ token: String) {
        UserDefaults.standard.set(token, forKey: tokenKey)
    }
    
    private func loadToken() -> String? {
        UserDefaults.standard.string(forKey: tokenKey)
    }
    
    private func clearToken() {
        UserDefaults.standard.removeObject(forKey: tokenKey)
    }
}
