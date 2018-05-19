//
//  HapticFeedbackGenerator.swift
//  Pow
//
//  Created by Elias Abel on 4/20/18.
//  Copyright (c) 2018 Meniny Lab. All rights reserved.
//

import Foundation

public struct PowHapticFeedbackGenerator {
    @available(iOS 10.0, *)
    public static func notification(type: PowAttributes.NotificationHapticFeedback) {
        guard let value = type.value else {
            return
        }
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(value)
    }
}
