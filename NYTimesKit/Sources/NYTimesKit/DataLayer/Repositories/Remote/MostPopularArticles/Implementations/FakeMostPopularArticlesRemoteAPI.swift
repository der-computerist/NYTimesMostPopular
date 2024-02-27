//
//  FakeMostPopularArticlesRemoteAPI.swift
//  
//
//  Created by Enrique Aliaga on 18/02/24.
//

import Foundation

public struct FakeMostPopularArticlesRemoteAPI: MostPopularArticlesRemoteAPI {
    
    // MARK: - Methods
    public init() {}
    
    public func getMostPopularArticles(
        path: MostPopularArticles.Path,
        forLastDays: MostPopularArticles.Period,
        completionHandler: (Result<MostPopularArticles, RemoteAPIError>) -> Void
    ) {
        guard
            let localResponsePath = Bundle.main.url(forResource: "FakeResponse", withExtension: "json"),
            let localResponseData = try? Data(contentsOf: localResponsePath)
        else {
            completionHandler(.failure(.unknown))
            return
        }
        
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let articleResponse = try decoder.decode(ArticleResponse.self, from: localResponseData)
            let articles = articleResponse.results
            completionHandler(.success(articles))
        } catch {
            completionHandler(.failure(.underlying(error)))
        }
    }
}
