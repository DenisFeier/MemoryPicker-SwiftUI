//
//  RemberMe.swift
//  MemoryPicker
//
//  Created by Denis Feier on 03.09.2025.
//

import Foundation

private let emailKey = "Remember Me Email"

private let passwordKey = "Remember Me Password"

func rememberCredentials(email: String, password: String) {
    UserDefaults.standard.set(email, forKey: emailKey)
    UserDefaults.standard.set(password, forKey: passwordKey)
}

func forgetCredentials() {
    UserDefaults.standard.removeObject(forKey: emailKey)
    UserDefaults.standard.removeObject(forKey: passwordKey)
}

func getRememberedCredentials() -> (email: String, password: String)? {
    guard let email = UserDefaults.standard.string(forKey: emailKey),
          let password = UserDefaults.standard.string(forKey: passwordKey)
    else { return nil }
    return (email, password)
}
