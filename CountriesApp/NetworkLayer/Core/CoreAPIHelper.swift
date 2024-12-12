//
//  CoreAPIHelper.swift
//  CountriesApp
//
//  Created by Bakhtiyar Pirizada on 12.12.24.
//

import Foundation
enum HttpMethods: String {
    case GET
    case POST
    case PATCH
    case PUT
    case DELETE
}

final class CoreAPIHelper {
    static let instance = CoreAPIHelper()
    private init() {}
    private let baseURL = "https://restcountries.com/v3.1/"
    
    func makeURL(path: String) -> URL? {
        let urlString = baseURL + path
        return URL(string:urlString)
    }
    
    func makeHeader() -> [String: String] {
        return ["Authoration": "Barear Token"]
    }
}
