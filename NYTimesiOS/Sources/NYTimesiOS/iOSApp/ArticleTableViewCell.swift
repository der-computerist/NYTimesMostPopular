//
//  ArticleTableViewCell.swift
//  
//
//  Created by Enrique Aliaga on 20/02/24.
//

import UIKit
import NYTimesKit
import NYTimesUIKit

public class ArticleTableViewCell: NiblessTableViewCell {
    
    // MARK: - Properties
    var article: Article? {
        didSet {
            titleLabel.text = article?.title
            bylineLabel.text = article?.byline
            dateLabel.text = article?.prettyPublishedDate
            
            if let imageURL = article?.thumbnailURL {
                URLSession.shared.dataTask(with: imageURL) { (data, response, error) in
                    DispatchQueue.main.async {
                        guard let data = data else {
                            self.thumbnailView.image = UIImage(named: "NoImage")
                            return
                        }
                        self.thumbnailView.image = UIImage(data: data)
                    }
                }.resume()
            }
        }
    }
    
    lazy var topLevelStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [textualDataStackView, thumbnailView])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        stackView.spacing = 16.0
        return stackView
    }()
    
    lazy var textualDataStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [dateLabel, titleLabel, bylineLabel])
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.spacing = 8.0
        return stackView
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .caption1)
        label.textAlignment = .left
        return label
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .title2)
        label.textAlignment = .left
        label.numberOfLines = 4
        return label
    }()
    
    let bylineLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .caption1)
        label.textAlignment = .left
        return label
    }()
    
    let thumbnailView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "NoImage")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10.0
        return imageView
    }()
    
    // MARK: - Methods
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        constructHierarchy()
        activateConstraints()
    }
    
    private func constructHierarchy() {
        contentView.addSubview(topLevelStackView)
    }
    
    private func activateConstraints() {
        activateConstraintsTopLevelStackView()
        activateConstraintsThumbnailView()
        activateConstraintsDateLabel()
        activateConstraintsBylineLabel()
    }
    
    private func activateConstraintsTopLevelStackView() {
        topLevelStackView.translatesAutoresizingMaskIntoConstraints = false
        
        let contentViewMargins = contentView.layoutMarginsGuide
        let leading = topLevelStackView.leadingAnchor
            .constraint(equalTo: contentViewMargins.leadingAnchor)
        let trailing = topLevelStackView.trailingAnchor
            .constraint(equalTo: contentViewMargins.trailingAnchor)
        let top = topLevelStackView.topAnchor
            .constraint(equalTo: contentViewMargins.topAnchor)
        let bottom = topLevelStackView.bottomAnchor
            .constraint(equalTo: contentViewMargins.bottomAnchor)
        
        NSLayoutConstraint.activate([leading, trailing, top, bottom])
    }
    
    private func activateConstraintsThumbnailView() {
        thumbnailView.translatesAutoresizingMaskIntoConstraints = false
        
        thumbnailView.widthAnchor
            .constraint(equalTo: thumbnailView.heightAnchor, multiplier: 1.0)
            .isActive = true
    }
    
    private func activateConstraintsDateLabel() {
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        dateLabel.topAnchor
            .constraint(equalTo: topLevelStackView.topAnchor)
            .isActive = true
    }
    
    private func activateConstraintsBylineLabel() {
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        bylineLabel.bottomAnchor
            .constraint(equalTo: topLevelStackView.bottomAnchor)
            .isActive = true
        bylineLabel.setContentCompressionResistancePriority(.required, for: .vertical)
    }
}
