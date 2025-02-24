//
//  Validation+String.swift
//  ValidatedPropertyKit
//
//  Created by Sven Tiigi on 21.11.20.
//  Copyright © 2020 Sven Tiigi. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI

// MARK: - Validation+String

public extension Validation where Value == String {
    
    /// Validation if a given String is a valid mail address
    static func isEmail(message: LocalizedStringKey? = nil) -> Self {
        .init (predicate: { value in
            // Initialize NSDataDetector with link checking type
            let detector = try? NSDataDetector(
                types: NSTextCheckingResult.CheckingType.link.rawValue
            )
            // Initialize Range from value
            let range = NSRange(
                value.startIndex..<value.endIndex,
                in: value
            )
            // Retrieve matches from value
            let matches = detector?.matches(
                in: value,
                options: [],
                range: range
            )
            // Verify first Match is available
            guard let match = matches?.first else {
                // Otherwise return false
                return false
            }
            // Return bool value if match URL scheme is `mailto` and range matches
            return match.url?.scheme == "mailto" && match.range == range
        }, message: message)
    }
    
}

// MARK: - Validation+StringProtocol

public extension Validation where Value: StringProtocol {
    
    /// Validation with contains String
    /// - Parameters:
    ///   - string: The String that should be contained
    ///   - options: The String ComparisonOptions. Default value `.init`
    static func contains<S: StringProtocol>(
        _ string: S,
        options: NSString.CompareOptions = .init(), message: LocalizedStringKey? = nil
    ) -> Self {
        .init (predicate: { value in
            value.range(of: string, options: options) != nil
        }, message: message)
    }
    
    /// Validation with has prefix
    /// - Parameter prefix: The prefix
    static func hasPrefix<S: StringProtocol>(
        _ prefix: S, message: LocalizedStringKey? = nil
    ) -> Self {
        .init (predicate: { value in
            value.hasPrefix(prefix)
        }, message: message)
    }
    
    /// Validation with has suffix
    /// - Parameter suffix: The suffix
    static func hasSuffix<S: StringProtocol>(
        _ suffix: S, message: LocalizedStringKey? = nil
    ) -> Self {
        .init (predicate: { value in
            value.hasSuffix(suffix)
        }, message: message)
    }
    
}

// MARK: - Validation+String

public extension Validation where Value == String {
    
    /// Validation with RegularExpression
    /// - Parameters:
    ///   - regularExpression: The NSRegularExpression
    ///   - matchingOptions: The NSRegularExpression.MatchingOptions. Default value `.init`
    static func regularExpression(
        _ regularExpression: NSRegularExpression,
        matchingOptions: NSRegularExpression.MatchingOptions = .init(),
        message: LocalizedStringKey? = nil
    ) -> Self {
        .init (predicate: { value in
            regularExpression.firstMatch(
                in: value,
                options: matchingOptions,
                range: .init(value.startIndex..., in: value)
            ) != nil
        }, message: message)
    }
    
    /// Validation with RegularExpression Pattern
    /// - Parameters:
    ///   - pattern: The RegularExpression Pattern
    ///   - onInvalidPatternValidation: The Validation that should be used when the pattern is invalid. Default value `.constant(false)`
    ///   - matchingOptions: The NSRegularExpression.MatchingOptions. Default value `.init`
    static func regularExpression(
        _ pattern: String,
        onInvalidPatternValidation: @autoclosure @escaping () -> Validation<Void> = .constant(false),
        matchingOptions: NSRegularExpression.MatchingOptions = .init(),
        message: LocalizedStringKey? = nil
    ) -> Self {
        do {
            return self.regularExpression(
                try NSRegularExpression(pattern: pattern),
                matchingOptions: matchingOptions,
                message: message
            )
        } catch {
            return .init (predicate: { _ in
                onInvalidPatternValidation().isValid(value: ())
            }, message: message)
        }
    }
    
}
