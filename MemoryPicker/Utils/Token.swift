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

func saveToken(_ token: String) {
    UserDefaults.standard.set(token, forKey: tokenKey)
}

func loadToken() -> String? {
    UserDefaults.standard.string(forKey: tokenKey)
}

func clearToken() {
    UserDefaults.standard.removeObject(forKey: tokenKey)
}
