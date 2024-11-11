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

enum RequestResult<T> {
    case success(_ response: T)
    case serverError(_ err: ErrorResponse)
    case authError(_ err: ErrorResponse)
    case networkError(_ err: String)
}

protocol RegisterServiceInput: AnyObject {
    func registerUser(withData data: User, completion: @escaping (RequestResult<TokenResponse>) -> ())
}

protocol AuthServiceInput: AnyObject {
    func authorizeUser(withData data: User, completion: @escaping (RequestResult<TokenResponse>) -> Void)
}

protocol LocationListServiceInput: AnyObject {
    func loadLocations(completion: @escaping (RequestResult<LocationList>) -> Void)
}

final class NetworkService {
    static let shared = NetworkService()
    
    private var token = StorageService.shared.getToken()
    
    private init() { }
    
    private func formRequest(
        url: URL,
        data: Data? = nil,
        method: String = RequestMethod.post.rawValue,
        contentType: String = ContentType.appJson.rawValue,
        ignoreJwtAuth: Bool = false
    ) -> URLRequest {
        
        var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData)
        request.httpMethod = method
        if let data { request.httpBody = data }
        request.setValue(contentType, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
        
        if !token.token.isEmpty && !ignoreJwtAuth {
            request.addValue("Bearer \(token.token)", forHTTPHeaderField: HTTPHeaderField.auth.rawValue)
        }
        
        return request
    }
    
    private func doRequest<T: Decodable>(request: URLRequest, completion: @escaping(RequestResult<T>) -> Void) {
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

            let responseBody: RequestResult<T> = httpResponse.isSuccess() ? self.parseResponse(data: data) : self.parseError(data: data)
            
            DispatchQueue.main.async {
                completion(responseBody)
            }
        }
        task.resume()
    }
    
    private func parseResponse<T: Decodable>(data: Data) -> RequestResult<T> {
        do {
            return .success(try JSONDecoder().decode(T.self, from: data))
        } catch {
            return parseError(data: data)
        }
    }
    
    private func parseError<T>(data: Data) -> RequestResult<T> {
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
    func registerUser(withData data: User, completion: @escaping (RequestResult<TokenResponse>) -> Void) {
        let url = NetworkRequestCollection.register.absoluteURL
        let body = try! JSONEncoder().encode(data)
        let request = formRequest(url: url, data: body, method: RequestMethod.post.rawValue, ignoreJwtAuth: true)
    
        self.doRequest(request: request) { result in
            completion(result)
        }
    }
}

extension NetworkService: AuthServiceInput {
    func authorizeUser(withData data: User, completion: @escaping (RequestResult<TokenResponse>) -> Void) {
        let url = NetworkRequestCollection.login.absoluteURL
        let body = try! JSONEncoder().encode(data)
        let request = formRequest(url: url, data: body, method: RequestMethod.post.rawValue, ignoreJwtAuth: true)
        
        self.doRequest(request: request) { result in
            completion(result)
        }
    }
}

extension NetworkService: LocationListServiceInput {
    func loadLocations(completion: @escaping (RequestResult<LocationList>) -> Void) {
        let url = NetworkRequestCollection.locations.absoluteURL
        let request = formRequest(url: url, method: RequestMethod.get.rawValue)
        
        self.doRequest(request: request) { result in
            completion(result)
        }
    }
}
