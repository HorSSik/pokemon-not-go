//
//  NetworkProcessable+Extensions.swift
//  Network Service
//
//  Created by IDAP Developer on 12/3/19.
//  Copyright © 2019 Bendis. All rights reserved.
//

import Foundation

public extension NetworkProcessable where ReturnedType: Codable {
    
    static var decoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        
        return decoder
    }
    
    static func initialize(with data: Result<Data, Error>) -> Result<ReturnedType, Error> {
        do {
            let data = try data.get()
            let decoded = try self.decoder.decode(ReturnedType.self, from: data)
            
            return .success(decoded)
        } catch {
            return .failure(error)
        }
    }
}
