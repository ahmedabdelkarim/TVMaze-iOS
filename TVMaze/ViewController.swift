//
//  ViewController.swift
//  TVMaze
//
//  Created by Ahmed Abdelkarim on 23/12/2021.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            self.performSegue(withIdentifier: "showMovies", sender: self)
        })
    }

}
