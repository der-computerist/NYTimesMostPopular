//
//  MostPopularArticlesViewController.swift
//  
//
//  Created by Enrique Aliaga on 17/02/24.
//

import UIKit
import NYTimesUIKit
import NYTimesKit
import Combine

public class MostPopularArticlesViewController: NiblessViewController {
    
    // MARK: - Properties
    // State
    private var subscriptions = Set<AnyCancellable>()
    
    // View Model
    let viewModel: MostPopularArticlesViewModel
    
    // Root View
    var rootView: MostPopularArticlesRootView {
        view as! MostPopularArticlesRootView
    }
    
    // Bar Button Items
    private lazy var changePathButtonItem: UIBarButtonItem = {
        let mostViewed = UIAction(
            title: Constants.mostViewedOptionText,
            image: UIImage(systemName: Constants.mostViewedOptionImage)
        ) { [weak self] _ in
            self?.viewModel.update(path: .mostViewed)
        }
        
        let mostShared = UIAction(
            title: Constants.mostSharedOptionText,
            image: UIImage(systemName: Constants.mostSharedOptionImage)
        ) { [weak self] _ in
            self?.viewModel.update(path: .mostShared)
        }
        
        let mostEmailed = UIAction(
            title: Constants.mostEmailedOptionText,
            image: UIImage(systemName: Constants.mostEmailedOptionImage)
        ) { [weak self] _ in
            self?.viewModel.update(path: .mostEmailed)
        }
            
        let options = UIMenu(options: .displayInline,
                             children: [mostViewed, mostShared, mostEmailed])
        let buttonItem = UIBarButtonItem(menu: options)
        buttonItem.changesSelectionAsPrimaryAction = true
        return buttonItem
    }()

    private lazy var changePeriodButtonItem: UIBarButtonItem = {
        let today = UIAction(
            title: Constants.todayOptionText,
            image: UIImage(systemName: Constants.todayOptionImage)
        ) { [weak self] _ in
            self?.viewModel.update(period: .oneDay)
        }
        
        let lastWeek = UIAction(
            title: Constants.lastWeekOptionText,
            image: UIImage(systemName: Constants.lastWeekOptionImage)
        ) { [weak self] _ in
            self?.viewModel.update(period: .sevenDays)
        }
        
        let lastMonth = UIAction(
            title: Constants.lastMonthOptionText,
            image: UIImage(systemName: Constants.lastMonthOptionImage)
        ) { [weak self] _ in
            self?.viewModel.update(period: .thirtyDays)
        }
        
        let options = UIMenu(options: .displayInline,
                             children: [today, lastWeek, lastMonth])
        let buttonItem = UIBarButtonItem(menu: options)
        buttonItem.changesSelectionAsPrimaryAction = true
        return buttonItem
    }()
    
    // MARK: - Methods
    init(viewModel: MostPopularArticlesViewModel) {
        self.viewModel = viewModel
        super.init()
        bindViewModelToTitle()
        navigationItem.leftBarButtonItem = changePathButtonItem
        navigationItem.rightBarButtonItem = changePeriodButtonItem
    }
    
    public override func loadView() {
        view = MostPopularArticlesRootView(viewModel: viewModel)
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        observeErrorMessages()
    }
    
    private func bindViewModelToTitle() {
        viewModel
            .$path
            .receive(on: DispatchQueue.main)
            .sink { [weak self] path in
                switch path {
                case .mostViewed:
                    self?.navigationItem.title = Constants.mostViewedViewControllerTitle
                case .mostShared:
                    self?.navigationItem.title = Constants.mostSharedViewControllerTitle
                case .mostEmailed:
                    self?.navigationItem.title = Constants.mostEmailedViewControllerTitle
                }
            }
            .store(in: &subscriptions)
    }
    
    func observeErrorMessages() {
        viewModel
            .errorMessages
            .receive(on: DispatchQueue.main)
            .sink { [weak self] errorMessage in
                self?.routePresentation(forErrorMessage: errorMessage)
            }
            .store(in: &subscriptions)
    }
    
    func routePresentation(forErrorMessage errorMessage: ErrorMessage) {
        if let presentedViewController = presentedViewController {
            presentedViewController.present(
                errorMessage: errorMessage,
                withPresentationState: viewModel.errorPresentation
            )
        } else {
            present(errorMessage: errorMessage, withPresentationState: viewModel.errorPresentation)
        }
    }
}

// MARK: - Constants
extension MostPopularArticlesViewController {
    
    struct Constants {
        static let mostViewedViewControllerTitle = "Most Viewed Articles"
        static let mostSharedViewControllerTitle = "Most Shared Articles"
        static let mostEmailedViewControllerTitle = "Most Emailed Articles"
        
        static let mostViewedOptionText = "Most viewed"
        static let mostViewedOptionImage = "eye"
        static let mostSharedOptionText = "Most shared"
        static let mostSharedOptionImage = "square.and.arrow.up"
        static let mostEmailedOptionText =  "Most emailed"
        static let mostEmailedOptionImage = "mail"
        
        static let todayOptionText = "Today"
        static let todayOptionImage = "1.square"
        static let lastWeekOptionText = "Last week"
        static let lastWeekOptionImage = "7.square"
        static let lastMonthOptionText = "Last month"
        static let lastMonthOptionImage = "30.square"
    }
}
