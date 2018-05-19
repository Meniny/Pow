//
//  PresetsDataSource.swift
//  Core-Sample
//
//  Created by Elias Abel on 4/27/18.
//  Copyright (c) 2018 Meniny Lab. All rights reserved.
//

import Foundation
import Pow

struct PresetsDataSource {
    
    // Cluster of presets, aggregated under name
    typealias Cluster = (title: String, data: [PresetDescription])
    
    private enum ThumbDesc: String {
        case bottomToast = "ic_bottom_toast"
        case bottomFloat = "ic_bottom_float"
        case topToast = "ic_top_toast"
        case topFloat = "ic_top_float"
        case statusBarNote = "ic_sb_note"
        case topNote = "ic_top_note"
//        case bottomNote = "ic_bottom_toast"
//        case centerPopup = "ic_center_popup"
        case bottomPopup = "ic_bottom_popup"
    }
    
    private(set) var dataSource: [Cluster] = []
    
    private(set) subscript(section: Int) -> Cluster {
        get {
            return dataSource[section]
        }
        set {
            return dataSource[section] = newValue
        }
    }
    
    private(set) subscript(section: Int, index: Int) -> PresetDescription {
        get {
            return dataSource[section].data[index]
        }
        set {
            return dataSource[section].data[index] = newValue
        }
    }
    
    // Cumputed for the sake of reusability
    var bottomAlertAttributes: PowAttributes {
        var attributes = PowAttributes.bottomFloat
        attributes.hapticFeedbackType = .success
        attributes.displayDuration = .infinity
        attributes.powBackground = .color(color: .white)
        attributes.screenBackground = .color(color: .dimmedLightBackground)
        attributes.shadow = .active(with: .init(color: .black, opacity: 0.3, radius: 8, offset: .zero))
        attributes.screenInteraction = .dismiss
        attributes.powInteraction = .absorbTouches
        attributes.scroll = .enabled(swipeable: true, pullbackAnimation: .jolt)
        attributes.roundCorners = .all(radius: 25)
        attributes.entranceAnimation = .init(translate: .init(duration: 0.7, spring: .init(damping: 1, initialVelocity: 0)),
                                             scale: .init(from: 1.05, to: 1, duration: 0.4, spring: .init(damping: 1, initialVelocity: 0)))
        attributes.exitAnimation = .init(translate: .init(duration: 0.2))
        attributes.popBehavior = .animated(animation: .init(translate: .init(duration: 0.2)))
        attributes.positionConstraints.verticalOffset = 10
        attributes.positionConstraints.size = .init(width: .offset(value: 20), height: .intrinsic)
        attributes.positionConstraints.maxSize = .init(width: .constant(value: UIScreen.main.minEdge), height: .intrinsic)
        attributes.statusBarStyle = .default
        return attributes
    }
    
    // MARK: Setup
    init() {
        setupToastPresets()
        setupNotePresets()
        setupFloatPresets()
        setupPopupPresets()
        setupFormPresets()
        setupCustomPresets()
    }
    
    private mutating func setupToastPresets() {
        
        var toasts: [PresetDescription] = []
        var attributes: PowAttributes
        var description: PresetDescription
        var descriptionString: String
        var descriptionThumb: String

        // Preset I
        attributes = .topToast
        attributes.hapticFeedbackType = .success
        attributes.powBackground = .color(color: PowColor.LightBlue.a700)
        attributes.entranceAnimation = .init(translate: .init(duration: 0.3), scale: .init(from: 1.07, to: 1, duration: 0.3))
        attributes.exitAnimation = .init(translate: .init(duration: 0.3))
        attributes.scroll = .edgeCrossingDisabled(swipeable: false)
        descriptionString = "Regular toast that appears at the top"
        descriptionThumb = ThumbDesc.topToast.rawValue
        description = .init(with: attributes, title: "Top I", description: descriptionString, thumb: descriptionThumb)
        toasts.append(description)

        // Preset II
        attributes = .topToast
        attributes.hapticFeedbackType = .success
        attributes.powBackground = .color(color: .darkChatMessage)
        attributes.entranceAnimation = .translation
        attributes.exitAnimation = .translation
        attributes.scroll = .edgeCrossingDisabled(swipeable: true)
        attributes.displayDuration = 4
        attributes.shadow = .active(with: .init(color: .darkChatMessage, opacity: 0.5, radius: 10, offset: .zero))
        descriptionString = "Chat message style toast"
        descriptionThumb = ThumbDesc.topToast.rawValue
        description = .init(with: attributes, title: "Top II", description: descriptionString, thumb: descriptionThumb)
        toasts.append(description)
        
        // Preset III
        attributes = .bottomToast
        attributes.powBackground = .visualEffect(style: .light)
        attributes.scroll = .edgeCrossingDisabled(swipeable: true)
        attributes.statusBarStyle = .default
        descriptionString = "Regular bottom toast with blurred background"
        descriptionThumb = ThumbDesc.bottomToast.rawValue
        description = .init(with: attributes, title: "Bottom", description: descriptionString, thumb: descriptionThumb)
        toasts.append(description)
        
        dataSource.append(("Toasts", toasts))
    }
    
    private mutating func setupNotePresets() {
        
        var notes: [PresetDescription] = []
        var attributes: PowAttributes
        var description: PresetDescription
        var descriptionString: String
        var descriptionThumb: String

        // Preset I
        attributes = .topNote
        attributes.hapticFeedbackType = .success
        attributes.popBehavior = .animated(animation: .translation)
        attributes.powBackground = .color(color: .satCyan)
        attributes.statusBarStyle = .lightContent
        descriptionString = "Absorbs (swallows) touches and the status bar becomes light"
        descriptionThumb = ThumbDesc.topNote.rawValue
        description = .init(with: attributes, title: "Top Standard Note", description: descriptionString, thumb: descriptionThumb)
        notes.append(description)

        // Preset II
        attributes = .topNote
        attributes.hapticFeedbackType = .success
        attributes.displayDuration = .infinity
        attributes.popBehavior = .animated(animation: .translation)
        attributes.powBackground = .color(color: .pinky)
        attributes.statusBarStyle = .lightContent
        descriptionString = "Appears for an infinate duration"
        descriptionThumb = ThumbDesc.topNote.rawValue
        description = .init(with: attributes, title: "Top Processing Note", description: descriptionString, thumb: descriptionThumb)
        notes.append(description)

        
        // Preset III
        attributes = .topNote
        attributes.hapticFeedbackType = .error
        attributes.displayDuration = 3
        attributes.popBehavior = .animated(animation: .translation)
        attributes.powBackground = .color(color: PowColor.Purple.deep)
        attributes.statusBarStyle = .lightContent
        descriptionString = "Appears for 3 seconds. Generates error notification haptic feedback"
        descriptionThumb = ThumbDesc.topNote.rawValue
        description = .init(with: attributes, title: "Top Image Note", description: descriptionString, thumb: descriptionThumb)
        notes.append(description)
        
        // Preset IV
        attributes = .statusBar
        attributes.hapticFeedbackType = .success
        attributes.popBehavior = .animated(animation: .translation)
        attributes.powBackground = .color(color: .greenGrass)
        descriptionString = "Overrides the status bar"
        descriptionThumb = ThumbDesc.statusBarNote.rawValue
        description = .init(with: attributes, title: "Status Bar Note", description: descriptionString, thumb: descriptionThumb)
        notes.append(description)
        
        // Preset V
        attributes = .bottomNote
        attributes.hapticFeedbackType = .success
        attributes.shadow = .active(with: .init(color: .black, opacity: 0.3, radius: 6, offset: .zero))
        attributes.powBackground = .gradient(gradient: .init(colors: [PowColor.Purple.a300, PowColor.Purple.a400, PowColor.Purple.a700], startPoint: .zero, endPoint: CGPoint(x: 1, y: 1)))
        attributes.statusBarStyle = .default
        descriptionString = "Presented at the bottom / Above the notch"
        descriptionThumb = ThumbDesc.bottomToast.rawValue
        description = .init(with: attributes, title: "Bottom Standard Note", description: descriptionString, thumb: descriptionThumb)
        notes.append(description)
        
        dataSource.append(("Notes", notes))
    }
    
    private mutating func setupFloatPresets() {
        
        var floats: [PresetDescription] = []
        var description: PresetDescription
        var attributes: PowAttributes
        var descriptionString: String
        var descriptionThumb: String

        // Preset I
        attributes = .topFloat
        attributes.hapticFeedbackType = .success
        attributes.powBackground = .gradient(gradient: .init(colors: [.amber, .pinky], startPoint: .zero, endPoint: CGPoint(x: 1, y: 1)))
        attributes.popBehavior = .animated(animation: .init(translate: .init(duration: 0.3), scale: .init(from: 1, to: 0.7, duration: 0.7)))
        attributes.shadow = .active(with: .init(color: .black, opacity: 0.5, radius: 10, offset: .zero))
        attributes.statusBarStyle = .default
        attributes.scroll = .enabled(swipeable: true, pullbackAnimation: .easeOut)
        attributes.positionConstraints.maxSize = .init(width: .constant(value: UIScreen.main.minEdge), height: .intrinsic)
        descriptionString = "Top float with gradient background"
        descriptionThumb = ThumbDesc.topFloat.rawValue
        description = .init(with: attributes, title: "Top", description: descriptionString, thumb: descriptionThumb)
        floats.append(description)
        
        // Preset II
        attributes = .bottomFloat
        attributes.hapticFeedbackType = .success
        attributes.powBackground = .gradient(gradient: .init(colors: [PowColor.BlueGradient.dark, PowColor.BlueGradient.light], startPoint: .zero, endPoint: CGPoint(x: 1, y: 1)))
        attributes.powInteraction = .delayExit(by: 3)
        attributes.scroll = .enabled(swipeable: true, pullbackAnimation: .jolt)
        attributes.statusBarStyle = .default
        attributes.positionConstraints.maxSize = .init(width: .constant(value: UIScreen.main.minEdge), height: .intrinsic)
        descriptionString = "Bottom float with gradient background. Touches delay exit"
        descriptionThumb = ThumbDesc.bottomFloat.rawValue
        description = .init(with: attributes, title: "Bottom", description: descriptionString, thumb: descriptionThumb)
        floats.append(description)
        
        dataSource.append(("Floats", floats))
    }
    
    private mutating func setupPopupPresets() {
        
        var presets: [PresetDescription] = []
        var attributes: PowAttributes
        var description: PresetDescription
        var descriptionString: String
        var descriptionThumb: String

        // Preset I
        attributes = bottomAlertAttributes
        descriptionString = "Bottom floating popup with dimmed background."
        descriptionThumb = ThumbDesc.bottomPopup.rawValue
        description = .init(with: attributes, title: "Pop Up I", description: descriptionString, thumb: descriptionThumb)
        presets.append(description)
        
        // Preset II
        attributes = PowAttributes.centerFloat
        attributes.hapticFeedbackType = .success
        attributes.displayDuration = .infinity
        attributes.powBackground = .gradient(gradient: .init(colors: [UIColor(rgb: 0xfffbd5), UIColor(rgb: 0xb20a2c)], startPoint: .zero, endPoint: CGPoint(x: 1, y: 1)))
        attributes.screenBackground = .color(color: .dimmedDarkBackground)
        attributes.shadow = .active(with: .init(color: .black, opacity: 0.3, radius: 8, offset: .zero))
        attributes.screenInteraction = .dismiss
        attributes.powInteraction = .absorbTouches
        attributes.scroll = .enabled(swipeable: true, pullbackAnimation: .jolt)
        attributes.roundCorners = .all(radius: 8)
        attributes.entranceAnimation = .init(translate: .init(duration: 0.7, spring: .init(damping: 0.7, initialVelocity: 0)),
                                             scale: .init(from: 0.7, to: 1, duration: 0.4, spring: .init(damping: 1, initialVelocity: 0)))
        attributes.exitAnimation = .init(translate: .init(duration: 0.2))
        attributes.popBehavior = .animated(animation: .init(translate: .init(duration: 0.35)))
        attributes.positionConstraints.size = .init(width: .offset(value: 20), height: .intrinsic)
        attributes.positionConstraints.maxSize = .init(width: .constant(value: UIScreen.main.minEdge), height: .intrinsic)
        attributes.statusBarStyle = .default
        descriptionString = "Centeralized floating popup with dimmed background"
        descriptionThumb = ThumbDesc.bottomPopup.rawValue
        description = .init(with: attributes, title: "Pop Up II", description: descriptionString, thumb: descriptionThumb)
        presets.append(description)
        
        
        // Preset III
        attributes = bottomAlertAttributes
        attributes.scroll = .edgeCrossingDisabled(swipeable: true)
        attributes.entranceAnimation = .init(translate: .init(duration: 0.5, spring: .init(damping: 1, initialVelocity: 0)))
        attributes.powBackground = .gradient(gradient: .init(colors: [PowColor.LightPink.first, PowColor.LightPink.last], startPoint: .zero, endPoint: CGPoint(x: 1, y: 1)))
        attributes.positionConstraints = .full
        attributes.positionConstraints.safeArea = .empty(fillSafeArea: true)
        attributes.roundCorners = .top(radius: 20)
        descriptionString = "Bottom toast popup with gradient background"
        descriptionThumb = ThumbDesc.bottomPopup.rawValue
        description = .init(with: attributes, title: "Pop Up III", description: descriptionString, thumb: descriptionThumb)
        presets.append(description)
        
        // Preset IV
        attributes = .topFloat
        attributes.hapticFeedbackType = .success
        attributes.screenInteraction = .dismiss
        attributes.powInteraction = .absorbTouches
        attributes.scroll = .enabled(swipeable: true, pullbackAnimation: .jolt)
        attributes.screenBackground = .color(color: .dimmedLightBackground)
        attributes.powBackground = .color(color: .white)
        attributes.entranceAnimation = .init(translate: .init(duration: 0.7, spring: .init(damping: 1, initialVelocity: 0)), scale: .init(from: 0.6, to: 1, duration: 0.7), fade: .init(from: 0.8, to: 1, duration: 0.3))
        attributes.exitAnimation = .init(scale: .init(from: 1, to: 0.7, duration: 0.3), fade: .init(from: 1, to: 0, duration: 0.3))            
        attributes.displayDuration = .infinity
        attributes.border = .value(color: .black, width: 0.5)
        attributes.shadow = .active(with: .init(color: .black, opacity: 0.5, radius: 5, offset: .zero))
        attributes.statusBarStyle = .default
        attributes.positionConstraints.maxSize = .init(width: .constant(value: UIScreen.main.minEdge), height: .intrinsic)
        descriptionString = "Top floating alert view with button bar. Smooths in animately."
        descriptionThumb = ThumbDesc.topFloat.rawValue
        description = .init(with: attributes, title: "Top Alert View", description: descriptionString, thumb: descriptionThumb)
        presets.append(description)

        // Preset V
        attributes = .centerFloat
        attributes.windowLevel = .alerts
        attributes.hapticFeedbackType = .success
        attributes.screenInteraction = .absorbTouches
        attributes.powInteraction = .absorbTouches
        attributes.scroll = .disabled
        attributes.screenBackground = .color(color: .dimmedLightBackground)
        attributes.powBackground = .color(color: .white)
        attributes.entranceAnimation = .init(scale: .init(from: 0.9, to: 1, duration: 0.4, spring: .init(damping: 1, initialVelocity: 0)), fade: .init(from: 0, to: 1, duration: 0.3))
        attributes.exitAnimation = .init(fade: .init(from: 1, to: 0, duration: 0.2))
        attributes.displayDuration = .infinity
        attributes.border = .value(color: .black, width: 0.5)
        attributes.shadow = .active(with: .init(color: .black, opacity: 0.3, radius: 5, offset: .zero))
        attributes.positionConstraints.maxSize = .init(width: .constant(value: UIScreen.main.minEdge), height: .intrinsic)
        descriptionString = "Center floating alert view with button bar."
        descriptionThumb = ThumbDesc.topFloat.rawValue
        description = .init(with: attributes, title: "Center Alert View", description: descriptionString, thumb: descriptionThumb)
        presets.append(description)
        
        dataSource.append(("Alerts & Popups", presets))
    }
    
    private mutating func setupFormPresets() {
        var presets: [PresetDescription] = []
        var attributes: PowAttributes
        var description: PresetDescription
        var descriptionString: String
        var descriptionThumb: String
        
        // Preset I
        attributes = .float
        attributes.windowLevel = .normal
        attributes.position = .top
        attributes.displayDuration = .infinity
        
        attributes.entranceAnimation = .init(translate: .init(duration: 0.65, spring: .init(damping: 0.8, initialVelocity: 0)))
        attributes.exitAnimation = .init(translate: .init(duration: 0.65, spring: .init(damping: 0.8, initialVelocity: 0)))
        attributes.popBehavior = .animated(animation: .init(translate: .init(duration: 0.65, spring: .init(damping: 0.8, initialVelocity: 0))))
        
        attributes.powInteraction = .absorbTouches
        attributes.screenInteraction = .dismiss
        attributes.powBackground = .visualEffect(style: .extraLight)
        attributes.screenBackground = .color(color: .dimmedDarkBackground)
        attributes.scroll = .enabled(swipeable: false, pullbackAnimation: .jolt)
        attributes.statusBarStyle = .lightContent
        
        attributes.positionConstraints.keyboardRelation = .bind(offset: .init(bottom: 10, screenEdgeResistance: 5))
        attributes.positionConstraints.maxSize = .init(width: .constant(value: UIScreen.main.minEdge), height: .intrinsic)
        descriptionString = "Keeps 10pts offset and resist screen top edge with 5pts offset. Dismissed with background tap."
        descriptionThumb = ThumbDesc.bottomPopup.rawValue
        description = .init(with: attributes, title: "Top Float", description: descriptionString, thumb: descriptionThumb)
        presets.append(description)
        
        // Preset II
        attributes = .float
        attributes.windowLevel = .normal
        attributes.position = .center
        attributes.displayDuration = .infinity
        
        attributes.entranceAnimation = .init(translate: .init(duration: 0.65, spring: .init(damping: 1, initialVelocity: 0)))
        attributes.exitAnimation = .init(translate: .init(duration: 0.65, spring: .init(damping: 1, initialVelocity: 0)))
        attributes.popBehavior = .animated(animation: .init(translate: .init(duration: 0.65, spring: .init(damping: 1, initialVelocity: 0))))
        
        attributes.powInteraction = .absorbTouches
        attributes.screenInteraction = .dismiss
        
        attributes.powBackground = .color(color: .white)
        attributes.screenBackground = .color(color: .dimmedDarkBackground)

        attributes.border = .value(color: UIColor(white: 0.6, alpha: 1), width: 1)
        attributes.shadow = .active(with: .init(color: .black, opacity: 0.3, radius: 3, offset: .zero))
        attributes.scroll = .enabled(swipeable: false, pullbackAnimation: .jolt)
        attributes.statusBarStyle = .lightContent
        
        attributes.positionConstraints.keyboardRelation = .bind(offset: .init(bottom: 15, screenEdgeResistance: 0))
        attributes.positionConstraints.maxSize = .init(width: .constant(value: UIScreen.main.minEdge), height: .intrinsic)
        descriptionString = "Keeps 15pts offset. Resists screen top edge (Could not exceed screen top bounds when the keyboard is open). Dismissed with background tap."
        descriptionThumb = ThumbDesc.bottomPopup.rawValue
        description = .init(with: attributes, title: "Center Float", description: descriptionString, thumb: descriptionThumb)
        presets.append(description)
        
        attributes = .toast
        attributes.windowLevel = .normal
        attributes.position = .bottom
        attributes.displayDuration = .infinity
        
        attributes.entranceAnimation = .init(translate: .init(duration: 0.65, spring: .init(damping: 1, initialVelocity: 0)))
        attributes.exitAnimation = .init(translate: .init(duration: 0.65, spring: .init(damping: 1, initialVelocity: 0)))
        attributes.popBehavior = .animated(animation: .init(translate: .init(duration: 0.65, spring: .init(damping: 1, initialVelocity: 0))))
        
        attributes.powInteraction = .absorbTouches
        attributes.screenInteraction = .dismiss
        
        attributes.powBackground = .gradient(gradient: .init(colors: [PowColor.Netflix.light, PowColor.Netflix.dark], startPoint: .zero, endPoint: CGPoint(x: 1, y: 1)))
        
        attributes.shadow = .active(with: .init(color: .black, opacity: 0.3, radius: 3, offset: .zero))
        attributes.screenBackground = .color(color: .dimmedDarkBackground)
        attributes.scroll = .edgeCrossingDisabled(swipeable: true)
        attributes.statusBarStyle = .lightContent
        
        attributes.positionConstraints.keyboardRelation = .bind(offset: .init(bottom: 0, screenEdgeResistance: 0))
        attributes.positionConstraints.maxSize = .init(width: .constant(value: UIScreen.main.minEdge), height: .intrinsic)
        descriptionString = "Keeps 10pts offset and resists screen top edge. Can be dismissed using swipe."
        descriptionThumb = ThumbDesc.bottomPopup.rawValue
        description = .init(with: attributes, title: "Bottom Toast", description: descriptionString, thumb: descriptionThumb)
        presets.append(description)
        
        dataSource.append(("Forms", presets))
    }
    
    private mutating func setupCustomPresets() {
        var presets: [PresetDescription] = []
        var attributes: PowAttributes
        var description: PresetDescription
        var descriptionString: String
        var descriptionThumb: String
        
        // Preset I
        attributes = .bottomFloat
        attributes.hapticFeedbackType = .success
        attributes.displayDuration = 3
        attributes.screenBackground = .clear
        attributes.powBackground = .clear
        attributes.screenInteraction = .forward
        attributes.powInteraction = .absorbTouches
        attributes.roundCorners = .all(radius: 5)
        
        attributes.entranceAnimation = .init(translate: .init(duration: 0.5, spring: .init(damping: 0.9, initialVelocity: 0)),
                                             scale: .init(from: 0.8, to: 1, duration: 0.5, spring: .init(damping: 0.8, initialVelocity: 0)),
                                             fade: .init(from: 0.7, to: 1, duration: 0.3))
        attributes.exitAnimation = .init(translate: .init(duration: 0.5),
                                         scale: .init(from: 1, to: 0.8, duration: 0.5),
                                         fade: .init(from: 1, to: 0, duration: 0.5))
        attributes.popBehavior = .animated(animation: .init(translate: .init(duration: 0.3),
                                                            scale: .init(from: 1, to: 0.8, duration: 0.3)))
        attributes.shadow = .active(with: .init(color: .black, opacity: 0.3, radius: 6, offset: .zero))
        attributes.positionConstraints.verticalOffset = 10
        attributes.positionConstraints.size = .init(width: .offset(value: 20), height: .intrinsic)
        attributes.positionConstraints.maxSize = .init(width: .constant(value: UIScreen.main.minEdge), height: .intrinsic)
        
        attributes.statusBarStyle = .default
        descriptionString = "Customized view that is initialized by a nib file, it is additionally added various attributes such as round corners and a mild shadow"
        descriptionThumb = ThumbDesc.bottomFloat.rawValue
        description = .init(with: attributes, title: "View From Nib", description: descriptionString, thumb: descriptionThumb)
        presets.append(description)
        
        dataSource.append(("Custom", presets))
    }
    
}
