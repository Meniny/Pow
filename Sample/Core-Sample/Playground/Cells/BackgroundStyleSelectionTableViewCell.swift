//
//  ScreenBackgroundStyleSelectionTableViewCell.swift
//  Core-Sample
//
//  Created by Elias Abel on 4/25/18.
//  Copyright (c) 2018 Meniny Lab. All rights reserved.
//

import UIKit
import Pow

class BackgroundStyleSelectionTableViewCell: SelectionTableViewCell {
    
    private var focus: Focus = .pow
    
    private var backgroundStyle: PowAttributes.BackgroundStyle {
        get {
            switch focus {
            case .pow:
                return attributesWrapper.attributes.powBackground
            case .screen:
                return attributesWrapper.attributes.screenBackground
            }
        }
        set {
            switch focus {
            case .pow:
                attributesWrapper.attributes.powBackground = newValue
            case .screen:
                attributesWrapper.attributes.screenBackground = newValue
            }
        }
    }
    
    func configure(attributesWrapper: PowAttributeWrapper, focus: Focus) {
        self.focus = focus
        configure(attributesWrapper: attributesWrapper)
    }
    
    override func configure(attributesWrapper: PowAttributeWrapper) {
        super.configure(attributesWrapper: attributesWrapper)
        titleValue = "\(focus.rawValue.capitalized) Background Style"
        descriptionValue = "The style of the \(focus.rawValue)'s background can be one of the following options"
        
        insertSegments(by: ["Clear", "Blur", "Gradient", "Color"])
        selectSegment()
    }
    
    private func selectSegment() {
        switch backgroundStyle {
        case .clear:
            segmentedControl.selectedSegmentIndex = 0
        case .visualEffect(style: _):
            segmentedControl.selectedSegmentIndex = 1
        case .gradient(gradient: _):
            segmentedControl.selectedSegmentIndex = 2
        case .color(color: _):
            segmentedControl.selectedSegmentIndex = 3
        default:
            // TODO: Image isn't handled yet
            break
        }
    }
    
    @objc override func segmentChanged() {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            backgroundStyle = .clear
        case 1:
            backgroundStyle = .visualEffect(style: .light)
        case 2:
            let gradient = PowAttributes.BackgroundStyle.Gradient(colors: [PowColor.BlueGray.c100, PowColor.BlueGray.c300], startPoint: .zero, endPoint: CGPoint(x: 1, y: 1))
            backgroundStyle = .gradient(gradient: gradient)
        case 3:
            let color: UIColor
            switch focus {
            case .pow:
                color = .amber
            case .screen:
                color = UIColor.black.withAlphaComponent(0.5)
            }
            backgroundStyle = .color(color: color)
        default:
            break
        }
    }
}

