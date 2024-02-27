//
//  NYTimesKitError.swift
//  
//
//  Created by Enrique Aliaga on 18/02/24.
//

import Foundation

public enum NYTimesKitError: Error {
    case unknown
    case articleFetchError
    case articleDecodeError
}

extension NYTimesKitError: CustomStringConvertible {
                              
    public var description: String {
        switch self {
        case .unknown:
            return "The app experienced an unknown problem.\nPlease try again!"
        case .articleFetchError:
            return "The app had a problem fetching articles.\nPlease try again!"
        case .articleDecodeError:
            return "The app had a problem decoding article data.\nPlease try again!"
        }
    }
}
