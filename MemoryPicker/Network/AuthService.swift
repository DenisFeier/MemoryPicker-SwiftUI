//
//  AuthService.swift
//  MemoryPicker
//
//  Created by Denis Feier on 18.08.2025.
//

import Foundation
import Alamofire
import SwiftyJSON

struct AuthService {
    
    static let shared = AuthService()
    
    private init() {}
    
    func login(email: String, password: String, completion: @escaping (Result<String, AuthError>) -> Void) {
        let urlString = "\(APIConfig.baseURL)/user/login"
        
        guard let url = URL(string: urlString) else {
            completion(.failure(AuthError.invalidResponse))
            return
        }
        
        let parameters: [String: Any] = [
            "email": email,
            "password": password
        ]
        
        let headers: HTTPHeaders = [
            "Content-Type": "application/json"
        ]
        
        AF.request(
            url,
            method: .post,
            parameters: parameters,
            encoding: JSONEncoding.default,
            headers: headers
        )
        .validate(statusCode: 200..<300)
        .responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    let json = try JSON(data: data)
                    if let token = json["token"].string, !token.isEmpty {
                        completion(.success(token))
                    } else {
                        completion(.failure(AuthError.invalidResponse))
                    }
                } catch {
                    completion(.failure(AuthError.invalidResponse))
                }
            case .failure(_):
                completion(.failure(AuthError.invalidResponse))
            }
        }
    }
}

enum AuthError: LocalizedError {
    case invalidResponse
    case serverMessage(String)
    
    var errorDescription: String? {
        switch self {
        case .invalidResponse: return "Invalid response from server"
        case .serverMessage(let msg): return msg
        }
    }
}
