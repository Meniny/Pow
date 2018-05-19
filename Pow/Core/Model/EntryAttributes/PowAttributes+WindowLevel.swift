//
//  PowAttributes+WindowLevel.swift
//  Pow
//
//  Created by Elias Abel on 4/21/18.
//  Copyright (c) 2018 Meniny Lab. All rights reserved.
//

import UIKit

public extension PowAttributes {
    
    /** Describes the window level in which the pow would be displayed */
    public enum WindowLevel {
        
        /** Above the alerts */
        case alerts
        
        /** Above the status bar */
        case statusBar
        
        /** Above the application window */
        case normal
        
        /** Custom level */
        case custom(level: UIWindowLevel)
        
        /** Returns the raw value - the window level itself */
        public var value: UIWindowLevel {
            switch self {
            case .alerts:
                return UIWindowLevelAlert
            case .statusBar:
                return UIWindowLevelStatusBar
            case .normal:
                return UIWindowLevelNormal
            case .custom(level: let level):
                return level
            }
        }
    }
}
