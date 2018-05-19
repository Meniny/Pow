//
//  UIEdgeInsets.swift
//  FBSnapshotTestCase
//
//  Created by Elias Abel on 4/21/18.
//

import UIKit

extension UIEdgeInsets {
    var hasVerticalInsets: Bool {
        return top > 0 || bottom > 0
    }
}
