//
//  HttpRequest+Default.swift
//  TVMaze
//
//  Created by Ahmed Abdelkarim on 24/12/2021.
//

import Foundation

extension HttpRequest {
    // default headers
    var headers: Dictionary<String, String>? {
        return [HttpHeaders.contentType.rawValue: ContentType.json.rawValue]
    }
    
    // default httpBody parameters
    var bodyParameters: Dictionary<String, Any>? {
        return nil
    }
}
