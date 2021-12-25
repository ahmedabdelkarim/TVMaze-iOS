//
//  Movie.swift
//  TVMaze
//
//  Created by Ahmed Abdelkarim on 24/12/2021.
//

import Foundation
import UIKit

class Movie {
    let id: Int
    let name: String
    let url: String
    let summary: String?
    let runtime: Int?
    let premiered: String?
    let averageRating: Float?
    let mediumImage: String?
    let originalImage: String?
    
    /// UIImage for medium size image
    private(set) var mediumImageUI: UIImage?
    // used to prevent multiple download at the same time
    private let downloadLock = NSLock()
    private var downloads = 0 // for testing download lock
    
    init(id: Int, name: String, url: String, summary: String?, runtime: Int?, premiered: String?, averageRating: Float?, mediumImage: String?, originalImage: String?) {
        self.id = id
        self.name = name
        self.url = url
        self.summary = summary
        self.runtime = runtime
        self.premiered = premiered
        self.averageRating = averageRating
        self.mediumImage = mediumImage
        self.originalImage = originalImage
    }
    
    func getMediumImage(success: @escaping (UIImage) -> Void, failure: @escaping () -> Void) {
        // prevent multiple downloads at the same time
        downloadLock.lock()
        
        downloads += 1 // for testing download lock
        print("downloads = \(downloads)") // for testing download lock
        
        // if image already downloaded, return it directly
        if let image = mediumImageUI {
            downloads -= 1 // for testing download lock
            downloadLock.unlock()
            success(image)
            return
        }
        
        // if image not downloaded, download it first
        // try to create URL
        guard let mediumImage = mediumImage else {
            downloads -= 1 // for testing download lock
            downloadLock.unlock()
            return
        }
        
        // download image
        ImageDownloader().downloadImage(fromUrlString: mediumImage, success: { data in
            // convert to UIImage in background, because it can take some time
            DispatchQueue.global(qos: .background).async {
                if let image = UIImage(data: data) {
                    // save UIImage object
                    self.mediumImageUI = image
                    success(image)
                }
                else {
                    failure()
                }
            }
        }, failure: {
            failure()
        })
        
        downloads -= 1 // for testing download lock
        downloadLock.unlock()
    }
    
    func getOriginalImage(success: @escaping (UIImage) -> Void, failure: @escaping () -> Void) {
        // prevent multiple downloads at the same time
        downloadLock.lock()
        
        // try to create URL
        guard let originalImage = originalImage else {
            downloadLock.unlock()
            return
        }
        
        // download image
        ImageDownloader().downloadImage(fromUrlString: originalImage, success: { data in
            // convert to UIImage in background, because it can take some time
            DispatchQueue.global(qos: .background).async {
                if let image = UIImage(data: data) {
                    success(image)
                }
                else {
                    failure()
                }
            }
        }, failure: {
            failure()
        })
        
        downloadLock.unlock()
    }
}
