//
//  HttpLogger.swift
//  TVMaze
//
//  Created by Ahmed Abdelkarim on 24/12/2021.
//

import Foundation

/// Defines log contract that describes how to log events generated during any Http activity.
///
/// To provide your own implementation for logging, adopt to this protocol and inject an object of adopting class to the HttpClient object.
public protocol HttpLogger {
    /// Log an information message informing about success or an important step in Http scenarios.
    /// - Parameter message: The message to log.
    func logInfo(_ message: String)
    
    /// Log an error occurred during any Http activity.
    /// - Parameters:
    ///   - error: The original Error object.
    func logError(_ error: Error)
    
    /// Log description of an error occurred during any Http activity.
    /// - Parameters:
    ///   - description: Text describing the error.
    func logError(description: String)
    
    /// Log an error occurred during any Http activity with description.
    /// - Parameters:
    ///   - error: The original Error object.
    ///   - description: Text describing the error.
    func logError(_ error: Error, description: String)
}

/// The default log implementation used by HttpClient in case no object of type HttpLogger is injected.
class DefaultHttpLogger: HttpLogger {
    #if DEBUG
    func logInfo(_ message: String) {
        print("ⓘ \(message)")
    }
    
    func logError(_ error: Error) {
        print("❗️\(error)")
    }
    
    func logError(description: String) {
        print("❗️\(description)")
    }
    
    func logError(_ error: Error, description: String) {
        print("❗️\(description): \(error)")
    }
    #endif
}
