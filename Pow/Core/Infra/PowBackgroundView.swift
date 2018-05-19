//
//  PowBackgroundView.swift
//  Pow
//
//  Created by Elias Abel on 4/20/18.
//  Copyright (c) 2018 Meniny Lab. All rights reserved.
//

import UIKit

class PowBackgroundView: UIView {

    // MARK: Props
    private let visualEffectView: UIVisualEffectView
    private let imageView: UIImageView
    private let gradientView: PowGradientView
    
    // MARK: Setup
    init() {
        imageView = UIImageView()
        visualEffectView = UIVisualEffectView(effect: nil)
        gradientView = PowGradientView()
        super.init(frame: UIScreen.main.bounds)
        
        addSubview(imageView)
        imageView.contentMode = .scaleAspectFill
        imageView.fillSuperview()
        
        addSubview(visualEffectView)
        visualEffectView.fillSuperview()
        
        addSubview(gradientView)
        gradientView.fillSuperview()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Background setter
    var background: PowAttributes.BackgroundStyle! {
        didSet {
            guard let background = background else {
                return
            }
            
            var gradient: PowAttributes.BackgroundStyle.Gradient?
            var backgroundEffect: UIBlurEffect?
            var backgroundColor: UIColor = .clear
            var backgroundImage: UIImage?
            
            switch background {
            case .color(color: let color):
                backgroundColor = color
            case .gradient(gradient: let value):
                gradient = value
            case .image(image: let image):
                backgroundImage = image
            case .visualEffect(style: let style):
                backgroundEffect = UIBlurEffect(style: style)
            case .clear:
                break
            }
        
            gradientView.gradient = gradient
            visualEffectView.effect = backgroundEffect
            layer.backgroundColor = backgroundColor.cgColor
            imageView.image = backgroundImage
        }
    }
}
