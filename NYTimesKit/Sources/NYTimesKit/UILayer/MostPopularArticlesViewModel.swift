//
//  MostPopularArticlesViewModel.swift
//  
//
//  Created by Enrique Aliaga on 17/02/24.
//

import Foundation
import Combine

public class MostPopularArticlesViewModel {
    
    // MARK: - Properties
    let mostPopularArticlesRepository: MostPopularArticlesRepository
    let articleSelectedResponder: ArticleSelectedResponder
    
    public let errorPresentation = PassthroughSubject<ErrorPresentation?, Never>()
    public var errorMessages: AnyPublisher<ErrorMessage, Never> {
        errorMessagesSubject.eraseToAnyPublisher()
    }
    private let errorMessagesSubject = PassthroughSubject<ErrorMessage, Never>()
    
    private var subscriptions = Set<AnyCancellable>()
    
    @Published public private(set) var path: MostPopularArticles.Path
    @Published public private(set) var period: MostPopularArticles.Period
    
    @Published public private(set) var articles: MostPopularArticles = [] {
        didSet {
            print("Articles received in the view model: \(articles.count)")
        }
    }
    
    @Published public private(set) var fetchingArticles = false
    
    // MARK: - Methods
    public init(path: MostPopularArticles.Path,
                period: MostPopularArticles.Period,
                mostPopularArticlesRepository: MostPopularArticlesRepository,
                articleSelectedResponder: ArticleSelectedResponder) {
        self.path = path
        self.period = period
        self.mostPopularArticlesRepository = mostPopularArticlesRepository
        self.articleSelectedResponder = articleSelectedResponder
        
        fetchMostPopularArticles(path: self.path, forLastDays: self.period)
        
        $path
            .removeDuplicates()
            .dropFirst()
            .sink { [weak self] in
                guard let strongSelf = self else { return }
                strongSelf.fetchMostPopularArticles(path: $0, forLastDays: strongSelf.period)
            }
            .store(in: &subscriptions)
        $period
            .removeDuplicates()
            .dropFirst()
            .sink { [weak self] in
                guard let strongSelf = self else { return }
                strongSelf.fetchMostPopularArticles(path: strongSelf.path, forLastDays: $0)
            }
            .store(in: &subscriptions)
    }
    
    func fetchMostPopularArticles(
        path: MostPopularArticles.Path,
        forLastDays period: MostPopularArticles.Period
    ) {
        print("Starting to fetch most popular articles...\nPath:\(path)\nPeriod:\(period)")
        fetchingArticles = true
        
        mostPopularArticlesRepository
            .mostPopularArticles(path: path, forLastDays: period) { [weak self] result in
                guard let strongSelf = self else { return }
                
                strongSelf.fetchingArticles = false
                
                switch result {
                case let .success(articles):
                    strongSelf.update(articleList: articles)
                case let .failure(error):
                    strongSelf.retryFetchAfterErrorPresentation()
                    let errorMessage = ErrorMessage(
                        title: "Error",
                        message: error.description
                    )
                    strongSelf.errorMessagesSubject.send(errorMessage)
                }
            }
    }
    
    public func update(period: MostPopularArticles.Period) {
        self.period = period
    }

    public func update(path: MostPopularArticles.Path) {
        self.path = path
    }
    
    public func select(article: Article) {
        articleSelectedResponder.showArticleDetail(for: article)
    }
    
    func retryFetchAfterErrorPresentation() {
        errorPresentation
            .filter { $0 == .dismissed }
            .prefix(1)
            .sink { [weak self] _ in
                guard let strongSelf = self else { return }
                strongSelf.fetchMostPopularArticles(path: strongSelf.path,
                                                    forLastDays: strongSelf.period)
            }
            .store(in: &subscriptions)
    }
    
    private func update(articleList: MostPopularArticles) {
        self.articles = articleList
    }
}
