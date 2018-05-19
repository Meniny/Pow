//
//  PowNotificationMessage.swift
//  Pow
//
//  Created by Elias Abel on 4/20/18.
//  Copyright (c) 2018 Meniny Lab. All rights reserved.
//

import UIKit
import PapaLayout

public struct PowSimpleMessage {
    
    /** The image view descriptor */
    public let image: PowProperty.ImageContent
    
    /** The title label descriptor */
    public let title: PowProperty.LabelContent
    
    /** The description label descriptor */
    public let description: PowProperty.LabelContent
    
    public init(image: PowProperty.ImageContent, title: PowProperty.LabelContent, description: PowProperty.LabelContent) {
        self.image = image
        self.title = title
        self.description = description
    }
}

public struct PowNotificationMessage {
    
    /** Image, Title, Description */
    public let simpleMessage: PowSimpleMessage
    
    /** Optional auxilary label descriptor (For instance, it be used to display time of message) */
    public let auxiliary: PowProperty.LabelContent?
    
    public init(simpleMessage: PowSimpleMessage, auxiliary: PowProperty.LabelContent? = nil) {
        self.simpleMessage = simpleMessage
        self.auxiliary = auxiliary
    }
}

public struct PowAlertMessage {
    
    public enum ImagePosition {
        case top
        case left
    }
    
    /** The position of the image inside the alert */
    public let imagePosition: ImagePosition
    
    /** Image, Title, Description */
    public let simpleMessage: PowSimpleMessage
    
    /** Contents of button bar */
    public let buttonBarContent: PowProperty.ButtonBarContent
        
    public init(simpleMessage: PowSimpleMessage, imagePosition: ImagePosition = .top, buttonBarContent: PowProperty.ButtonBarContent) {
        self.simpleMessage = simpleMessage
        self.imagePosition = imagePosition
        self.buttonBarContent = buttonBarContent
    }
}
