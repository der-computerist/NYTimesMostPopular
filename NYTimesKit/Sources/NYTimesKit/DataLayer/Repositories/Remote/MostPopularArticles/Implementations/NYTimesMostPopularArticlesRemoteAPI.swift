//
//  NYTimesMostPopularArticlesRemoteAPI.swift
//  
//
//  Created by Enrique Aliaga on 18/02/24.
//

import Foundation

public struct NYTimesMostPopularArticlesRemoteAPI: MostPopularArticlesRemoteAPI {
    
    // MARK: - Properties
    let urlSession: URLSession
    let domain = "https://api.nytimes.com/svc/mostpopular/v2"
    var apiKey: String {
        guard let apiKey = Bundle.main.infoDictionary?["API_Key"] as? String,
           !apiKey.isEmpty else {
            fatalError("API Key could not be found!")
        }
        return apiKey
    }
    
    // MARK: - Methods
    public init() {
        let config = URLSessionConfiguration.default
        self.urlSession = URLSession(configuration: config)
    }
    
    public func getMostPopularArticles(
        path: MostPopularArticles.Path,
        forLastDays period: MostPopularArticles.Period,
        completionHandler: @escaping (Result<MostPopularArticles, RemoteAPIError>) -> Void
    ) {
        // Build URL
        let endpoint = endpointString(path: path, period: period)
        let urlString = "\(domain + endpoint)?api-key=\(apiKey)"
        guard let url = URL(string: urlString) else {
            completionHandler(.failure(.badURL))
            return
        }
        
        urlSession.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completionHandler(.failure(.underlying(error)))
                return
            }
            guard let httpResponse = response as? HTTPURLResponse else {
                completionHandler(.failure(.unknown))
                return
            }
            guard 200..<300 ~= httpResponse.statusCode else {
                completionHandler(.failure(.httpError))
                return
            }
            guard let data = data else {
                completionHandler(.failure(.unknown))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let articleResponse = try decoder.decode(ArticleResponse.self, from: data)
                let articles = articleResponse.results
                completionHandler(.success(articles))
            } catch {
                completionHandler(.failure(.underlying(error)))
            }
        }
        .resume()
    }
    
    private func endpointString(
        path: MostPopularArticles.Path,
        period: MostPopularArticles.Period
    ) -> String {
        switch path {
        case .mostEmailed:
            return "/emailed/\(period.rawValue).json"
        case .mostShared:
            return "/shared/\(period.rawValue)/facebook.json"
        case .mostViewed:
            return "/viewed/\(period.rawValue).json"
        }
    }
}

