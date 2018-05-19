//
//  PowWrapperView.swift
//  Pow
//
//  Created by Elias Abel on 4/19/18.
//  Copyright (c) 2018 Meniny Lab. All rights reserved.
//

import UIKit
import PapaLayout

class PowWrapperView: UIView {
    var isAbleToReceiveTouches = false
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        if isAbleToReceiveTouches {
            return super.hitTest(point, with: event)
        }
        if let view = super.hitTest(point, with: event), view != self {
            return view
        }
        return nil
    }
}

