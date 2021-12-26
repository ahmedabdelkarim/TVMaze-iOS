//
//  String+Extensions.swift
//  TVMaze
//
//  Created by Ahmed Abdelkarim on 25/12/2021.
//

import Foundation

extension String {
    
    /// Convert html string to NSAttributedString that can be used with UILabel, UITextView, etc.
    var htmlAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return nil }
        
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
        }
        catch {
            return nil
        }
    }
    
    /// Get normal string from html string
    var htmlToString: String {
        return htmlAttributedString?.string ?? ""
    }
}
