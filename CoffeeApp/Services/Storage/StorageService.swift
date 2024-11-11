//
//  UserDefaultsService.swift
//  CoffeeApp
//
//  Created by Павел Градов on 05.11.2024.
//

import Foundation

final class StorageService {
    static let shared = StorageService()
    
    private static let KEY_ACCESS_TOKEN = "auth_token"
    private static let KEY_ACCESS_TOKEN_EXPIRE = "auth_token_expire"
    
    private init() { }
    
    func saveAuth(_ token: TokenResponse) {
        let defaults = UserDefaults.standard
        defaults.set(token.token, forKey: StorageService.KEY_ACCESS_TOKEN)
        defaults.set(token.tokenLifetime, forKey: StorageService.KEY_ACCESS_TOKEN_EXPIRE)
    }
    
    func getToken() -> TokenResponse {
        let defaults = UserDefaults.standard
        let accessToken = defaults.object(forKey: StorageService.KEY_ACCESS_TOKEN) as? String ?? ""
        let tokenLifetime = defaults.object(forKey: StorageService.KEY_ACCESS_TOKEN_EXPIRE) as? Int32 ?? 0
        
        return TokenResponse(token: accessToken, tokenLifetime: tokenLifetime)
    }
    
    func haveAuthToken() -> Bool {
        return !getToken().token.isEmpty
    }
    
    func dropToken() {
        let defaults = UserDefaults.standard
        defaults.set("", forKey: StorageService.KEY_ACCESS_TOKEN)
        defaults.set(0, forKey: StorageService.KEY_ACCESS_TOKEN_EXPIRE)
    }
}
