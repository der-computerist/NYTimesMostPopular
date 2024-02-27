//
//  MainViewModel.swift
//  
//
//  Created by Enrique Aliaga on 17/02/24.
//

import Foundation
import Combine

public typealias MainNavigationAction = NavigationAction<MainView>

public class MainViewModel: ArticleSelectedResponder {
    
    // MARK: - Properties
    @Published
    public private(set) var navigationAction: MainNavigationAction = .present(view: .mostPopularArticles)
    
    // MARK: - Methods
    public init() {}
    
    public func showArticleDetail(for article: Article) {
        navigationAction = .present(view: .articleDetail(article: article))
    }
    
    public func uiPresented(mainView: MainView) {
        navigationAction = .presented(view: mainView)
    }
}
