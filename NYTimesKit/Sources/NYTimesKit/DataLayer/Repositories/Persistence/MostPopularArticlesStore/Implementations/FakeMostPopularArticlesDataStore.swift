//
//  FakeMostPopularArticlesDataStore.swift
//  
//
//  Created by Enrique Aliaga on 18/02/24.
//

import Foundation

public class FakeMostPopularArticlesDataStore: MostPopularArticlesDataStore {
    
    public func mostPopularArticles(
        path: MostPopularArticles.Path,
        forLastDays: MostPopularArticles.Period,
        completionHandler: (Result<MostPopularArticles, NYTimesKitError>) -> Void
    ) {
        print("Trying to read articles from fake disk...")
        print("  simulating read action...")
        let articles = [
            Article(
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
            ),
            Article(
                id: 100000009323817,
                title: "Their Hearts Were Set on a House in Hudson. Could They Afford the One They Wanted?",
                byline: "By Heather Senison",
                publishedDate: "2024-02-22",
                abstract: "Taking their second shot at an upstate New York home, a couple went looking for a place with space for art supplies, music gear and chickens.",
                url: "https://www.nytimes.com/interactive/2024/02/22/realestate/hudson-ny-home.html",
                media: [
                    ArticleMedia(
                        type: "image",
                        subtype: "",
                        caption: "Chip Roberts and Debbi Calton-Roberts in Hudson, N.Y., where they recently bought a home. With a budget of $600,000, the couple wanted a house with a first-floor bedroom, a yard for a chicken coop and an easy walk to Hudson’s main drag.",
                        copyright: "Tony Cenicola/The New York Times",
                        mediaMetadata: [
                            ArticleMediaMetadata(
                                urlString: "https://static01.nyt.com/images/2024/02/25/multimedia/22hunt-roberts-portrait-fgmt/22hunt-roberts-portrait-fgmt-thumbStandard.jpg",
                                format: .small,
                                height: 75,
                                width: 75
                            ),
                            ArticleMediaMetadata(
                                urlString: "https://static01.nyt.com/images/2024/02/25/multimedia/22hunt-roberts-portrait-fgmt/22hunt-roberts-portrait-fgmt-mediumThreeByTwo210.jpg",
                                format: .medium,
                                height: 140,
                                width: 210
                            ),
                            ArticleMediaMetadata(
                                urlString: "https://static01.nyt.com/images/2024/02/25/multimedia/22hunt-roberts-portrait-fgmt/22hunt-roberts-portrait-fgmt-mediumThreeByTwo440.jpg",
                                format: .big,
                                height: 293,
                                width: 440
                            )
                        ]
                    )
                ]
            ),
            Article(
                id: 100000009298922,
                title: "She Wanted an R.V. He Wanted a Sailboat. This Was Their Compromise.",
                byline: "By Tim McKeough",
                publishedDate: "2024-02-23",
                abstract: "Instead of rolling down roads, their motorboat floats down rivers — and it’s as cozy as a woodland cabin. Think of it as a floating R.V.",
                url: "https://www.nytimes.com/2024/02/23/realestate/rv-sailboat-motorboat.html",
                media: [
                    ArticleMedia(
                        type: "image",
                        subtype: "photo",
                        caption: "",
                        copyright: "Chris Mottalini",
                        mediaMetadata: [
                            ArticleMediaMetadata(
                                urlString: "https://static01.nyt.com/images/2024/02/25/realestate/23small-boat-slide-JUA0/23small-boat-slide-JUA0-thumbStandard.jpg",
                                format: .small,
                                height: 75,
                                width: 75
                            ),
                            ArticleMediaMetadata(
                                urlString: "https://static01.nyt.com/images/2024/02/25/realestate/23small-boat-slide-JUA0/23small-boat-slide-JUA0-mediumThreeByTwo210.jpg",
                                format: .medium,
                                height: 140,
                                width: 210
                            ),
                            ArticleMediaMetadata(
                                urlString: "https://static01.nyt.com/images/2024/02/25/realestate/23small-boat-slide-JUA0/23small-boat-slide-JUA0-mediumThreeByTwo440.jpg",
                                format: .big,
                                height: 293,
                                width: 440
                            )
                        ]
                    )
                ]
            )
        ]
        completionHandler(.success(articles))
    }
    
    public func save(
        mostPopularArticles: MostPopularArticles,
        forPath: MostPopularArticles.Path,
        period: MostPopularArticles.Period
    ) throws {
        print("Try to save activities into fake disk...")
        print("  simulating save action...")
        print("  ALL ACTIVITIES SAVED!")
    }
}
