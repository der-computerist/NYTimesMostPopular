//
//  RemoteAPIError.swift
//  
//
//  Created by Enrique Aliaga on 26/02/24.
//

import Foundation

public enum RemoteAPIError: Error {
    case unknown
    case badURL
    case httpError
    case underlying(Error)
}

extension RemoteAPIError: CustomStringConvertible {
    
    public var description: String {
        switch self {
        case .unknown:
            return "The app had a problem loading some data.\nPlease try again!"
        case .badURL:
            return "The app had a problem creating a URL.\nPlease try again!"
        case .httpError:
            return "The app had a problem loading some data.\nPlease try again!"
        case let .underlying(error):
            return error.localizedDescription
        }
    }
}
