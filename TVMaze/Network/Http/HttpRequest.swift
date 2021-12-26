//
//  HttpRequest.swift
//  TVMaze
//
//  Created by Ahmed Abdelkarim on 24/12/2021.
//

import Foundation

protocol HttpRequest {
    var url: String { get }
    var method: HttpMethod { get }
    var headers: Dictionary<String, String>? { get }
    var bodyParameters: Dictionary<String, Any>? { get }
}

enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
    // others
}
