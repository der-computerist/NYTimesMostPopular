//
//  NYTimesAppDependencyContainer.swift
//  
//
//  Created by Enrique Aliaga on 19/02/24.
//

import UIKit
import NYTimesKit

public class NYTimesAppDependencyContainer {
    
    // MARK: - Properties
    
    // Context
    let defaultPath: MostPopularArticles.Path = .mostViewed
    let defaultPeriod: MostPopularArticles.Period = .oneDay
    
    // Long-lived dependencies
    let mostPopularArticlesRepository: MostPopularArticlesRepository
    let sharedMainViewModel: MainViewModel
    
    // MARK: - Methods
    public init() {
        func makeMostPopularArticlesRepository() -> MostPopularArticlesRepository {
            let dataStore = makeMostPopularArticlesDataStore()
            let remoteAPI = makeMostPopularArticlesRemoteAPI()
            return NYTimesMostPopularArticlesRepository(dataStore: dataStore,
                                                        remoteAPI: remoteAPI)
        }
        
        func makeMostPopularArticlesDataStore() -> MostPopularArticlesDataStore {
            FileMostPopularArticlesDataStore()
        }
        
        func makeMostPopularArticlesRemoteAPI() -> MostPopularArticlesRemoteAPI {
            NYTimesMostPopularArticlesRemoteAPI()
        }
        
        func makeMainViewModel() -> MainViewModel {
            MainViewModel()
        }
        
        self.mostPopularArticlesRepository = makeMostPopularArticlesRepository()
        self.sharedMainViewModel = makeMainViewModel()
    }
    
    // Main
    // Factories needed to create a MainViewController.
    
    public func makeMainViewController() -> MainViewController {
        let mostPopularArticlesViewController = makeMostPopularArticlesViewController()
        
        let articleDetailViewControllerFactory = { (article: Article) in
            self.makeArticleDetailViewController(article: article)
        }
        
        return MainViewController(viewModel: sharedMainViewModel,
                                  mostPopularArticlesViewController: mostPopularArticlesViewController,
                                  articleDetailViewControllerFactory: articleDetailViewControllerFactory)
    }
    
    // Most Popular Articles
    
    public func makeMostPopularArticlesViewController() -> MostPopularArticlesViewController {
        let viewModel = makeMostPopularArticlesViewModel()
        return MostPopularArticlesViewController(viewModel: viewModel)
    }
    
    public func makeMostPopularArticlesViewModel() -> MostPopularArticlesViewModel {
        MostPopularArticlesViewModel(path: defaultPath,
                                     period: defaultPeriod,
                                     mostPopularArticlesRepository: mostPopularArticlesRepository,
                                     articleSelectedResponder: sharedMainViewModel)
    }
    
    // Article Detail
    
    public func makeArticleDetailViewController(article: Article) -> ArticleDetailViewController {
        let viewModel = makeArticleDetailViewModel(article: article)
        return ArticleDetailViewController(viewModel: viewModel)
    }
    
    public func makeArticleDetailViewModel(article: Article) -> ArticleDetailViewModel {
        ArticleDetailViewModel(article: article)
    }
}
