//
//  UIView+Overlay.swift
//  
//
//  Created by Enrique Aliaga on 22/02/24.
//

import UIKit

public extension UIView {
    
    func add(overlay: UIView?) {
        guard let overlay = overlay else {
            return
        }

        addSubview(overlay)
        
        overlay.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            overlay.leadingAnchor.constraint(equalTo: leadingAnchor),
            overlay.trailingAnchor.constraint(equalTo: trailingAnchor),
            overlay.topAnchor.constraint(equalTo: topAnchor),
            overlay.bottomAnchor.constraint(equalTo: bottomAnchor)
        ]
        constraints.forEach { $0.isActive = true }
        addConstraints(constraints)
    }
    
    func remove(overlay: UIView?) {
        guard let overlay = overlay else {
            return
        }
        
        guard overlay.superview != nil else {
            return
        }
        
        overlay.removeFromSuperview()
    }
}
