//
//  DateExtensions.swift
//  
//
//  Created by Enrique Aliaga on 21/02/24.
//

import Foundation

public extension Date {

    func toString(withFormat format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.calendar = Calendar(identifier: .gregorian)
        dateFormatter.amSymbol = "AM"
        dateFormatter.pmSymbol = "PM"
        dateFormatter.dateFormat = format
        let dateString = dateFormatter.string(from: self)

        return dateString
    }
}

public extension String {

    func toDate(withFormat format: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.calendar = Calendar(identifier: .gregorian)
        dateFormatter.dateFormat = format
        let date = dateFormatter.date(from: self)
        return date
    }
}
