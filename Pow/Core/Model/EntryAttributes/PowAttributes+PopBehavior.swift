//
//  PowAttributes+PopBehavior.swift
//  Pow
//
//  Created by Elias Abel on 4/26/18.
//

import Foundation

extension PowAttributes {
    
    /** Describes the pow behavior when a new pow shows (with equal or higher display-priority) */
    public enum PopBehavior {
        
        /** The pow disappears promptly (Does not animates out) when a new one shows */
        case overriden
        
        /** Animate the pow out - The pow rolls out when a new one shows */
        case animated(animation: Animation)
        
        public var isOverriden: Bool {
            switch self {
            case .overriden:
                return true
            default:
                return false
            }
        }
    }
}
