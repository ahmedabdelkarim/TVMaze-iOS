//
//  MovieResponses.swift
//  TVMaze
//
//  Created by Ahmed Abdelkarim on 24/12/2021.
//

import Foundation

struct MovieResponse: Decodable {
    // MARK: - Properties
    let id: Int
    let name: String
    let url: String
    let runtime: Int?
    let premiered: String
    let mediumImage: String?
    let originalImage: String?
    
    // MARK: - Main Keys
    enum CodingKeys: String, CodingKey {
        case show
    }
    
    // MARK: - Nesting
    struct Show: Decodable {
        let id: Int
        let name: String
        let url: String
        let runtime: Int?
        let premiered: String
        let image: Image?
        
        struct Image: Decodable {
            let medium: String
            let original: String
        }
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let show = try container.decode(Show.self, forKey: .show)
        
        self.id = show.id
        self.name = show.name
        self.url = show.url
        self.runtime = show.runtime
        self.premiered = show.premiered
        self.mediumImage = show.image?.medium
        self.originalImage = show.image?.original
    }
}
