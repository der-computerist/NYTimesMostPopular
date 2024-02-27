//
//  ArticleDetailViewController.swift
//  
//
//  Created by Enrique Aliaga on 17/02/24.
//

import UIKit
import NYTimesUIKit
import NYTimesKit

public class ArticleDetailViewController: NiblessViewController {
    
    // MARK: - Properties
    // View Model
    let viewModel: ArticleDetailViewModel
    
    // Root View
    var rootView: ArticleDetailRootView {
        view as! ArticleDetailRootView
    }
    
    // MARK: - Methods
    public init(viewModel: ArticleDetailViewModel) {
        self.viewModel = viewModel
        super.init()
        navigationItem.title = Constants.viewControllerTitle
    }
    
    public override func loadView() {
        view = ArticleDetailRootView(viewModel: viewModel)
    }
}

// MARK: - Constants
extension ArticleDetailViewController {
    
    struct Constants {
        static let viewControllerTitle = "Article Details"
    }
}
