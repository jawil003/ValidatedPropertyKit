//
//  Validation+Collection.swift
//  ValidatedPropertyKit
//
//  Created by Sven Tiigi on 21.11.20.
//  Copyright © 2020 Sven Tiigi. All rights reserved.
//

import Foundation
import SwiftUI

// MARK: - Validation+Collection

public extension Validation where Value: Collection {
    
    /// The isEmpty Validation
    static func isEmpty(message: LocalizedStringKey? = nil) -> Self {
        .init (predicate: { value in
            value.isEmpty
        }, message: message)
    }
    
    /// Validation with RangeExpression
    /// - Parameter range: The RangeExpression
    static func range<R: RangeExpression>(
        _ range: R, message: LocalizedStringKey? = nil
    ) -> Self where R.Bound == Int {
        .init (predicate: { value in
            range.contains(value.count)
        }, message: message)
    }
    
}
