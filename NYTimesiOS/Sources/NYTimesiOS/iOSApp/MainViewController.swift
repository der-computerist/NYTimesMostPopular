//
//  MainViewController.swift
//  
//
//  Created by Enrique Aliaga on 17/02/24.
//

import UIKit
import NYTimesUIKit
import NYTimesKit
import Combine

public class MainViewController: NiblessNavigationController {
    
    // MARK: - Properties
    // View Model
    let viewModel: MainViewModel
    
    // Child view controllers
    let mostPopularArticlesViewController: MostPopularArticlesViewController
    var articleDetailViewController: ArticleDetailViewController?
    
    // State
    var subscriptions = Set<AnyCancellable>()
    
    // Factories
    let makeArticleDetailViewController: (Article) -> ArticleDetailViewController
    
    // MARK: - Methods
    public init(viewModel: MainViewModel,
                mostPopularArticlesViewController: MostPopularArticlesViewController,
                articleDetailViewControllerFactory: @escaping (Article) -> ArticleDetailViewController) {
        self.viewModel = viewModel
        self.mostPopularArticlesViewController = mostPopularArticlesViewController
        self.makeArticleDetailViewController = articleDetailViewControllerFactory
        super.init()
        self.delegate = self
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        observeViewModel()
    }
    
    func subscribe(to publisher: AnyPublisher<MainNavigationAction, Never>) {
        publisher
            .receive(on: DispatchQueue.main)
            .removeDuplicates()
            .sink { [weak self] action in
                guard let strongSelf = self else { return }
                strongSelf.respond(to: action)
            }
            .store(in: &subscriptions)
    }
    
    func respond(to navigationAction: MainNavigationAction) {
        switch navigationAction {
        case let .present(view):
            present(view: view)
        case .presented:
            break
        }
    }
    
    func present(view: MainView) {
        switch view {
        case .mostPopularArticles:
            presentMostPopularArticles()
        case let .articleDetail(article):
            presentArticleDetail(for: article)
        }
    }
    
    func presentMostPopularArticles() {
        pushViewController(mostPopularArticlesViewController, animated: false)
    }
    
    func presentArticleDetail(for article: Article) {
        let articleDetailViewControllerToPresent = makeArticleDetailViewController(article)
        self.articleDetailViewController = articleDetailViewControllerToPresent
        pushViewController(articleDetailViewControllerToPresent, animated: true)
    }
    
    private func observeViewModel() {
        let navigationActionPublisher = viewModel.$navigationAction.eraseToAnyPublisher()
        subscribe(to: navigationActionPublisher)
    }
}

// MARK: - UINavigationControllerDelegate
extension MainViewController: UINavigationControllerDelegate {
    
    public func navigationController(
        _ navigationController: UINavigationController,
        didShow viewController: UIViewController,
        animated: Bool
    ) {
        guard let shownView = mainView(associatedWith: viewController) else { return }
        viewModel.uiPresented(mainView: shownView)
    }
}

extension MainViewController {
    
    func mainView(associatedWith viewController: UIViewController) -> MainView? {
        switch viewController {
        case is MostPopularArticlesViewController:
            return .mostPopularArticles
        case let vc as ArticleDetailViewController:
            return .articleDetail(article: vc.viewModel.article)
        default:
            assertionFailure("Encountered unexpected child view controller type in MainViewController")
            return nil
        }
    }
}
