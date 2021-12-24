//
//  RequestConstants.swift
//  TVMaze
//
//  Created by Ahmed Abdelkarim on 24/12/2021.
//

import Foundation

struct RequestUrls {
    static let baseUrl = "http://api.tvmaze.com/search/"
}

enum HttpHeaders: String {
    case contentType = "Content-Type"
    case acceptType = "Accept"
}

enum ContentType: String {
    case json = "application/json"
}
