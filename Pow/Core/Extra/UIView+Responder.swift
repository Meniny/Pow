//
//  UIView+Responder.swift
//  Pow
//
//  Created by Elias Abel on 5/17/18.
//

import UIKit
import PapaLayout

extension UIView {
    var containsFirstResponder: Bool {
        var contains = false
        for subview in subviews.reversed() where !contains {
            if subview.isFirstResponder {
                contains = true
            } else {
                contains = subview.containsFirstResponder
            }
        }
        return contains
    }
}
