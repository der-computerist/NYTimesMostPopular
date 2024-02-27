//
//  MostPopularArticlesRepository.swift
//  
//
//  Created by Enrique Aliaga on 18/02/24.
//

import Foundation

public typealias MostPopularArticles = [Article]

public protocol MostPopularArticlesRepository {
    
    func mostPopularArticles(
        path: MostPopularArticles.Path,
        forLastDays: MostPopularArticles.Period,
        completionHandler: @escaping (Result<MostPopularArticles, NYTimesKitError>) -> Void
    )
}

public extension MostPopularArticles {
    
    enum Path {
        case mostEmailed
        case mostShared
        case mostViewed
    }
    
    enum Period: String {
        case oneDay = "1"
        case sevenDays = "7"
        case thirtyDays = "30"
    }
}
