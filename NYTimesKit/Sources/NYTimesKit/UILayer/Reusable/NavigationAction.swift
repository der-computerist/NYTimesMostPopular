//
//  NavigationAction.swift
//  
//
//  Created by Enrique Aliaga on 17/02/24.
//

import Foundation

public enum NavigationAction<ViewModelType>: Equatable where ViewModelType: Equatable {
    
    case present(view: ViewModelType)
    case presented(view: ViewModelType)
}
