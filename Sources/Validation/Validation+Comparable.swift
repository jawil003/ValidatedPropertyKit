//
//  Validation+Comparable.swift
//  ValidatedPropertyKit
//
//  Created by Sven Tiigi on 21.11.20.
//  Copyright © 2020 Sven Tiigi. All rights reserved.
//

import Foundation
import SwiftUI

// MARK: - Validation+Comparable

public extension Validation where Value: Comparable {
    
    /// Validation with less `<` than comparable value
    /// - Parameter comparableValue: The Comparable value
    static func less(
        _ comparableValue: Value, message: LocalizedStringKey? = nil
    ) -> Self {
        .init (predicate: { value in
            value < comparableValue
        }, message: message)
    }
    
    /// Validation with less or equal `<=` than comparable value
    /// - Parameter comparableValue: The Comparable value
    static func lessOrEqual(
        _ comparableValue: Value, message: LocalizedStringKey? = nil
    ) -> Self {
        .init (predicate: { value in
            value <= comparableValue
        }, message: message)
    }
    
    /// Validation with greater `>` than comparable value
    /// - Parameter comparableValue: The Comparable value
    static func greater(
        _ comparableValue: Value, message: LocalizedStringKey? = nil
    ) -> Self {
        .init (predicate: { value in
            value > comparableValue
        }, message: message)
    }
    
    /// Validation with greater or equal `>=` than comparable value
    /// - Parameter comparableValue: The Comparable value
    static func greaterOrEqual(
        _ comparableValue: Value, message: LocalizedStringKey? = nil
    ) -> Self {
        .init (predicate: { value in
            value >= comparableValue
        }, message: message)
    }
    
}
