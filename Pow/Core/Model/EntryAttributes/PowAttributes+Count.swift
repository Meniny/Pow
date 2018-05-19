//
//  PowAttributes+Count.swift
//  Pow
//
//  Created by Elias Abel on 4/22/18.
//

import Foundation

extension PowAttributes {
    
    /** Counts the active entries. When 0, no pow is presented. */
    static var count: UInt = 0
    
    /** *true* when at least 1 pow is presented */
    static var isDisplaying: Bool {
        return count > 0
    }
}
