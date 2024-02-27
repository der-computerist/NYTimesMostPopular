//
//  FileMostPopularArticlesDataStore.swift
//  
//
//  Created by Enrique Aliaga on 18/02/24.
//

import Foundation

public class FileMostPopularArticlesDataStore: MostPopularArticlesDataStore {
    
    // MARK: - Properties
    var docsURL: URL? {
        FileManager
            .default.urls(for: FileManager.SearchPathDirectory.documentDirectory,
                          in: FileManager.SearchPathDomainMask.allDomainsMask).first
    }
    
    // MARK: - Methods
    public init() {}
    
    public func mostPopularArticles(
        path: MostPopularArticles.Path,
        forLastDays period: MostPopularArticles.Period,
        completionHandler: (Result<MostPopularArticles, NYTimesKitError>) -> Void
    ) {
        guard let docsURL = docsURL else {
            completionHandler(.failure(.unknown))
            return
        }
        let fileName = fileName(path: path, period: period)
        guard let jsonData = try? Data(contentsOf: docsURL.appendingPathComponent(fileName)) else {
            completionHandler(.failure(.articleFetchError))
            return
        }
        
        do {
            let decoder = JSONDecoder()
            let articles = try decoder.decode(MostPopularArticles.self, from: jsonData)
            completionHandler(.success(articles))
        } catch {
            completionHandler(.failure(.articleDecodeError))
        }
    }
    
    public func save(
        mostPopularArticles: MostPopularArticles,
        forPath path: MostPopularArticles.Path,
        period: MostPopularArticles.Period
    ) throws {
        guard let docsURL = docsURL else {
            throw NYTimesKitError.unknown
        }
        let fileName = fileName(path: path, period: period)
        
        let encoder = JSONEncoder()
        let jsonData = try encoder.encode(mostPopularArticles)
        try? jsonData.write(to: docsURL.appendingPathComponent(fileName))
    }
                          
    private func fileName(
        path: MostPopularArticles.Path,
        period: MostPopularArticles.Period
    ) -> String {
        switch path {
        case .mostEmailed:
            return "most_emailed_articles_\(period.rawValue).json"
        case .mostShared:
            return "most_shared_articles_\(period.rawValue).json"
        case .mostViewed:
            return "most_viewed_articles_\(period.rawValue).json"
        }
    }
}


