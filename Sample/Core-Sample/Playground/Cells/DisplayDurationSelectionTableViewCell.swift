//
//  VisibleDurationTableViewCell.swift
//  Core-Sample
//
//  Created by Elias Abel on 4/24/18.
//  Copyright (c) 2018 Meniny Lab. All rights reserved.
//

import UIKit

class DisplayDurationSelectionTableViewCell: SelectionTableViewCell {
    
    override func configure(attributesWrapper: PowAttributeWrapper) {
        super.configure(attributesWrapper: attributesWrapper)
        titleValue = "Display Duration"
        descriptionValue = "How long the pow is displayed"
        insertSegments(by: ["2 Seconds", "4 Seconds", "Infinate"])
        selectSegment()
    }
    
    private func selectSegment() {
        switch attributesWrapper.attributes.displayDuration {
        case 2:
            segmentedControl.selectedSegmentIndex = 0
        case 4:
            segmentedControl.selectedSegmentIndex = 1
        case .infinity:
            segmentedControl.selectedSegmentIndex = 2
        default:
            break
        }
    }
    
    @objc override func segmentChanged() {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            attributesWrapper.attributes.displayDuration = 2
        case 1:
            attributesWrapper.attributes.displayDuration = 4
        case 2:
            attributesWrapper.attributes.displayDuration = .infinity
        default:
            break
        }
    }
}
