//
//  MostPopularArticlesRemoteAPI.swift
//  
//
//  Created by Enrique Aliaga on 18/02/24.
//

import Foundation

public protocol MostPopularArticlesRemoteAPI {
    
    func getMostPopularArticles(
        path: MostPopularArticles.Path,
        forLastDays: MostPopularArticles.Period,
        completionHandler: @escaping (Result<MostPopularArticles, RemoteAPIError>) -> Void
    )
}
