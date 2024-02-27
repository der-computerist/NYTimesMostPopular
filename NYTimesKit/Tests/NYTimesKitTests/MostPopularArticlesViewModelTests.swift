//
//  MostPopularArticlesViewModelTests.swift
//  
//
//  Created by Enrique Aliaga on 23/02/24.
//

import XCTest
import Combine
@testable import NYTimesKit

func constructTestingRepository() -> MostPopularArticlesRepository {
    let fakeAPI = FakeMostPopularArticlesRemoteAPI()
    let fakeDataStore = FakeMostPopularArticlesDataStore()
    return NYTimesMostPopularArticlesRepository(dataStore: fakeDataStore, remoteAPI: fakeAPI)
}

final class MostPopularArticlesViewModelTests: XCTestCase {
    
    // MARK: - Properties
    var mockArticleSelectedResponder: MockArticleSelectedResponder!
    var sut: MostPopularArticlesViewModel!
    var expectation: XCTestExpectation?
    let timeout = 1.0
    
    var subscriptions = Set<AnyCancellable>()
    
    // MARK: - Methods
    override func setUp() {
        super.setUp()
        
        mockArticleSelectedResponder = MockArticleSelectedResponder()
        
        sut = MostPopularArticlesViewModel(
            path: .mostViewed,
            period: .oneDay,
            mostPopularArticlesRepository: constructTestingRepository(),
            articleSelectedResponder: mockArticleSelectedResponder
        )
    }
    
    override func tearDown() {
        mockArticleSelectedResponder = nil
        sut = nil
        super.tearDown()
    }
    
    func test_fetchMostPopularArticles_shouldUpdateArticles() {
        expectation = self.expectation(description: "Articles fetched successfully.")
        
        sut
            .$articles
            .dropFirst()
            .sink { [weak self] articles in
                guard articles.count > 0 else {
                    XCTFail("Articles could not be fetched.")
                    return
                }
                self?.expectation?.fulfill()
            }
            .store(in: &subscriptions)
        
        sut.fetchMostPopularArticles(path: sut.path, forLastDays: sut.period)
        
        waitForExpectations(timeout: timeout)
    }
    
    func test_updatePeriod_shouldFetchMostPopularArticles() {
        // Expect new articles to be fetched
        expectation = self.expectation(
            description: "Articles fetched again, for new period: \(sut.period)."
        )
        
        sut
            .$articles
            .dropFirst()
            .sink { [weak self] articles in
                guard articles.count > 0 else {
                    XCTFail("Articles could not be fetched.")
                    return
                }
                self?.expectation?.fulfill()
            }
            .store(in: &subscriptions)
        
        sut.update(period: .thirtyDays)
        waitForExpectations(timeout: timeout)
        
        // Verify period was updated
        XCTAssertEqual(sut.period, .thirtyDays)
    }
    
    func test_updatePath_shouldFetchMostPopularArticles() {
        // Expect new articles to be fetched
        expectation = self.expectation(
            description: "Articles fetched again, for new path: \(sut.path)."
        )
        
        sut
            .$articles
            .dropFirst()
            .sink { [weak self] articles in
                guard articles.count > 0 else {
                    XCTFail("Articles could not be fetched.")
                    return
                }
                self?.expectation?.fulfill()
            }
            .store(in: &subscriptions)
        
        sut.update(path: .mostShared)
        waitForExpectations(timeout: timeout)
        
        // Verify path was updated
        XCTAssertEqual(sut.path, .mostShared)
    }
    
    func test_selectArticle_shouldNotifyResponder() {
        let article = Article(
            id: 100000009321523,
            title: "A Family Dinner With My Wife and Girlfriend",
            byline: "By Townsend Davis",
            publishedDate: "2024-02-23",
            abstract: "Learning to love two women at once — one living with Alzheimer’s — is a challenge and a blessing.",
            url: "https://www.nytimes.com/2024/02/23/style/modern-love-alzheimers-family-dinner-with-my-wife-and-girlfriend.html",
            media: [
                ArticleMedia(
                    type: "image",
                    subtype: "photo",
                    caption: "",
                    copyright: "Brian Rea",
                    mediaMetadata: [
                        ArticleMediaMetadata(
                            urlString: "https://static01.nyt.com/images/2024/02/25/fashion/25MODERN-DAVIS/25MODERN-DAVIS-thumbStandard.jpg",
                            format: .small,
                            height: 75,
                            width: 75
                        ),
                        ArticleMediaMetadata(
                            urlString: "https://static01.nyt.com/images/2024/02/25/fashion/25MODERN-DAVIS/25MODERN-DAVIS-mediumThreeByTwo210.jpg",
                            format: .medium,
                            height: 140,
                            width: 210
                        ),
                        ArticleMediaMetadata(
                            urlString: "https://static01.nyt.com/images/2024/02/25/fashion/25MODERN-DAVIS/25MODERN-DAVIS-mediumThreeByTwo440.jpg",
                            format: .big,
                            height: 293,
                            width: 440
                        )
                    ]
                )
            ]
        )
        sut.select(article: article)
        
        XCTAssertEqual(mockArticleSelectedResponder.showArticleDetailForCallCount, 1)
    }
}
