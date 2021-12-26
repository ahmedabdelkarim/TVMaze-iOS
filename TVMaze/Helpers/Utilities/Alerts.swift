//
//  Alerts.swift
//  TVMaze
//
//  Created by Ahmed Abdelkarim on 26/12/2021.
//

import Foundation
import UIKit

class Alerts {
    
    typealias AlertAction = () -> Void
    private static let accentColor = UIColor(named: "AccentColor")
    
    /// Show a simple info alert over a specific presented view controller.
    static func showInfoAlert(viewController: UIViewController?, title: String, message: String? = nil, completion: AlertAction? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        DispatchQueue.main.async {
            alert.view.tintColor = accentColor
            
            viewController?.present(alert, animated: true, completion: completion)
        }
    }
}
