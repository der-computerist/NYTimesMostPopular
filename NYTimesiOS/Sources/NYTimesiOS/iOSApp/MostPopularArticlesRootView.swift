//
//  MostPopularArticlesRootView.swift
//  
//
//  Created by Enrique Aliaga on 17/02/24.
//

import UIKit
import NYTimesUIKit
import NYTimesKit
import Combine

enum CellIdentifier: String {
    case cell
}

class MostPopularArticlesRootView: NiblessView {
    
    // MARK: - Properties
    let viewModel: MostPopularArticlesViewModel
    private var subscriptions = Set<AnyCancellable>()
    
    @Published public private(set) var articles: MostPopularArticles = []
    
    let fetchingArticlesActivityIndicator = SpinnerView()
    
    let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(
            ArticleTableViewCell.self,
            forCellReuseIdentifier: CellIdentifier.cell.rawValue
        )
        return tableView
    }()
    
    // MARK: - Methods
    init(frame: CGRect = .zero,
         viewModel: MostPopularArticlesViewModel) {
        self.viewModel = viewModel
        
        super.init(frame: frame)
        
        addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        
        viewModel
            .$articles
            .receive(on: DispatchQueue.main)
            .assign(to: \.articles, on: self)
            .store(in: &subscriptions)
        
        $articles
            .removeDuplicates()
            .dropFirst()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.tableView.reloadData()
            }
            .store(in: &subscriptions)
        
        bindToActivityIndicatorState()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        tableView.frame = bounds
    }
    
    func bindToActivityIndicatorState() {
        viewModel
            .$fetchingArticles
            .receive(on: DispatchQueue.main)
            .sink { [weak self] fetching in
                guard let strongSelf = self else { return }
                switch fetching {
                case true:
                    strongSelf.add(overlay: strongSelf.fetchingArticlesActivityIndicator)
                case false:
                    strongSelf.remove(overlay: strongSelf.fetchingArticlesActivityIndicator)
                }
            }
            .store(in: &subscriptions)
    }
}

// MARK: - UITableViewDataSource
extension MostPopularArticlesRootView: UITableViewDataSource {
    
    public func tableView(_ _: UITableView, numberOfRowsInSection _: Int) -> Int {
        articles.count
    }
    
    public func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.cell.rawValue)
                as? ArticleTableViewCell
        else {
            preconditionFailure("Cell could not be dequeued nor created." +
                                "Verify the cell reuse identifier.")
        }
        
        let article = articles[indexPath.row]
        cell.article = article
        return cell
    }
}

// MARK: - UITableViewDelegate
extension MostPopularArticlesRootView: UITableViewDelegate {
    
    public func tableView(_ _: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let selectedArticle = articles[indexPath.row]
        viewModel.select(article: selectedArticle)
    }
}
