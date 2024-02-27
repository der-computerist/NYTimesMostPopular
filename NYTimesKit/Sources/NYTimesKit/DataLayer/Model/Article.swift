//
//  Article.swift
//  
//
//  Created by Enrique Aliaga on 18/02/24.
//

import Foundation

public struct Article: Codable, Identifiable {
    
    // MARK: - Properties
    public let id: Int
    public let title: String
    public let byline: String
    public let publishedDate: String
    public let abstract: String
    public let url: String
    public let media: [ArticleMedia]
    
    public var thumbnailURL: URL? {
        media.first?.mediaMetadata.filter({ $0.format == .big }).first?.url
    }
    
    public var prettyPublishedDate: String {
        publishedDate
            .toDate(withFormat: "yyyy-MM-dd")?
            .toString(withFormat: "MMM d, yyyy") ?? ""
    }
}

extension Article: Equatable {
    
    public static func ==(lhs: Article, rhs: Article) -> Bool {
        lhs.id == rhs.id
    }
}
