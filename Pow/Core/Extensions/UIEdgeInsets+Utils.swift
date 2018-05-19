//
//  UIEdgeInsets.swift
//  FBSnapshotTestCase
//
//  Created by Elias Abel on 4/21/18.
//

import UIKit
import PapaLayout

extension UIEdgeInsets {
    var hasVerticalInsets: Bool {
        return top > 0 || bottom > 0
    }
}
