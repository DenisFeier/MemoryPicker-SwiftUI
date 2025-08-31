//
//  UserService.swift
//  MemoryPicker
//
//  Created by Denis Feier on 31.08.2025.
//

import Alamofire
import SwiftyJSON

struct UserService {
    
    static let shared = UserService()
    
    private init() {}
    
    func getMyData(completion: @escaping (Result<User, NatworkAPIError>) -> Void) {
        guard let token = loadToken() else {
            completion(.failure(.userError("No authentication token found.")))
            return
        }
        
        let url = "\(APIConfig.baseURL)/user/me"
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(token)"
        ]
        
        AF.request(url, method: .get, headers: headers)
            .validate()
            .responseData { response in
                switch response.result {
                case .success(let data):
                    let json = JSON(data)
                    let user = User(json: json)
                    completion(.success(user))
                case .failure(let error):
                    if let data = response.data,
                        let json = try? JSON(data: data),
                        let message = json["message"].string {
                        completion(.failure(.serverMessage(message)))
                    } else {
                        completion(.failure(.userError(error.localizedDescription)))
                    }
                }
            }
    }
}