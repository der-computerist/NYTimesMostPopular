//
//  MockArticleSelectedResponder.swift
//  
//
//  Created by Enrique Aliaga on 26/02/24.
//

import Foundation
import NYTimesKit

final class MockArticleSelectedResponder: ArticleSelectedResponder {
    
    public private(set) var showArticleDetailForCallCount = 0
    
    func showArticleDetail(for article: Article) {
        showArticleDetailForCallCount += 1
    }
}
