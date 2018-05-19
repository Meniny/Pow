//
//  SafeAreaSelectionTableViewCell.swift
//  Core-Sample
//
//  Created by Elias Abel on 4/25/18.
//  Copyright (c) 2018 Meniny Lab. All rights reserved.
//

import UIKit

class SafeAreaSelectionTableViewCell: SelectionTableViewCell {
    override func configure(attributesWrapper: PowAttributeWrapper) {
        super.configure(attributesWrapper: attributesWrapper)
        titleValue = "Safe Area Adjustment"
        descriptionValue = "Describes whether the pow overrides / ignore safe area insets"
        insertSegments(by: ["Colored", "Uncolored", "Override"])
        selectSegment()
    }
    
    private func selectSegment() {
        switch attributesWrapper.attributes.positionConstraints.safeArea {
        case .empty(fillSafeArea: let fill) where fill:
            segmentedControl.selectedSegmentIndex = 0
        case .empty(fillSafeArea: let fill) where !fill:
            segmentedControl.selectedSegmentIndex = 1
        case .overriden:
            segmentedControl.selectedSegmentIndex = 2
        default:
            break
        }
    }
    
    @objc override func segmentChanged() {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            attributesWrapper.attributes.positionConstraints.safeArea = .empty(fillSafeArea: true)
        case 1:
            attributesWrapper.attributes.positionConstraints.safeArea = .empty(fillSafeArea: false)
        case 2:
            attributesWrapper.attributes.positionConstraints.safeArea = .overriden
        default:
            break
        }
    }
}
