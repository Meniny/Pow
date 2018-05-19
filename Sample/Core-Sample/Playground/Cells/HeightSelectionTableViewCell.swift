//
//  HeightSelectionTableViewCell.swift
//  Core-Sample
//
//  Created by Elias Abel on 4/26/18.
//  Copyright (c) 2018 Meniny Lab. All rights reserved.
//

import UIKit

class HeightSelectionTableViewCell: SelectionTableViewCell {
    override func configure(attributesWrapper: PowAttributeWrapper) {
        super.configure(attributesWrapper: attributesWrapper)
        titleValue = "Height"
        descriptionValue = "Describes the pow's height inside the screen. It can be a constant, receive intrinsic height or even get a screen height ratio"
        insertSegments(by: ["Intrinsic", "100pts", "50% Ratio"])
        selectSegment()
    }
    
    private func selectSegment() {
        switch attributesWrapper.attributes.positionConstraints.size.height {
        case .intrinsic:
            segmentedControl.selectedSegmentIndex = 0
        case .constant(value: 100):
            segmentedControl.selectedSegmentIndex = 1
        case .ratio(value: 0.5):
            segmentedControl.selectedSegmentIndex = 2
        default:
            break
        }
    }
    
    @objc override func segmentChanged() {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            attributesWrapper.attributes.positionConstraints.size.height = .intrinsic
        case 1:
            attributesWrapper.attributes.positionConstraints.size.height = .constant(value: 100)
        case 2:
            attributesWrapper.attributes.positionConstraints.size.height = .ratio(value: 0.5)
        default:
            break
        }
    }
}
