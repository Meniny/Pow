//
//  PowGradientView.swift
//  Pow
//
//  Created by Elias Abel on 4/20/18.
//  Copyright (c) 2018 Meniny Lab. All rights reserved.
//

import UIKit
import PapaLayout

open class PowGradientView: UIView {
    
    open let gradientLayer = CAGradientLayer()
    
    open var gradient: PowAttributes.BackgroundStyle.Gradient? {
        didSet {
            gradientLayer.colors = gradient?.colors.map { $0.cgColor }
            gradientLayer.startPoint = gradient?.startPoint ?? .zero
            gradientLayer.endPoint = gradient?.endPoint ?? .zero
        }
    }
    
    public init() {
        super.init(frame: .zero)
        layer.addSublayer(gradientLayer)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
    }
}
