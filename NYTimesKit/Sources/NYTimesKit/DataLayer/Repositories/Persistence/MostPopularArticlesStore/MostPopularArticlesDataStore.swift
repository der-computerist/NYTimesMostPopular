//
//  MostPopularArticlesDataStore.swift
//  
//
//  Created by Enrique Aliaga on 18/02/24.
//

import Foundation

public protocol MostPopularArticlesDataStore {
    
    func mostPopularArticles(
        path: MostPopularArticles.Path,
        forLastDays: MostPopularArticles.Period,
        completionHandler: (Result<MostPopularArticles, NYTimesKitError>) -> Void
    )
    
    func save(
        mostPopularArticles: MostPopularArticles,
        forPath: MostPopularArticles.Path,
        period: MostPopularArticles.Period
    ) throws
}
