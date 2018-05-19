//
//  PowPopUpMessage.swift
//  Pow
//
//  Created by Elias Abel on 4/21/18.
//  Copyright (c) 2018 Meniny Lab. All rights reserved.
//

import UIKit
import PapaLayout

public struct PowPopUpMessage {
    
    /** Code block that is executed as the user taps the popup button */
    public typealias PowPopUpMessageAction = () -> ()
    
    /** Position of the top image */
    public enum ImagePosition {
        case topToTop(offset: CGFloat)
        case centerToTop(offset: CGFloat)
    }
    
    public var title: PowProperty.LabelContent
    public var description: PowProperty.LabelContent
    public var button: PowProperty.ButtonContent
    public var topImage: PowProperty.ImageContent
    public var imagePosition: ImagePosition
    public var action: PowPopUpMessageAction
    
    public init(topImage: PowProperty.ImageContent, imagePosition: ImagePosition = .topToTop(offset: 40), title: PowProperty.LabelContent, description: PowProperty.LabelContent, button: PowProperty.ButtonContent, action: @escaping PowPopUpMessageAction) {
        self.topImage = topImage
        self.imagePosition = imagePosition
        self.title = title
        self.description = description
        self.button = button
        self.action = action
    }
}
