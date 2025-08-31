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
    
    func login(email: String, password: String, completion: @escaping (Result<String, NatworkAPIError>) -> Void) {
        let urlString = "\(APIConfig.baseURL)/user/login"
        
        guard let url = URL(string: urlString) else {
            completion(.failure(NatworkAPIError.invalidResponse))
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
                        completion(.failure(NatworkAPIError.invalidResponse))
                    }
                } catch {
                    completion(.failure(NatworkAPIError.invalidResponse))
                }
            case .failure(_):
                if let data = response.data,
                    let json = try? JSON(data: data),
                    let message = json["message"].string {
                    completion(.failure(NatworkAPIError.serverMessage(message)))
                } else {
                    completion(.failure(NatworkAPIError.invalidResponse))
                }
            }
        }
    }
    
    func register(
        username: String,
        email: String,
        password: String,
        completion: @escaping (Result<User, NatworkAPIError>) -> Void) {
        let urlString = "\(APIConfig.baseURL)/user/register"
        
        guard let url = URL(string: urlString) else {
            completion(.failure(NatworkAPIError.invalidResponse))
            return
        }
            
        let parameters: [String: Any] = [
            "username": username,
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
                    let user = User(json: json)
                    completion(.success(user))
                } catch {
                    completion(.failure(NatworkAPIError.invalidResponse))
                }
            case .failure(_):
                if let data = response.data,
                    let json = try? JSON(data: data),
                    let message = json["message"].string {
                    completion(.failure(NatworkAPIError.serverMessage(message)))
                } else {
                    completion(.failure(NatworkAPIError.invalidResponse))
                }
            }
        }
    }
}
