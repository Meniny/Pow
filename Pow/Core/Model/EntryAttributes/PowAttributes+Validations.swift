//
//  PowAttributes+Validations.swift
//  Pow
//
//  Created by Elias Abel on 5/18/18.
//

import Foundation

extension PowAttributes {
    
    private static var minDisplayDuration: DisplayDuration {
        return 0
    }
    
    var validateDisplayDuration: Bool {
        guard displayDuration >= PowAttributes.minDisplayDuration else {
            return false
        }
        return true
    }
    
    var validateWindowLevel: Bool {
        return windowLevel.value >= UIWindowLevelNormal
    }
    
    var isValid: Bool {
        return validateDisplayDuration && validateWindowLevel
    }
}
