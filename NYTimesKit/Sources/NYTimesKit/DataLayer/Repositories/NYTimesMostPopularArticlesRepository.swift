//
//  NYTimesMostPopularArticlesRepository.swift
//  
//
//  Created by Enrique Aliaga on 18/02/24.
//

import Foundation

public class NYTimesMostPopularArticlesRepository: MostPopularArticlesRepository {
    
    // MARK: - Properties
    let dataStore: MostPopularArticlesDataStore
    let remoteAPI: MostPopularArticlesRemoteAPI
    
    // MARK: - Methods
    public init(dataStore: MostPopularArticlesDataStore,
                remoteAPI: MostPopularArticlesRemoteAPI) {
        self.dataStore = dataStore
        self.remoteAPI = remoteAPI
    }
    
    public func mostPopularArticles(
        path: MostPopularArticles.Path,
        forLastDays period: MostPopularArticles.Period,
        completionHandler: @escaping (Result<MostPopularArticles, NYTimesKitError>) -> Void
    ) {
        remoteAPI
            .getMostPopularArticles(path: path, forLastDays: period) { [weak self] result in
                guard let strongSelf = self else { return }
                
                switch result {
                case let .success(articles):
                    // Fetching articles from Remote API was successful. Let's store the data
                    // locally for offline access (whenever network is not available.)
                    try? strongSelf.dataStore.save(
                        mostPopularArticles: articles,
                        forPath: path,
                        period: period
                    )
                    // ... and then continue as normal.
                    completionHandler(.success(articles))
                    
                case .failure:
                    // Fetching articles from Remote API failed. Let's try to gracefully
                    // fall back to local data.
                    strongSelf.dataStore.mostPopularArticles(
                        path: path,
                        forLastDays: period,
                        completionHandler: completionHandler
                    )
                }
            }
    }
}
