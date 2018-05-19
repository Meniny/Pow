//
//  PowAttributes.swift
//  Pow
//
//  Created by Elias Abel on 4/19/18.
//  Copyright (c) 2018 Meniny Lab. All rights reserved.
//

import Foundation
import UIKit

public struct PowAttributes {
    
    /** Init with default attributes */
    public init() {}
    
    // MARK: Display Attributes
    
    /** Entry presentation window level */
    public var windowLevel = WindowLevel.statusBar
    
    /** The position of the pow inside the screen */
    public var position = Position.top

    /** The display priority of the pow. *.max* is the highest. *.min* is lowest */
    public var displayPriority = DisplayPriority.normal
    
    /** Describes how long the pow is displayed before it is dismissed */
    public var displayDuration: DisplayDuration = 2 // Use .infinity for infinate duration
    
    /** The frame attributes of the pow */
    public var positionConstraints = PositionConstraints()
    
    // MARK: User Interaction Attributes
    
    /** Describes what happens when the user interacts the screen,
     forwards the touch to the application window by default */
    public var screenInteraction = UserInteraction.forward
    
    /** Describes what happens when the user interacts the pow,
     dismisses the content by default */
    public var powInteraction = UserInteraction.dismiss

    /** Describes the scrolling behaviour of the pow.
     The pow can be swiped out and in with an ability to spring back with a jolt */
    public var scroll = Scroll.enabled(swipeable: true, pullbackAnimation: .jolt)
    
    /** Generate haptic feedback once the pow is displayed */
    public var hapticFeedbackType = NotificationHapticFeedback.none
    
    // MARK: Theme & Style Attributes
    
    /** Describes the pow's background appearance while it shows */
    public var powBackground = BackgroundStyle.clear
    
    /** Describes the background appearance while the pow shows */
    public var screenBackground = BackgroundStyle.clear
    
    /** The shadow around the pow */
    public var shadow = Shadow.none
    
    /** The corner attributes */
    public var roundCorners = RoundCorners.none
    
    /** The border around the pow */
    public var border = Border.none
    
    /** Preferred status bar style while the pow shows */
    public var statusBarStyle: UIStatusBarStyle!
    
    // MARK: Animation Attributes
    
    /** Describes how the pow animates in */
    public var entranceAnimation = Animation.translation
    
    /** Describes how the pow animates out */
    public var exitAnimation = Animation.translation
    
    /** Describes the previous pow behaviour when a new pow with higher display-priority shows */
    public var popBehavior = PopBehavior.animated(animation: .translation)
}
