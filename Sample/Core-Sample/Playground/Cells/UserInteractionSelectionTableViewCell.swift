//
//  UserInteractionSelectionTableViewCell.swift
//  Core-Sample
//
//  Created by Elias Abel on 4/25/18.
//  Copyright (c) 2018 Meniny Lab. All rights reserved.
//

import UIKit
import Pow

class UserInteractionSelectionTableViewCell: SelectionTableViewCell {
        
    var focus: Focus = .pow
    
    private var interactionAction: PowAttributes.UserInteraction.Default {
        get {
            switch focus {
            case .pow:
                return attributesWrapper.attributes.powInteraction.defaultAction
            case .screen:
                return attributesWrapper.attributes.screenInteraction.defaultAction
            }
        }
        set {
            switch focus {
            case .pow:
                attributesWrapper.attributes.powInteraction.defaultAction = newValue
            case .screen:
                attributesWrapper.attributes.screenInteraction.defaultAction = newValue
            }
        }
    }
    
    func configure(attributesWrapper: PowAttributeWrapper, focus: Focus) {
        self.focus = focus
        configure(attributesWrapper: attributesWrapper)
    }
    
    override func configure(attributesWrapper: PowAttributeWrapper) {
        super.configure(attributesWrapper: attributesWrapper)
        titleValue = "\(focus.rawValue.capitalized) User Interaction"
        descriptionValue = "Describes what happens when the user taps the \(focus.rawValue). The touch can be absorbed, delay the exit, be forwarded to the window below, or dismiss the pow."
        
        insertSegments(by: ["Absorb", "Delay", "Forward", "Dismiss"])
        selectSegment()
    }
    
    private func selectSegment() {
        switch interactionAction {
        case .absorbTouches:
            segmentedControl.selectedSegmentIndex = 0
        case .delayExit(by: _):
            segmentedControl.selectedSegmentIndex = 1
        case .forward:
            segmentedControl.selectedSegmentIndex = 2
        case .dismissEntry:
            segmentedControl.selectedSegmentIndex = 3
        }
    }
    
    @objc override func segmentChanged() {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            interactionAction = .absorbTouches
        case 1:
            interactionAction = .delayExit(by: 4)
        case 2:
            interactionAction = .forward
        case 3:
            interactionAction = .dismissEntry
        default:
            break
        }
    }
}
