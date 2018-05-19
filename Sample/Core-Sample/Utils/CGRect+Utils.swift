//
//  CGRect.swift
//  Core-Sample
//
//  Created by Elias Abel on 4/28/18.
//  Copyright (c) 2018 Meniny Lab. All rights reserved.
//

import UIKit

extension CGRect {
    var minEdge: CGFloat {
        return min(width, height)
    }
}
