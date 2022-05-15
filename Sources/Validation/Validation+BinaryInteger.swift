//
//  Validation+BinaryInteger.swift
//  ValidatedPropertyKit
//
//  Created by Sven Tiigi on 05.01.21.
//  Copyright © 2021 Sven Tiigi. All rights reserved.
//

import Foundation
import SwiftUI

// MARK: - Validation+BinaryInteger

public extension Validation where Value: BinaryInteger {
    
    /// Validation that validates if thie value is a multiple of the given value
    /// - Parameter other: The other Value
    static func isMultiple(
        of other: Value, message: LocalizedStringKey? = nil
    ) -> Self {
        .init (predicate: { value in
            value.isMultiple(of: other)
        }, message: message)
    }
    
}
