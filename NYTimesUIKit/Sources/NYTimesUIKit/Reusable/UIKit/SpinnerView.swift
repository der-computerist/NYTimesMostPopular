//
//  SpinnerView.swift
//  
//
//  Created by Enrique Aliaga on 21/02/24.
//

import UIKit

public class SpinnerView: NiblessView {
    
    // MARK: - Properties
    let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.color = .white
        return indicator
    }()
    
    // MARK: - Methods
    public override func didMoveToWindow() {
        backgroundColor = Color.loadingScreen
        
        activityIndicator.startAnimating()
        addSubview(activityIndicator)
        activateConstraints()
    }
    
    private func activateConstraints() {
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        activityIndicator.centerXAnchor
            .constraint(equalTo: centerXAnchor)
            .isActive = true
        activityIndicator.centerYAnchor
            .constraint(equalTo: centerYAnchor)
            .isActive = true
    }
}
