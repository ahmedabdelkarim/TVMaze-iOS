//
//  HttpResponse.swift
//  TVMaze
//
//  Created by Ahmed Abdelkarim on 24/12/2021.
//

import Foundation

/// The response of an HttpRequest.
struct HttpResponse<T> {
    var response: HTTPURLResponse
    var body: T?
}
