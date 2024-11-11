//
//  NetworkConstants.swift
//  CoffeeApp
//
//  Created by Павел Градов on 09.11.2024.
//

enum RequestMethod: String {
    case get = "GET"
    case post = "POST"
}

enum HTTPHeaderField: String {
    case auth = "Authorization"
    case contentType = "Content-Type"
}

enum ContentType: String {
    case appJson = "application/json"
}
