//
//  PowView.swift
//  Pow
//
//  Created by Elias Abel on 4/15/18.
//  Copyright (c) 2018 Meniny Lab. All rights reserved.
//

import UIKit
import PapaLayout

class PowView: PowStyleView {
    
    struct Content {
        var view: UIView
        var attributes: PowAttributes
        
        init(view: UIView, attributes: PowAttributes) {
            self.view = view
            self.attributes = attributes
        }
    }
    
    // MARK: Props
    
    var content: Content! {
        didSet {
            contentView = content.view
        }
    }
    
    var attributes: PowAttributes {
        return content.attributes
    }
    
    private let contentContainerView = PowStyleView()
    private var contentView: UIView! {
        didSet {
            oldValue?.removeFromSuperview()
            
            addSubview(contentContainerView)
            contentContainerView.layoutToSuperview(axis: .vertically)
            contentContainerView.layoutToSuperview(axis: .horizontally)
            contentContainerView.clipsToBounds = true
            
            contentContainerView.addSubview(contentView)
            contentView.layoutToSuperview(axis: .vertically)
            contentView.layoutToSuperview(axis: .horizontally)
                        
            applyDropShadow()

            applyBackgroundToContentView()
            
            applyFrameStyle()
        }
    }

    // MARK: Setup
    init() {
        super.init(frame: UIScreen.main.bounds)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        applyFrameStyle()
    }
    
    // Apply round corners
    private func applyFrameStyle() {
        guard !appliedStyle else {
            return
        }
        contentContainerView.applyFrameStyle(roundCorners: attributes.roundCorners, border: attributes.border)
    }
    
    // Apply drop shadow
    private func applyDropShadow() {
        switch attributes.shadow {
        case .active(with: let value):
            applyDropShadow(withOffset: value.offset, opacity: value.opacity, radius: value.radius, color: value.color)
        case .none:
            removeDropShadow()
        }
    }

    // Apply background
    private func applyBackgroundToContentView() {
        
        let attributes = content.attributes
        
        let backgroundView = PowBackgroundView()
        backgroundView.background = attributes.powBackground
        
        switch attributes.positionConstraints.safeArea {
        case .empty(fillSafeArea: let fillSafeArea) where fillSafeArea:
            insertSubview(backgroundView, at: 0)
            backgroundView.layoutToSuperview(axis: .horizontally)
            
            var topInset: CGFloat = 0
            var bottomInset: CGFloat = 0
            switch attributes.position {
            case .top:
                topInset = -PowWindowProvider.safeAreaInsets.top
            case .bottom, .center:
                bottomInset = PowWindowProvider.safeAreaInsets.bottom
            }
            
            backgroundView.layoutToSuperview(.top, offset: topInset)
            backgroundView.layoutToSuperview(.bottom, offset: bottomInset)
            
            if attributes.position.isBottom {
                applyFrameStyle(roundCorners: attributes.roundCorners, border: attributes.border)
            }

        default:
            contentView.insertSubview(backgroundView, at: 0)
            backgroundView.fillSuperview()
        }
    }
}
