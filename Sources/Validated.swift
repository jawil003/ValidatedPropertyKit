//
//  Validated.swift
//  ValidatedPropertyKit
//
//  Created by Sven Tiigi on 21.11.20.
//  Copyright © 2020 Sven Tiigi. All rights reserved.
//

import Foundation
import SwiftUI

// MARK: - Validated

/// A Validated PropertyWrapper
@propertyWrapper
public struct Validated<Value>: DynamicProperty, Validatable {
    
    // MARK: Properties
    
    @State public var isValid: Bool = true
    @State private var value: Value
    
    private var validations: [Validation<Value>] = []
    
    @State var errorValidations: [Validation<Value>] = []
    
    // MARK: PropertyWrapper-Properties
    
    /// The projected `Binding<Value>`
    public var projectedValue: Binding<Value> {
        get {
            self._value.projectedValue
        }
        set {
            self._value.wrappedValue = newValue.wrappedValue
        }
    }
    
    /// The wrapped Value
    public var wrappedValue: Value {
        get {
            // Return value
            self.value
        }
        nonmutating set {
            // Update value
            self.value = newValue
            self.isValid = self.validate(value: self.value)
        }
    }
    
    // MARK: Initializer
    
    /// Designated Initializer
    /// - Parameters:
    ///   - wrappedValue: The wrapped `Value`
    ///   - validation: The `Validation`
    public init(
        wrappedValue: Value,
        _ validation: Validation<Value>
    ) {
        self._value = State(wrappedValue: wrappedValue)
        self.validations = [validation]
        self.isValid = validate(value: wrappedValue)
    }
    
    public init(
        wrappedValue: Value,
        _ validations: [Validation<Value>]
    ) {
        self._value = State(wrappedValue: wrappedValue)
        self.validations = validations
        self.isValid = validate(value: wrappedValue)
    }
    
    // MARK: Update Validation
    
    /// Update the Validation
    /// - Parameters:
    ///   - reValidateValue: Bool value if current Value should be revalidated with new Validation. Default value `true`
    ///   - validation: The new Validation
    public mutating func update(
        reValidateValue: Bool = true,
        validations: ([Validation<Value>]) -> [Validation<Value>]
    ) {
        // Update Validation
        self.validations = validations(self.validations)
        // Verify if value should be re-validated
        guard reValidateValue else {
            // Otherwise return out of function
            return
        }
        // Perform Validation
        self.isValid = self.validate(value: self.value)
    }
    
    func validate(value: Value) -> Bool {
        errorValidations = []
        
        var isValid = true
        
        for v in validations {
            let localValid = v.isValid(value: value)
            
            if !localValid {
                errorValidations.append(v)
            }
            
            isValid = localValid
        }
        
        return isValid
    }
    
}

// MARK: - Validated+Optionalable

public extension Validated where Value: Optionalable {
    
    /// Designated Initializer for an optional Value type
    /// - Parameters:
    ///   - wrappedValue: The wrapped `Value`. Default value `nil`
    ///   - validation: The `Validation` for the `Wrapped` value type
    ///   - nilValidation: The `Validation` if the Value  is nil. Default value `.constant(false)`
    init(
        wrappedValue: Value = nil,
        _ validation: Validation<Value.Wrapped>,
        nilValidation: Validation<Void> = .constant(false)
    ) {
        self.init(
            wrappedValue: wrappedValue,
            .init { value in
                value.wrapped.flatMap(validation.isValid)
                    ?? nilValidation.isValid(value: ())
            }
        )
    }
    
}
