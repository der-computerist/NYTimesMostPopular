//
//  NiblessTableViewCell.swift
//  
//
//  Created by Enrique Aliaga on 20/02/24.
//

import UIKit

open class NiblessTableViewCell: UITableViewCell {
    
    // MARK: - Methods
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    @available(*, unavailable,
        message: "Loading this view from a nib is unsupported in favor of a programmatic approach."
    )
    public required init?(coder: NSCoder) {
        fatalError("Loading this view from a nib is unsupported in favor of a programmatic approach.")
    }
}
