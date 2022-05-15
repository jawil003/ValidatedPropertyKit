//
//  File.swift
//  
//
//  Created by Jannik Will on 15.05.22.
//

import Foundation
import Combine

public struct ValidatedPrimitive<Value> {
    
    public var wrappedValue: Value {
        didSet {
            self.isValid = self.validate(value: self.wrappedValue)
            self.onChange?(self.isValid, self.errorValidations)
        }
    }
    public var isValid: Bool
    
    private var validations: [Validation<Value>] = []
    public var errorValidations: [Validation<Value>] = []
    
    public var onChange: ((Bool, [Validation<Value>])-> Void)?
    
    public init(
        wrappedValue: Value,
        _ validation: Validation<Value>,
        onChange: ((Bool, [Validation<Value>])-> Void)? = nil
        
    ) {
        self.wrappedValue = wrappedValue
        self.validations = [validation]
        self.isValid = true
        self.onChange = onChange
        self.isValid = validate(value: wrappedValue)
       
    }
    
    public init(wrappedValue: Value, _ validations: [Validation<Value>], onChange: ((Bool, [Validation<Value>])-> Void)? = nil) {
        self.wrappedValue = wrappedValue
        self.validations = validations
        self.isValid = true
        self.onChange = onChange
        self.isValid = validate(value: wrappedValue)
    }
    
    public mutating func validate(value: Value) -> Bool {
        var valid = true
        
        for v in validations {
            let localValid = v.isValid(value: value)
            
            if !localValid {
                errorValidations.append(v)
            }
            
            valid = localValid
        }
        
        return valid
    }
}
