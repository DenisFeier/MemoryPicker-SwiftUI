//
//  Utils.swift
//  MemoryPicker
//
//  Created by Denis Feier on 26.08.2025.
//

import Foundation
import SwiftyJSON

private let tokenKey = "auth_token"

func isTokenValid(_ token: String) -> Bool {
    let segments = token.split(separator: ".")
    guard segments.count == 3 else { return false }
    
    let payloadSegment = segments[1]
    
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

func decodeJWTPayload(_ token: String) -> JSON? {
    let segments = token.split(separator: ".")
    guard segments.count > 1 else {
        print("Invalid JWT")
        return nil
    }

    let payloadSegment = String(segments[1])
    
    // Base64 decode (JWT uses base64url without padding)
    var base64 = payloadSegment
        .replacingOccurrences(of: "-", with: "+")
        .replacingOccurrences(of: "_", with: "/")
    
    // Add padding if needed
    let paddingLength = 4 - base64.count % 4
    if paddingLength < 4 {
        base64 += String(repeating: "=", count: paddingLength)
    }
    
    guard let payloadData = Data(base64Encoded: base64) else {
        print("Failed to base64 decode JWT payload")
        return nil
    }
    
    // Convert Data to JSON
    do {
        let jsonObject = try JSONSerialization.jsonObject(with: payloadData, options: [])
        return JSON(jsonObject)
    } catch {
        print("Failed to decode JSON from JWT payload: \(error)")
        return nil
    }
}

func saveToken(_ token: String) {
    UserDefaults.standard.set(token, forKey: tokenKey)
}

func loadToken() -> String? {
    UserDefaults.standard.string(forKey: tokenKey)
}

func clearToken() {
    UserDefaults.standard.removeObject(forKey: tokenKey)
}

