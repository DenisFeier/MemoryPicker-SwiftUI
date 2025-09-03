//
//  NatworkAPIError.swift
//  MemoryPicker
//
//  Created by Denis Feier on 31.08.2025.
//

import Foundation

enum NatworkAPIError: LocalizedError {
    case invalidResponse
    case serverMessage(String)
    case userError(String)
    case internalError(String)
    
    var errorDescription: String? {
        switch self {
            case .invalidResponse: return "Invalid response from server"
            case .serverMessage(let msg): return msg
            case .userError(let msg): return msg
            case .internalError(let msg): return msg
        }
    }
}
