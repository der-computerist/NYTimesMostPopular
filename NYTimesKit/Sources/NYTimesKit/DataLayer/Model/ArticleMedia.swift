//
//  ArticleMedia.swift
//  
//
//  Created by Enrique Aliaga on 20/02/24.
//

import Foundation

public struct ArticleMedia: Codable {
    
    public let type: String
    public let subtype: String
    public let caption: String
    public let copyright: String
    public let mediaMetadata: [ArticleMediaMetadata]
    
    enum CodingKeys: String, CodingKey {
        case type, subtype, caption, copyright, mediaMetadata = "media-metadata"
    }
}
