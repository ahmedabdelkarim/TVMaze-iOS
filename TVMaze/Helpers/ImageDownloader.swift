//
//  ImageDownloader.swift
//  TVMaze
//
//  Created by Ahmed Abdelkarim on 25/12/2021.
//

import Foundation

class ImageDownloader {
    func downloadImage(fromUrlString urlString: String, success: @escaping (Data) -> Void, failure: @escaping () -> Void) {
        // try to create URL
        guard let url = URL(string: urlString) else {
            failure()
            return
        }
        
        // fetch image data (GCD + Data(contentsOf:)
        DispatchQueue.global(qos: .background).async {
            if let data = try? Data(contentsOf: url) {
                success(data)
            }
            else {
                failure()
            }
        }
        
        // fetch image data (URLSession dataTask)
        // URLSession.shared.dataTask(with: url) { (data, _, _) in
        //    if let data = data {
        //        success(data)
        //    }
        //    else {
        //        failure()
        //    }
        // }.resume()
    }
}
