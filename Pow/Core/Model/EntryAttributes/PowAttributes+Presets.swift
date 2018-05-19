//
//  PowAttributes+Presets.swift
//  Pow
//
//  Created by Elias Abel on 4/23/18.
//

import Foundation

public extension PowAttributes {
    
    /** Default attributes - Can be mutated according to the hosting application theme */
    public static var `default` = PowAttributes()
    
    /** Toast preset - The frame fills margins and safe area is filled with background view */
    public static var toast: PowAttributes {
        var attributes = PowAttributes()
        attributes.positionConstraints = .full
        attributes.positionConstraints.safeArea = .empty(fillSafeArea: true)
        attributes.windowLevel = .statusBar
        attributes.scroll = .edgeCrossingDisabled(swipeable: true)
        attributes.popBehavior = .animated(animation: .translation)
        return attributes
    }
    
    /** Float preset - The frame is margined and the safe area is left cleared */
    public static var float: PowAttributes {
        var attributes = PowAttributes()
        attributes.positionConstraints = .float
        attributes.roundCorners = .all(radius: 10)
        attributes.positionConstraints.safeArea = .empty(fillSafeArea: false)
        attributes.windowLevel = .statusBar
        return attributes
    }
    
    /** Preset for top float pow */
    public static var topFloat: PowAttributes {
        var attributes = float
        attributes.position = .top
        return attributes
    }
    
    /** Preset for a bottom float pow */
    public static var bottomFloat: PowAttributes {
        var attributes = float
        attributes.position = .bottom
        return attributes
    }
    
    /** Preset for a center float pow */
    public static var centerFloat: PowAttributes {
        var attributes = float
        attributes.position = .center
        return attributes
    }
    
    /** Preset for a bottom toast pow */
    public static var bottomToast: PowAttributes {
        var attributes = toast
        attributes.position = .bottom
        return attributes
    }
    
    /** Preset for a top toast pow */
    public static var topToast: PowAttributes {
        var attributes = toast
        attributes.position = .top
        return attributes
    }
    
    /** Preset for a top note pow */
    public static var topNote: PowAttributes {
        var attributes = topToast
        attributes.scroll = .disabled
        attributes.windowLevel = .normal
        attributes.powInteraction = .absorbTouches
        return attributes
    }
    
    /** Preset for a bottom note pow */
    public static var bottomNote: PowAttributes {
        var attributes = bottomToast
        attributes.scroll = .disabled
        attributes.windowLevel = .normal
        attributes.powInteraction = .absorbTouches
        return attributes
    }
    
    /** Preset for a status bar pow - appears on top of the status bar */
    public static var statusBar: PowAttributes {
        var attributes = topToast
        attributes.windowLevel = .statusBar
        attributes.powInteraction = .absorbTouches
        attributes.positionConstraints.safeArea = .overriden
        return attributes
    }
}
