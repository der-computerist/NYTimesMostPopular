//
//  MainView.swift
//  
//
//  Created by Enrique Aliaga on 17/02/24.
//

import Foundation

public enum MainView {
    case mostPopularArticles
    case articleDetail(article: Article)
}

extension MainView: Equatable {
    
    public static func ==(lhs: MainView, rhs: MainView) -> Bool {
        switch (lhs, rhs) {
        case (.mostPopularArticles, .mostPopularArticles):
            return true
        case (.articleDetail, .articleDetail):
            return true
        case (.mostPopularArticles, _),
            (.articleDetail, _):
            return false
        }
    }
}
