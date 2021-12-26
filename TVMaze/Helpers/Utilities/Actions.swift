//
//  Actions.swift
//  TVMaze
//
//  Created by Ahmed Abdelkarim on 25/12/2021.
//

import UIKit

/// Handles general actions.
class Actions {
    /// Opens a url in default browser.
    /// - Parameters:
    ///   - link: The url string
    ///   - success: success closure
    ///   - failure: failure closure
    static func openLink(_ link: String, success: (() -> Void)? = nil, failure: (() -> Void)? = nil) {
        if var url = URL(string: link) {
            var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
            if components?.scheme == nil {
                components?.scheme = "http"
            }
            
            url = components?.url ?? url
            
            UIApplication.shared.open(url, options: [:], completionHandler: {(done) in
                done ? success?() : failure?()
            })
        }
        else {
            failure?()
        }
    }
}
