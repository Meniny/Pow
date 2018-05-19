//
//  PowAttributes+DisplayPriority.swift
//  Pow
//
//  Created by Elias Abel on 4/29/18.
//

import Foundation

fileprivate extension Int {
    var isValidDisplayPriority: Bool {
        return self >= PowAttributes.DisplayPriority.minRawValue && self <= PowAttributes.DisplayPriority.maxRawValue
    }
}

public extension PowAttributes {
 
    /** The display priority of the pow - Determines whether is can be overriden by other entries.
     Must be in range [0...1000] */
    public struct DisplayPriority : Hashable, Equatable, RawRepresentable, Comparable {
        public var rawValue: Int
        
        public var hashValue: Int {
            return rawValue
        }
        
        public init(_ rawValue: Int) {
            assert(rawValue.isValidDisplayPriority, "Display Priority must be in range [\(DisplayPriority.minRawValue)...\(DisplayPriority.maxRawValue)]")
            self.rawValue = rawValue
        }
        
        public init(rawValue: Int) {
            assert(rawValue.isValidDisplayPriority, "Display Priority must be in range [\(DisplayPriority.minRawValue)...\(DisplayPriority.maxRawValue)]")
            self.rawValue = rawValue
        }
        
        public static func == (lhs: DisplayPriority, rhs: DisplayPriority) -> Bool {
            return lhs.rawValue == rhs.rawValue
        }
        
        public static func < (lhs: DisplayPriority, rhs: DisplayPriority) -> Bool {
            return lhs.rawValue < rhs.rawValue
        }
    }
}

/** High priority entries can be overriden by other equal or higher priority entries only.
 Entries are ignored as a higher priority pow is being displayed.
 High priority pow overrides any other pow including another equal priority one.
 You can you on of the values (.max, high, normal, low, min) and also set your own values. */
public extension PowAttributes.DisplayPriority {
    
    public static let maxRawValue = 1000
    public static let highRawValue = 750
    public static let normalRawValue = 500
    public static let lowRawValue = 250
    public static let minRawValue = 0

    /** Max - the highest possible priority of an pow. Can override only entries with *max* priority */
    public static let max = PowAttributes.DisplayPriority(rawValue: maxRawValue)
    public static let high = PowAttributes.DisplayPriority(rawValue: highRawValue)
    public static let normal = PowAttributes.DisplayPriority(rawValue: normalRawValue)
    public static let low = PowAttributes.DisplayPriority(rawValue: lowRawValue)
    public static let min = PowAttributes.DisplayPriority(rawValue: minRawValue)
}

