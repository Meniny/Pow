//
//  PowAttributes+FrameStyle.swift
//  Pow
//
//  Created by Elias Abel on 4/28/18.
//

import Foundation

extension PowAttributes {
    
    /** Corner radius of the pow - Specifies the corners */
    public enum RoundCorners {
        
        /** *None* of the corners will be round */
        case none
        
        /** *All* of the corners will be round */
        case all(radius: CGFloat)
        
        /** Only the *top* left and right corners will be round */
        case top(radius: CGFloat)
        
        /** Only the *bottom* left and right corners will be round */
        case bottom(radius: CGFloat)
        
        var hasRoundCorners: Bool {
            switch self {
            case .none:
                return false
            default:
                return true
            }
        }
        
        var cornerValues: (value: UIRectCorner, radius: CGFloat)? {
            switch self {
            case .all(radius: let radius):
                return (value: .allCorners, radius: radius)
            case .top(radius: let radius):
                return (value: .top, radius: radius)
            case .bottom(radius: let radius):
                return (value: .bottom, radius: radius)
            case .none:
                return nil
            }
        }
    }
    
    /** The border around the pow */
    public enum Border {
        
        /** No border */
        case none
        
        /** Border wirh color and width */
        case value(color: UIColor, width: CGFloat)
        
        var hasBorder: Bool {
            switch self {
            case .none:
                return false
            default:
                return true
            }
        }
        
        var borderValues: (color: UIColor, width: CGFloat)? {
            switch self {
            case .value(color: let color, width: let width):
                return(color: color, width: width)
            case .none:
                return nil
            }
        }
    }
}
