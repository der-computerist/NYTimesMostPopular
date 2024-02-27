//
//  ArticleDetailRootView.swift
//  
//
//  Created by Enrique Aliaga on 17/02/24.
//

import UIKit
import NYTimesUIKit
import NYTimesKit

public class ArticleDetailRootView: NiblessView {
    
    // MARK: - Properties
    let viewModel: ArticleDetailViewModel
    private var hierarchyNotReady = true
    
    lazy var formStackView: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [
                titleStackView,
                bylineStackView,
                publicationDateStackView,
                abstractStackView
            ]
        )
        stackView.axis = .vertical
        stackView.spacing = Metrics.standardSpacing
        return stackView
    }()
    
    lazy var titleStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, titleTextView])
        stackView.axis = .horizontal
        stackView.spacing = Metrics.largeSpacing
        return stackView
    }()
    
    lazy var bylineStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [bylineLabel, bylineField])
        stackView.axis = .horizontal
        stackView.spacing = Metrics.largeSpacing
        return stackView
    }()
    
    lazy var publicationDateStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [publicationDateLabel, publicationDateField])
        stackView.axis = .horizontal
        stackView.spacing = Metrics.largeSpacing
        return stackView
    }()
    
    lazy var abstractStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [abstractLabel, abstractTextView])
        stackView.axis = .horizontal
        stackView.spacing = Metrics.largeSpacing
        stackView.alignment = .top
        return stackView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.titleLabelText
        return label
    }()
    
    let titleTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = UIColor.systemGray6
        textView.font = UIFont.preferredFont(forTextStyle: .footnote)
        textView.isEditable = false
        textView.layer.borderWidth = 1.0
        textView.layer.cornerRadius = 5.0
        textView.layer.borderColor = UIColor.systemGray3.cgColor
        return textView
    }()
    
    let bylineLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.bylineLabelText
        return label
    }()
    
    let bylineField: UITextField = {
        let field = UITextField()
        field.borderStyle = .roundedRect
        field.font = UIFont.preferredFont(forTextStyle: .footnote)
        field.isEnabled = false
        field.setContentHuggingPriority(.defaultLow - 10, for: .horizontal)
        field.setContentCompressionResistancePriority(.defaultHigh - 10, for: .horizontal)
        return field
    }()
    
    let publicationDateLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.publicationDateLabelText
        return label
    }()
    
    let publicationDateField: UITextField = {
        let field = UITextField()
        field.borderStyle = .roundedRect
        field.font = UIFont.preferredFont(forTextStyle: .footnote)
        field.textAlignment = .right
        field.isEnabled = false
        field.setContentHuggingPriority(.defaultLow - 10, for: .horizontal)
        field.setContentCompressionResistancePriority(.defaultHigh - 10, for: .horizontal)
        return field
    }()
    
    let abstractLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.abstractLabelText
        return label
    }()
    
    let abstractTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = UIColor.systemGray6
        textView.font = UIFont.preferredFont(forTextStyle: .footnote)
        textView.isEditable = false
        textView.layer.borderWidth = 1.0
        textView.layer.cornerRadius = 5.0
        textView.layer.borderColor = UIColor.systemGray3.cgColor
        return textView
    }()
    
    // MARK: - Methods
    init(frame: CGRect = .zero,
         viewModel: ArticleDetailViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame)
        bindViewModelToViews()
    }
    
    public override func didMoveToWindow() {
        guard hierarchyNotReady else {
            return
        }
        styleView()
        constructHierarchy()
        activateConstraints()
        hierarchyNotReady = false
    }
    
    private func styleView() {
        backgroundColor = Color.background
        
        // Layout margins
        var customMargins = layoutMargins
        customMargins.top = Metrics.largeSpacing
        layoutMargins = customMargins
    }
    
    private func constructHierarchy() {
        addSubview(formStackView)
    }
    
    private func activateConstraints() {
        activateConstraintsFormStackView()
        activateConstraintsTitleTextView()
        activateConstraintsBylineTextField()
        activateConstraintsAbstractTextView()
    }
    
    private func activateConstraintsFormStackView() {
        formStackView.translatesAutoresizingMaskIntoConstraints = false
        
        let leading = formStackView.leadingAnchor
            .constraint(equalTo: layoutMarginsGuide.leadingAnchor)
        let trailing = formStackView.trailingAnchor
            .constraint(equalTo: layoutMarginsGuide.trailingAnchor)
        let top = formStackView.topAnchor
            .constraint(equalTo: layoutMarginsGuide.topAnchor)
        let height = formStackView.heightAnchor
            .constraint(equalTo: heightAnchor, multiplier: 1.0/3)
        
        NSLayoutConstraint.activate([leading, trailing, top, height])
    }
    
    private func activateConstraintsTitleTextView() {
        titleTextView.translatesAutoresizingMaskIntoConstraints = false
        
        let leading = titleTextView.leadingAnchor
            .constraint(equalTo: abstractTextView.leadingAnchor)
        let height = titleTextView.heightAnchor
            .constraint(equalTo: abstractTextView.heightAnchor, multiplier: 1.0/2)
        
        NSLayoutConstraint.activate([leading, height])
    }
    
    private func activateConstraintsBylineTextField() {
        bylineField.translatesAutoresizingMaskIntoConstraints = false
        
        bylineField.leadingAnchor
            .constraint(equalTo: abstractTextView.leadingAnchor)
            .isActive = true
    }
    
    private func activateConstraintsAbstractTextView() {
        abstractTextView.translatesAutoresizingMaskIntoConstraints = false
        
        abstractTextView.heightAnchor
            .constraint(equalTo: abstractStackView.heightAnchor)
            .isActive = true
    }
}

// MARK: - Dynamic behavior
extension ArticleDetailRootView {
    
    func bindViewModelToViews() {
        titleTextView.text = viewModel.article.title
        bylineField.text = viewModel.article.byline
        publicationDateField.text = viewModel.article.prettyPublishedDate
        abstractTextView.text = viewModel.article.abstract
    }
}

// MARK: - Constants
extension ArticleDetailRootView {
    
    struct Constants {
        static let titleLabelText = "Title"
        static let bylineLabelText = "Byline"
        static let publicationDateLabelText = "Publication Date"
        static let abstractLabelText = "Abstract"
    }
    
    struct Metrics {
        static let standardSpacing = CGFloat(8.0)
        static let largeSpacing = CGFloat(16.0)
    }
}
