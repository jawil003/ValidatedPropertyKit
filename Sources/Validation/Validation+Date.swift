//
//  File.swift
//  
//
//  Created by Jannik Will on 15.05.22.
//

import Foundation
import SwiftUI

public extension Validation where Value == Date {
    
    static func isFuture(message: LocalizedStringKey? = nil) -> Self {
        .init(predicate: { value in
            value > Date()
        }, message: message)
    }
    
    static func isFutureDate(message: LocalizedStringKey? = nil) -> Self {
        .init(predicate: { value in
            let order = Calendar.current.compare(value, to: Date(), toGranularity: .day)
            return order == .orderedAscending
        }, message: message)
    }
    
    static func isPast(message: LocalizedStringKey? = nil) -> Self {
        .init(predicate: { value in
            value < Date()
        }, message: message)
    }
    
    static func isPastDate(message: LocalizedStringKey? = nil) -> Self {
        .init(predicate: { value in
            let order = Calendar.current.compare(value, to: Date(), toGranularity: .day)
            return order == .orderedDescending
        }, message: message)
    }
    
    static func isCurrent(message: LocalizedStringKey? = nil) -> Self {
        .init(predicate: { value in
            value == Date()
        }, message: message)
    }
    
    static func isCurrentDate(message: LocalizedStringKey? = nil) -> Self {
        .init(predicate: { value in
            let order = Calendar.current.compare(value, to: Date(), toGranularity: .day)
            return order == .orderedSame
        }, message: message)
    }
    
}
