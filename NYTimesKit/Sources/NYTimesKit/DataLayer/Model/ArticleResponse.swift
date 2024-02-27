//
//  ArticleResponse.swift
//  
//
//  Created by Enrique Aliaga on 20/02/24.
//

import Foundation

public struct ArticleResponse: Decodable {
    
    public let results: [Article]
}
