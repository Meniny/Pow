//
//  ShadowSelectionTableViewCell.swift
//  Core-Sample
//
//  Created by Elias Abel on 4/25/18.
//  Copyright (c) 2018 Meniny Lab. All rights reserved.
//

import UIKit
import Pow

class ShadowSelectionTableViewCell: SelectionTableViewCell {
    override func configure(attributesWrapper: PowAttributeWrapper) {
        super.configure(attributesWrapper: attributesWrapper)
        titleValue = "Drop Shadow"
        descriptionValue = "A drop shadow effect that can be applied to the pow"
        insertSegments(by: ["Off", "On"])
        selectSegment()
    }
    
    private func selectSegment() {
        switch attributesWrapper.attributes.shadow {
        case .none:
            segmentedControl.selectedSegmentIndex = 0
        case .active(with: _):
            segmentedControl.selectedSegmentIndex = 1
        }
    }
    
    @objc override func segmentChanged() {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            attributesWrapper.attributes.shadow = .none
        case 1:
            let value = PowAttributes.Shadow.Value(color: .black, opacity: 0.5, radius: 10, offset: .zero)
            attributesWrapper.attributes.shadow = .active(with: value)
        default:
            break
        }
    }
}
