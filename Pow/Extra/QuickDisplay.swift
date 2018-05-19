//
//  QuickDisplay.swift
//  Pow
//
//  Created by Elias Abel on 4/29/18.
//

import Foundation
import UIKit

public typealias PowTitle = String
public typealias PowDescription = String
public typealias PowAccessory = String
public typealias PowIcon = UIImage
public typealias PowButtonTitle = String
public typealias PowTextColor = UIColor
public typealias PowForegroundColor = UIColor
public typealias PowBackgroundColor = UIColor
public typealias PowButtonTitleColor = UIColor
public typealias PowButtonColor = UIColor
public typealias PowColor = UIColor
public typealias PowPlaceholder = String

public typealias PowButtonIndex = Int
public typealias PowShouldDismiss = Bool

public extension Pow {
    public static let mischka = #colorLiteral(red: 0.82, green:0.84, blue:0.86, alpha:1.00)
    public static let romance = #colorLiteral(red: 1.00, green:1.00, blue:1.00, alpha:1.00)
    public static let nero = #colorLiteral(red: 0.15, green:0.15, blue:0.15, alpha:1.00)
    public static var widthConstant: CGFloat = 250
    public static var duration: PowAttributes.DisplayDuration = 2.5
    
    public static func toast(message: String, duration: PowAttributes.DisplayDuration = Pow.duration, textColor: PowTextColor = Pow.romance, background: PowBackgroundColor = Pow.nero) {
        
        var attr = PowAttributes.bottomFloat
        attr.screenInteraction = .forward
        attr.scroll = .edgeCrossingDisabled(swipeable: true)
        attr.powInteraction = .dismiss
        attr.positionConstraints.size = .init(width: .intrinsic, height: message.contains("\n") ? .intrinsic : .constant(value: 50))
        attr.positionConstraints.maxSize = .init(width: .ratio(value: 1), height: .ratio(value: 1))
        attr.positionConstraints.verticalOffset = 50
        attr.statusBarStyle = .default
        attr.positionConstraints.keyboardRelation = .bind(offset: .init(bottom: 15, screenEdgeResistance: 0))
        attr.powBackground = .color(color: background)
        attr.displayDuration = duration
        
        let style = PowProperty.LabelStyle(font: .systemFont(ofSize: 14), color: textColor, alignment: .center)
        let labelContent = PowProperty.LabelContent(text: message, style: style)
        let contentView = PowNoteMessageView(with: labelContent)
        display(contentView, using: attr)
    }
    
    public static func richToast(title: String, message: String, icon: UIImage, duration: PowAttributes.DisplayDuration = Pow.duration, textColor: PowTextColor = Pow.romance, background: PowBackgroundColor = Pow.nero) {
        
        var attr = PowAttributes.bottomFloat
        attr.screenInteraction = .forward
        attr.scroll = .edgeCrossingDisabled(swipeable: true)
        attr.powInteraction = .dismiss
        attr.positionConstraints.size = .init(width: .constant(value: Pow.widthConstant), height: .intrinsic)
        attr.positionConstraints.maxSize = .init(width: .ratio(value: 1), height: .ratio(value: 1))
        attr.positionConstraints.verticalOffset = 50
        attr.statusBarStyle = .default
        attr.positionConstraints.keyboardRelation = .bind(offset: .init(bottom: 15, screenEdgeResistance: 0))
        attr.powBackground = .color(color: background)
        attr.displayDuration = duration
        
        let titleContent = PowProperty.LabelContent(text: title, style: .init(font: .systemFont(ofSize: 16), color: textColor))
        let description = PowProperty.LabelContent(text: message, style: .init(font: .systemFont(ofSize: 14), color: textColor))
        let image = PowProperty.ImageContent(image: icon, size: CGSize(width: 35, height: 35))
        let simpleMessage = PowSimpleMessage(image: image, title: titleContent, description: description)
        let notificationMessage = PowNotificationMessage(simpleMessage: simpleMessage)
        let contentView = PowNotificationMessageView(with: notificationMessage)
        display(contentView, using: attr)
    }
    
    public static func popup(title: String, message: String, icon: UIImage, button: String, buttonTitleColor: UIColor = Pow.romance, buttonBackground: UIColor = Pow.nero, textColor: PowTextColor = Pow.nero, background: PowBackgroundColor = Pow.romance, action: ((PowButtonIndex) -> PowShouldDismiss)? = nil) {
        
        var attr = PowAttributes.centerFloat
        attr.screenInteraction = .absorbTouches
        attr.scroll = .disabled
        attr.powInteraction = .absorbTouches
        attr.positionConstraints.size = .init(width: .constant(value: Pow.widthConstant), height: .intrinsic)
        attr.positionConstraints.maxSize = .init(width: .ratio(value: 1), height: .ratio(value: 1))
        attr.statusBarStyle = .default
        attr.positionConstraints.keyboardRelation = .bind(offset: .init(bottom: 15, screenEdgeResistance: 0))
        attr.powBackground = .color(color: background)
        attr.displayDuration = .infinity
        
        let titleContent = PowProperty.LabelContent(text: title, style: .init(font: .systemFont(ofSize: 24), color: textColor, alignment: .center))
        let description = PowProperty.LabelContent(text: message, style: .init(font: .systemFont(ofSize: 16), color: textColor, alignment: .center))
        let buttonContent = PowProperty.ButtonContent(label: .init(text: button, style: .init(font: .systemFont(ofSize: 16), color: buttonTitleColor)), backgroundColor: buttonBackground, highlightedBackgroundColor: buttonBackground.withAlphaComponent(0.05))
        let topImage = PowProperty.ImageContent(image: icon, size: CGSize(width: 60, height: 60), contentMode: .scaleAspectFit)
        let message = PowPopUpMessage(topImage: topImage, imagePosition: .topToTop(offset: 40), title: titleContent, description: description, button: buttonContent) {
            if action?(0) ?? true {
                Pow.dismiss()
            }
        }
        
        let contentView = PowPopUpMessageView(with: message)
        display(contentView, using: attr)
    }
    
    public static func alert(title: String, message: String, icon: UIImage, buttons: [String], textColor: PowTextColor = Pow.nero, background: PowBackgroundColor = Pow.romance, separator: UIColor = Pow.mischka, action: ((PowButtonIndex) -> PowShouldDismiss)? = nil) {
        
        var attr = PowAttributes.centerFloat
        attr.screenInteraction = .absorbTouches
        attr.scroll = .disabled
        attr.powInteraction = .absorbTouches
        attr.positionConstraints.size = .init(width: .constant(value: Pow.widthConstant), height: .intrinsic)
        attr.positionConstraints.maxSize = .init(width: .ratio(value: 1), height: .ratio(value: 1))
        attr.statusBarStyle = .default
        attr.positionConstraints.keyboardRelation = .bind(offset: .init(bottom: 15, screenEdgeResistance: 0))
        attr.powBackground = .color(color: background)
        attr.displayDuration = .infinity
        
        // Generate textual content
        let titleContent = PowProperty.LabelContent(text: title, style: .init(font: .systemFont(ofSize: 15), color: textColor, alignment: .center))
        let description = PowProperty.LabelContent(text: message, style: .init(font: .systemFont(ofSize: 13), color: textColor, alignment: .center))
        let image = PowProperty.ImageContent.init(image: icon, size: CGSize(width: 35, height: 35), contentMode: .scaleAspectFit, makeRound: true)
        let simpleMessage = PowSimpleMessage(image: image, title: titleContent, description: description)
        
        // Generate buttons content
        var btns = [PowProperty.ButtonContent]()
        for b in buttons {
            let idx = buttons.index(of: b) ?? 0
            // Close button - Just dismiss pow when the button is tapped
            let buttonLabelStyle = PowProperty.LabelStyle(font: .systemFont(ofSize: 16), color: textColor)
            let buttonLabel = PowProperty.LabelContent(text: b, style: buttonLabelStyle)
            let button = PowProperty.ButtonContent(label: buttonLabel, backgroundColor: .clear, highlightedBackgroundColor:  textColor.withAlphaComponent(0.05)) {
                if action?(idx) ?? true {
                    Pow.dismiss()
                }
            }
            btns.append(button)
        }
        
        // Generate the content
        let buttonsBarContent = PowProperty.ButtonBarContent(with: btns, separatorColor: separator, expandAnimatedly: true)
        
        let alertMessage = PowAlertMessage(simpleMessage: simpleMessage, buttonBarContent: buttonsBarContent)
        
        // Setup the view itself
        let contentView = PowAlertMessageView(with: alertMessage)
        display(contentView, using: attr)
    }
    
    public static func float(title: String, message: String, icon: UIImage, duration: PowAttributes.DisplayDuration = Pow.duration, textColor: PowTextColor = Pow.nero, background: PowBackgroundColor = Pow.romance) {
        
        var attr = PowAttributes.centerFloat
        attr.screenInteraction = .forward
        attr.scroll = .edgeCrossingDisabled(swipeable: true)
        attr.powInteraction = .dismiss
        attr.positionConstraints.size = .init(width: .constant(value: Pow.widthConstant), height: .intrinsic)
        attr.positionConstraints.maxSize = .init(width: .ratio(value: 1), height: .ratio(value: 1))
        attr.statusBarStyle = .default
        attr.positionConstraints.keyboardRelation = .bind(offset: .init(bottom: 15, screenEdgeResistance: 0))
        attr.powBackground = .color(color: background)
        attr.displayDuration = duration
        
        let titleContent = PowProperty.LabelContent(text: title, style: .init(font: .systemFont(ofSize: 16), color: textColor))
        let description = PowProperty.LabelContent(text: message, style: .init(font: .systemFont(ofSize: 14), color: textColor))
        let image = PowProperty.ImageContent(image: icon, size: CGSize(width: 35, height: 35))
        let simpleMessage = PowSimpleMessage(image: image, title: titleContent, description: description)
        let notificationMessage = PowNotificationMessage(simpleMessage: simpleMessage)
        let contentView = PowNotificationMessageView(with: notificationMessage)
        display(contentView, using: attr)
    }
    
    public static func note(message: String, icon: UIImage?, duration: PowAttributes.DisplayDuration = Pow.duration, textColor: PowTextColor = Pow.romance, background: PowBackgroundColor = Pow.nero) {
        
        var attr = PowAttributes.topNote
        attr.screenInteraction = .forward
        attr.scroll = .edgeCrossingDisabled(swipeable: true)
        attr.powInteraction = .dismiss
        attr.positionConstraints.size = .init(width: .ratio(value: 1), height: .constant(value: 44))
        attr.positionConstraints.maxSize = .init(width: .ratio(value: 1), height: .ratio(value: 1))
        attr.statusBarStyle = .default
        attr.positionConstraints.keyboardRelation = .bind(offset: .init(bottom: 15, screenEdgeResistance: 0))
        attr.powBackground = .color(color: background)
        attr.displayDuration = duration
        
        if let icon = icon {
            let style = PowProperty.LabelStyle(font: .systemFont(ofSize: 14), color: textColor, alignment: .center)
            let labelContent = PowProperty.LabelContent(text: message, style: style)
            let imageContent = PowProperty.ImageContent(image: icon, size: CGSize.init(width: 25, height: 25))
            let contentView = PowImageNoteMessageView(with: labelContent, imageContent: imageContent)
            display(contentView, using: attr)
        } else {
            let style = PowProperty.LabelStyle(font: .systemFont(ofSize: 14), color: textColor, alignment: .center)
            let labelContent = PowProperty.LabelContent(text: message, style: style)
            let contentView = PowNoteMessageView(with: labelContent)
            display(contentView, using: attr)
        }
    }
    
    public static func loading(message: String, duration: PowAttributes.DisplayDuration = .infinity, textColor: PowTextColor = Pow.romance, background: PowBackgroundColor = Pow.nero) {
        
        var attr = PowAttributes.topNote
        attr.screenInteraction = .forward
        attr.scroll = .disabled
        attr.powInteraction = .absorbTouches
        attr.positionConstraints.size = .init(width: .ratio(value: 1), height: .constant(value: 44))
        attr.positionConstraints.maxSize = .init(width: .ratio(value: 1), height: .ratio(value: 1))
        attr.statusBarStyle = .default
        attr.positionConstraints.keyboardRelation = .bind(offset: .init(bottom: 15, screenEdgeResistance: 0))
        attr.powBackground = .color(color: background)
        attr.displayDuration = duration
        
        let style = PowProperty.LabelStyle(font: .systemFont(ofSize: 14), color: textColor, alignment: .center)
        let labelContent = PowProperty.LabelContent(text: message, style: style)
        let contentView = PowProcessingNoteMessageView(with: labelContent, activityIndicator: .white)
        display(contentView, using: attr)
    }
    
    public static func notification(title: String, message: String, icon: UIImage, duration: PowAttributes.DisplayDuration = Pow.duration, textColor: PowTextColor = Pow.nero, background: PowBackgroundColor = Pow.romance) {
        
        var attr = PowAttributes.topNote
        attr.screenInteraction = .forward
        attr.scroll = .edgeCrossingDisabled(swipeable: true)
        attr.powInteraction = .dismiss
        let statusBarHeight = UIApplication.shared.statusBarFrame.maxY
        attr.positionConstraints.size = .init(width: .ratio(value: 1), height: .constant(value: 44 + statusBarHeight))
        attr.positionConstraints.maxSize = .init(width: .ratio(value: 1), height: .ratio(value: 1))
        attr.statusBarStyle = .default
        attr.positionConstraints.keyboardRelation = .bind(offset: .init(bottom: 15, screenEdgeResistance: 0))
        attr.powBackground = .color(color: background)
        attr.displayDuration = duration
        
        let titleContent = PowProperty.LabelContent(text: title, style: .init(font: .boldSystemFont(ofSize: 16), color: textColor))
        let description = PowProperty.LabelContent(text: message, style: .init(font: .systemFont(ofSize: 14), color: textColor))
        let image = PowProperty.ImageContent(image: icon, size: CGSize(width: 35, height: 35))
        let simpleMessage = PowSimpleMessage(image: image, title: titleContent, description: description)
        let notificationMessage = PowNotificationMessage(simpleMessage: simpleMessage)
        let contentView = PowNotificationMessageView(with: notificationMessage)
        
        display(contentView, using: attr)
    }
    
    public struct Form: Equatable {
        public var placeholder: String
        public var image: UIImage
        public var keyboard: UIKeyboardType
        public var password: Bool
        
        public init(_ placeholder: String, image: UIImage, keyboard: UIKeyboardType = .default, password: Bool = false) {
            self.placeholder = placeholder
            self.image = image
            self.keyboard = keyboard
            self.password = password
        }
    }
    
    public static func form(title: String, message: String, icon: UIImage, fields: [Pow.Form], button: String, buttonTitleColor: UIColor = Pow.romance, buttonBackground: UIColor = Pow.nero, textColor: PowTextColor = Pow.nero, background: PowBackgroundColor = Pow.romance, action: @escaping ([String?]) -> PowShouldDismiss) {
        
        var attr = PowAttributes.bottomToast
        attr.screenInteraction = .dismiss
        attr.scroll = .edgeCrossingDisabled(swipeable: true)
        attr.powInteraction = .absorbTouches
        attr.positionConstraints.size = .init(width: .ratio(value: 1), height: .intrinsic)
        attr.positionConstraints.maxSize = .init(width: .ratio(value: 1), height: .ratio(value: 1))
        attr.statusBarStyle = .default
        attr.positionConstraints.keyboardRelation = .bind(offset: .init(bottom: 15, screenEdgeResistance: 0))
        attr.powBackground = .color(color: background)
        attr.displayDuration = .infinity
        
        let titleContent = PowProperty.LabelContent(text: title, style: .init(font: .systemFont(ofSize: 16), color: textColor, alignment: .center))
        
        var tfs = [PowProperty.TextFieldContent]()
        for f in fields {
            let placeholder = PowProperty.LabelContent(text: f.placeholder, style: .init(font: .systemFont(ofSize: 14), color: UIColor(white: 0.8, alpha: 1)))
            let textField = PowProperty.TextFieldContent.init(keyboardType: f.keyboard, placeholder: placeholder, textStyle: .init(font: .systemFont(ofSize: 14), color: textColor), isSecure: f.password, leadingImage: f.image, bottomBorderColor: textColor)
            tfs.append(textField)
        }
        let label = PowProperty.LabelContent(text: button, style: .init(font: .systemFont(ofSize: 14), color: buttonTitleColor))
        
        var contentView: PowFormMessageView?
        
        let buttonContent = PowProperty.ButtonContent(label: label, backgroundColor: buttonBackground, highlightedBackgroundColor: buttonBackground.withAlphaComponent(0.8)) {
            let inputs = contentView?.textFieldViews.map({ t -> String? in
                let tt = t.textField.text ?? ""
                return tt.isEmpty ? nil : tt
            })
            if action(inputs ?? []) {
                Pow.dismiss()
//                (contentView?.superview as? PowContentView)?.animateOut(pushOut: false)
            }
        }
        
        contentView = PowFormMessageView(with: titleContent, textFieldsContent: tfs, buttonContent: buttonContent)
        
        display(contentView!, using: attr)
    }
    
    public static func modal(view: UIView, position: PowAttributes.Position, duration: PowAttributes.DisplayDuration = Pow.duration, width: PowAttributes.PositionConstraints.Edge = .intrinsic, height: PowAttributes.PositionConstraints.Edge = .intrinsic, corners: PowAttributes.RoundCorners = .top(radius: 10), background: UIColor = Pow.romance) {
        var attr = PowAttributes.bottomToast
        attr.screenInteraction = .dismiss
        attr.scroll = .edgeCrossingDisabled(swipeable: true)
        attr.powInteraction = .absorbTouches
        attr.positionConstraints.size = .init(width: width, height: height)
        attr.positionConstraints.maxSize = .init(width: .ratio(value: 1), height: .ratio(value: 1))
        attr.statusBarStyle = .default
        attr.positionConstraints.keyboardRelation = .bind(offset: .init(bottom: 15, screenEdgeResistance: 0))
        attr.powBackground = .color(color: background)
        attr.displayDuration = duration
        attr.roundCorners = corners
        
        display(view, using: attr)
    }
}
