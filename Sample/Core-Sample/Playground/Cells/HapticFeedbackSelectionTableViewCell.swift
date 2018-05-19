//
//  NotificationFeedbackSelectionTableViewCell.swift
//  Core-Sample
//
//  Created by Elias Abel on 4/25/18.
//  Copyright (c) 2018 Meniny Lab. All rights reserved.
//

import Foundation

class HapticFeedbackSelectionTableViewCell: SelectionTableViewCell {
    
    override func configure(attributesWrapper: PowAttributeWrapper) {
        super.configure(attributesWrapper: attributesWrapper)
        titleValue = "Notification Haptic Feedback"
        descriptionValue = "Generate a haptic feedback once the pow shows"
        insertSegments(by: ["Off", "Success", "Warning", "Error"])
        selectSegment()
    }
    
    private func selectSegment() {
        switch attributes.hapticFeedbackType {
        case .none:
            segmentedControl.selectedSegmentIndex = 0
        case .success:
            segmentedControl.selectedSegmentIndex = 1
        case .warning:
            segmentedControl.selectedSegmentIndex = 2
        case .error:
            segmentedControl.selectedSegmentIndex = 3
        }
    }
    
    @objc override func segmentChanged() {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            attributesWrapper.attributes.hapticFeedbackType = .none
        case 1:
            attributesWrapper.attributes.hapticFeedbackType = .success
        case 2:
            attributesWrapper.attributes.hapticFeedbackType = .warning
        case 3:
            attributesWrapper.attributes.hapticFeedbackType = .error
        default:
            break
        }
    }
}
