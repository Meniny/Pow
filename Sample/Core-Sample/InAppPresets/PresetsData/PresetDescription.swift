//
//  PresetDescription.swift
//  Core-Sample
//
//  Created by Elias Abel on 4/24/18.
//  Copyright (c) 2018 Meniny Lab. All rights reserved.
//

import Pow

// Description of a single preset to be presented
struct PresetDescription {
    let title: String
    let description: String
    let thumb: String
    let attributes: PowAttributes
    
    init(with attributes: PowAttributes, title: String, description: String = "", thumb: String) {
        self.attributes = attributes
        self.title = title
        self.description = description
        self.thumb = thumb
    }
}
