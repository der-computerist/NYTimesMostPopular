//
//  ArticleMediaMetadata.swift
//  
//
//  Created by Enrique Aliaga on 20/02/24.
//

import Foundation

public struct ArticleMediaMetadata: Codable {
    
    public let urlString: String
    public let format: ImageCropName
    public let height: Int
    public let width: Int
    
    enum CodingKeys: String, CodingKey {
        case urlString = "url", format, height, width
    }
    
    public var url: URL? {
        URL(string: urlString)
    }
}

public enum ImageCropName: String, Codable {
    case small = "Standard Thumbnail"
    case medium = "mediumThreeByTwo210"
    case big = "mediumThreeByTwo440"
}
