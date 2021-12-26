//
//  HttpJsonConverter.swift
//  TVMaze
//
//  Created by Ahmed Abdelkarim on 24/12/2021.
//

import Foundation

protocol HttpJsonConverter {
    init(encoder: JSONEncoder, decoder: JSONDecoder)
    
    func getObject<T: Decodable>(from jsonData: Data) throws -> T
    func getData<T: Encodable>(from object: T) throws -> Data
}

class DefaultHttpJsonConverter: HttpJsonConverter {
    // MARK: - Properties
    private var encoder: JSONEncoder
    private var decoder: JSONDecoder
    
    // MARK: - Init
    init() {
        encoder = JSONEncoder()
        decoder = JSONDecoder()
    }
    
    required init(encoder: JSONEncoder, decoder: JSONDecoder) {
        self.encoder = encoder
        self.decoder = decoder
    }
    
    // MARK: - Methods
    func getObject<T: Decodable>(from jsonData: Data) throws -> T {
        do {
            let object: T = try decoder.decode(T.self, from: jsonData)
            return object
        }
        catch {
            throw error
        }
    }
    
    func getData<T: Encodable>(from object: T) throws -> Data {
        do {
            let jsonData: Data = try encoder.encode(object)
            return jsonData
        }
        catch {
            throw error
        }
    }
}
