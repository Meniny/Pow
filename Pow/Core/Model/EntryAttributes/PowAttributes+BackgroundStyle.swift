//
//  PowAttributes+BackgroundStyle.swift
//  Pow
//
//  Created by Elias Abel on 4/21/18.
//  Copyright (c) 2018 Meniny Lab. All rights reserved.
//

import UIKit

public extension PowAttributes {
    
    /** The background style property */
    public enum BackgroundStyle {
        
        /** Gradient background style */
        public struct Gradient {
            public let colors: [UIColor]
            public let startPoint: CGPoint
            public let endPoint: CGPoint
            
            public init(colors: [UIColor], startPoint: CGPoint, endPoint: CGPoint) {
                self.colors = colors
                self.startPoint = startPoint
                self.endPoint = endPoint
            }
        }
        
        /** Visual Effect (Blurred) background style */
        case visualEffect(style: UIBlurEffectStyle)
        
        /** Color background style */
        case color(color: UIColor)
        
        /** Gradient background style */
        case gradient(gradient: Gradient)
        
        /** Image background style */
        case image(image: UIImage)
        
        /** Clear background style */
        case clear
    }
}
