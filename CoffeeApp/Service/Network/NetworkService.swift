//
//  NetworkService.swift
//  CoffeeApp
//
//  Created by Павел Градов on 05.11.2024.
//

import Foundation
import Alamofire

enum NetworkRequestCollection {
    static let basedURL: String = "http://147.78.66.203:3210"
    
    case register, login, location(String), locations
    
    func path() -> String {
        switch self {
        case .register: 
            return "/auth/register"
        case .login: return "/auth/login"
        case .location(let id): return "/location/\(id)/menu"
        case .locations: return "/locations"
        }
    }
    
    var absoluteURL: URL {
        URL(string: NetworkRequestCollection.basedURL + self.path())!
    }
}

enum Result<T> {
    case success(_ response: T)
    case serverError(_ err: ErrorResponse)
    case authError(_ err: ErrorResponse)
    case networkError(_ err: String)
}

protocol RegisterServiceInput: AnyObject {
    func registerUser(withData data: User, completion: @escaping (Result<TokenResponse>) -> ())
}

final class NetworkService {
    static let shared = NetworkService()
    static private let ACCESS_TOKEN_LIFETIME_THRESHHOLD_SECONDS: Int = 3600000
    
    private var token = StorageService.shared.getToken()
    
    private init() { }
    
    private func formRequest(url: URL, data: Data, method: String = "POST", contentType: String = "application/json", ignoreJwtAuth: Bool = false) -> URLRequest {
        
        var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData)
        request.httpMethod = method
        request.httpBody = data
        request.setValue(contentType, forHTTPHeaderField: "Content-Type")
        
        if !token.token.isEmpty && !ignoreJwtAuth {
            request.addValue("Bearer \(token.token)", forHTTPHeaderField: "Authorization")
        }
        
        return request
    }
    
    private func doRequest<T: Decodable>(request: URLRequest, completion: @escaping(Result<T>) -> ()) {
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    completion(.networkError(error.localizedDescription))
                    return
                }
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.networkError(Errors.ERR_CONVERTING_TO_HTTP_RESPONSE))
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(.serverError(ErrorResponse(code: httpResponse.statusCode, message: Errors.ERR_NIL_BODY)))
                }
                return
            }

            let responseBody: Result<T> = httpResponse.isSuccess() ? self.parseResponse(data: data) : self.parseError(data: data)
            
            DispatchQueue.main.async {
                completion(responseBody)
            }
        }
        task.resume()
    }
    
    private func parseResponse<T: Decodable>(data: Data) -> Result<T> {
        do {
            return .success(try JSONDecoder().decode(T.self, from: data))
        } catch {
            return parseError(data: data)
        }
    }
    
    private func parseError<T>(data: Data) -> Result<T> {
        do {
            let errorResponse = try JSONDecoder().decode(ErrorResponse.self, from: data)
            return errorResponse.isAuth() ? .authError(errorResponse) : .serverError(errorResponse)
        } catch {
            return .serverError(ErrorResponse(code: 0, message: Errors.ERR_PARSE_ERROR_RESPONSE))
        }
    }
}

// TODO: method's enum
extension NetworkService: RegisterServiceInput {
    func registerUser(withData data: User, completion: @escaping (Result<TokenResponse>) -> ()) {
        let url = NetworkRequestCollection.register.absoluteURL
        let body = try! JSONEncoder().encode(data)
        let request = formRequest(url: url, data: body, method: "POST", ignoreJwtAuth: true)
    
        self.doRequest(request: request) { result in
            completion(result)
        }
    }
}
