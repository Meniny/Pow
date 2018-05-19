//
//  PowAttributes+Position.swift
//  Pow
//
//  Created by Elias Abel on 4/21/18.
//  Copyright (c) 2018 Meniny Lab. All rights reserved.
//

import Foundation

public extension PowAttributes {

    /** The position of the pow. */
    public enum Position {
        
        /** The pow appears at the top of the screen. */
        case top
        
        /** The pow appears at the bottom of the screen. */
        case bottom
        
        /** The pow appears at the center of the screen. */
        case center
        
        public var isTop: Bool {
            return self == .top
        }
        
        public var isCenter: Bool {
            return self == .center
        }
        
        public var isBottom: Bool {
            return self == .bottom
        }
    }
}
