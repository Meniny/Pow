//
//  PresetsViewController.swift
//  Pow
//
//  Created by Elias Abel on 04/14/2018.
//  Copyright (c) 2018 Meniny Lab. All rights reserved.
//

import Pow
import UIKit

/** This view controller offers presets of entries to choose from */
class PresetsViewController: UIViewController {

    // MARK: Props
    private let dataSource = PresetsDataSource()
    private let tableView = UITableView()
    
    // MARK: Lifecycle & Setup
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.tintColor = PowColor.BlueGray.c700
        setupTableView()
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.estimatedRowHeight = UITableViewAutomaticDimension
        tableView.estimatedSectionHeaderHeight = UITableViewAutomaticDimension
        tableView.register(PresetTableViewCell.self, forCellReuseIdentifier: PresetTableViewCell.className)
        tableView.register(SelectionHeaderView.self, forHeaderFooterViewReuseIdentifier: SelectionHeaderView.className)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.fillSuperview()
    }
    
    // MARK: Entry Samples
    
    // Bumps a standard note
    private func showNote(attributes: PowAttributes) {
        let text = "Pssst! I have something to tell you..."
        let style = PowProperty.LabelStyle(font: MainFont.light.with(size: 14), color: .white, alignment: .center)
        let labelContent = PowProperty.LabelContent(text: text, style: style)
        
        let contentView = PowNoteMessageView(with: labelContent)

        Pow.display(contentView, using: attributes)
    }
    
    private func showImageNote(attributes: PowAttributes) {
        
        // Set note label content
        let text = "The thrill is gone"
        let style = PowProperty.LabelStyle(font: MainFont.light.with(size: 14), color: .white, alignment: .center)
        let labelContent = PowProperty.LabelContent(text: text, style: style)
        let imageContent = PowProperty.ImageContent(image: UIImage(named: "ic_wifi")!)
        
        let contentView = PowImageNoteMessageView(with: labelContent, imageContent: imageContent)
        
        Pow.display(contentView, using: attributes)
    }
    
    // Bumps an infinate processing note
    private func showProcessingNote(attributes: PowAttributes) {
        let text = "Waiting for the goodies to arrive!"
        let style = PowProperty.LabelStyle(font: MainFont.light.with(size: 14), color: .white, alignment: .center)
        let labelContent = PowProperty.LabelContent(text: text, style: style)
        
        let contentView = PowProcessingNoteMessageView(with: labelContent, activityIndicator: .white)
        
        Pow.display(contentView, using: attributes)
    }
    
    // Bumps a status bar replacement pow
    private func showStatusBarMessage(attributes: PowAttributes) {
        let statusBarHeight = UIApplication.shared.statusBarFrame.maxY
        
        let contentView: UIView
        let font = MainFont.light.with(size: 12)
        let labelStyle = PowProperty.LabelStyle(font: font, color: .white, alignment: .center)
        if statusBarHeight > 20 {
            let leading = PowProperty.LabelContent(text: "My 🧠", style: labelStyle)
            let trailing = PowProperty.LabelContent(text: "Wonders!", style: labelStyle)
            contentView = PowXStatusBarMessageView(leading: leading, trailing: trailing)
        } else {
            let labelContent = PowProperty.LabelContent(text: "My 🧠 is doing some thinking...", style: labelStyle)
            let noteView = PowNoteMessageView(with: labelContent)
            noteView.verticalOffset = 0
            noteView.set(.height, of: statusBarHeight)
            contentView = noteView
        }
        
        Pow.display(contentView, using: attributes)
    }
    
    // Bumps a notification structured pow
    private func showNotificationMessage(attributes: PowAttributes, title: String, desc: String, textColor: UIColor, imageName: String) {
        let title = PowProperty.LabelContent(text: title, style: .init(font: MainFont.medium.with(size: 16), color: textColor))
        let description = PowProperty.LabelContent(text: desc, style: .init(font: MainFont.light.with(size: 14), color: textColor))
        let image = PowProperty.ImageContent(image: UIImage(named: imageName)!, size: CGSize(width: 35, height: 35))
        let simpleMessage = PowSimpleMessage(image: image, title: title, description: description)
        let notificationMessage = PowNotificationMessage(simpleMessage: simpleMessage)

        let contentView = PowNotificationMessageView(with: notificationMessage)
        Pow.display(contentView, using: attributes)
    }
    
    // Bumps a chat message structured pow
    private func showChatNotificationMessage(attributes: PowAttributes) {
        let title = PowProperty.LabelContent(text: "Madi", style: .init(font: MainFont.medium.with(size: 14), color: .white))
        let description = PowProperty.LabelContent(text: "Hey! I'll come by at your office for lunch... 🍲", style: .init(font: MainFont.light.with(size: 12), color: .white))
        let time = PowProperty.LabelContent(text: "09:00", style: .init(font: MainFont.light.with(size: 10), color: .white))
        let image = PowProperty.ImageContent.thumb(with: "ic_madi_profile", edgeSize: 35)
        let simpleMessage = PowSimpleMessage(image: image, title: title, description: description)
        let notificationMessage = PowNotificationMessage(simpleMessage: simpleMessage, auxiliary: time)
        
        let contentView = PowNotificationMessageView(with: notificationMessage)
        Pow.display(contentView, using: attributes)
    }
    
    private func showDarkAwesomePopupMessage(attributes: PowAttributes) {
        let image = UIImage(named: "ic_done_all_dark_48pt")!
        let title = "Awesome!"
        let description = "You are using Pow, and this is a customized alert view that is floating at the bottom."
        showPopupMessage(attributes: attributes, title: title, titleColor: .darkText, description: description, descriptionColor: .darkSubText, buttonTitleColor: .white, buttonBackgroundColor: .amber, image: image)
    }
    
    private func showLightAwesomePopupMessage(attributes: PowAttributes) {
        let image = UIImage(named: "ic_done_all_light_48pt")!
        let title = "Awesome!"
        let description = "You are using Pow, and this is a pop up with important content"
        showPopupMessage(attributes: attributes, title: title, titleColor: .white, description: description, descriptionColor: .white, buttonTitleColor: PowColor.Gray.mid, buttonBackgroundColor: .white, image: image)
    }
    
    private func showPopupMessage(attributes: PowAttributes, title: String, titleColor: UIColor, description: String, descriptionColor: UIColor, buttonTitleColor: UIColor, buttonBackgroundColor: UIColor, image: UIImage, imagePosition: PowPopUpMessage.ImagePosition = .topToTop(offset: 40)) {
        let title = PowProperty.LabelContent(text: title, style: .init(font: MainFont.medium.with(size: 24), color: titleColor, alignment: .center))
        let description = PowProperty.LabelContent(text: description, style: .init(font: MainFont.light.with(size: 16), color: descriptionColor, alignment: .center))
        let button = PowProperty.ButtonContent(label: .init(text: "Got it!", style: .init(font: MainFont.bold.with(size: 16), color: buttonTitleColor)), backgroundColor: buttonBackgroundColor, highlightedBackgroundColor: buttonTitleColor.withAlphaComponent(0.05))
        let topImage = PowProperty.ImageContent(image: image, size: CGSize(width: 60, height: 60), contentMode: .scaleAspectFit)
        let message = PowPopUpMessage(topImage: topImage, imagePosition: imagePosition, title: title, description: description, button: button) {
            Pow.dismiss()
        }
        
        let contentView = PowPopUpMessageView(with: message)
        Pow.display(contentView, using: attributes)
    }
    
    private func showButtonBarMessage(attributes: PowAttributes) {
        
        // Generate textual content
        let title = PowProperty.LabelContent(text: "Dear Reader!", style: .init(font: MainFont.medium.with(size: 15), color: .black))
        let description = PowProperty.LabelContent(text: "Get a coupon for a free book now", style: .init(font: MainFont.light.with(size: 13), color: .black))
        let image = PowProperty.ImageContent(imageName: "ic_books", size: CGSize(width: 35, height: 35), contentMode: .scaleAspectFit)
        let simpleMessage = PowSimpleMessage(image: image, title: title, description: description)
        
        // Generate buttons content
        let buttonFont = MainFont.medium.with(size: 16)
        
        // Close button - Just dismiss pow when the button is tapped
        let closeButtonLabelStyle = PowProperty.LabelStyle(font: buttonFont, color: PowColor.Gray.a800)
        let closeButtonLabel = PowProperty.LabelContent(text: "NOT NOW", style: closeButtonLabelStyle)
        let closeButton = PowProperty.ButtonContent(label: closeButtonLabel, backgroundColor: .clear, highlightedBackgroundColor:  PowColor.Gray.a800.withAlphaComponent(0.05)) {
            Pow.dismiss()
        }
        
        // Ok Button - Make transition to a new pow when the button is tapped
        let okButtonLabelStyle = PowProperty.LabelStyle(font: buttonFont, color: PowColor.Teal.a600)
        let okButtonLabel = PowProperty.LabelContent(text: "SHOW ME", style: okButtonLabelStyle)
        let okButton = PowProperty.ButtonContent(label: okButtonLabel, backgroundColor: .clear, highlightedBackgroundColor:  PowColor.Teal.a600.withAlphaComponent(0.05)) { [unowned self] in
            var attributes = self.dataSource.bottomAlertAttributes
            attributes.powBackground = .color(color: PowColor.Teal.a600)
            attributes.entranceAnimation = .init(translate: .init(duration: 0.65, spring: .init(damping: 0.8, initialVelocity: 0)))
            let image = UIImage(named: "ic_success")!
            let title = "Congratz!"
            let description = "Your book coupon is 5w1ft3ntr1k1t"
            self.showPopupMessage(attributes: attributes, title: title, titleColor: .white, description: description, descriptionColor: .white, buttonTitleColor: .darkSubText, buttonBackgroundColor: .white, image: image, imagePosition: .topToTop(offset: 25))
        }
        let buttonsBarContent = PowProperty.ButtonBarContent(with: closeButton, okButton, okButton, separatorColor: PowColor.Gray.light, expandAnimatedly: true)
        
        // Generate the content
        let alertMessage = PowAlertMessage(simpleMessage: simpleMessage, imagePosition: .left, buttonBarContent: buttonsBarContent)
        
        let contentView = PowAlertMessageView(with: alertMessage)
        
        Pow.display(contentView, using: attributes)
    }
    
    private func showAlertView(attributes: PowAttributes) {
        
        // Generate textual content
        let title = PowProperty.LabelContent(text: "Hopa!", style: .init(font: MainFont.medium.with(size: 15), color: .black, alignment: .center))
        let description = PowProperty.LabelContent(text: "This is a system-like alert, with several buttons. You can display even more buttons if you want. Click on one of them to dismiss it.", style: .init(font: MainFont.light.with(size: 13), color: .black, alignment: .center))
        let image = PowProperty.ImageContent(imageName: "ic_apple", size: CGSize(width: 25, height: 25), contentMode: .scaleAspectFit)
        let simpleMessage = PowSimpleMessage(image: image, title: title, description: description)
        
        // Generate buttons content
        let buttonFont = MainFont.medium.with(size: 16)
        
        // Close button
        let closeButtonLabelStyle = PowProperty.LabelStyle(font: buttonFont, color: PowColor.Gray.a800)
        let closeButtonLabel = PowProperty.LabelContent(text: "NOT NOW", style: closeButtonLabelStyle)
        let closeButton = PowProperty.ButtonContent(label: closeButtonLabel, backgroundColor: .clear, highlightedBackgroundColor:  PowColor.Gray.a800.withAlphaComponent(0.05)) {
            Pow.dismiss()
        }
        
        // Remind me later Button
        let laterButtonLabelStyle = PowProperty.LabelStyle(font: buttonFont, color: PowColor.Teal.a600)
        let laterButtonLabel = PowProperty.LabelContent(text: "MAYBE LATER", style: laterButtonLabelStyle)
        let laterButton = PowProperty.ButtonContent(label: laterButtonLabel, backgroundColor: .clear, highlightedBackgroundColor:  PowColor.Teal.a600.withAlphaComponent(0.05)) {
            Pow.dismiss()
        }
        
        // Ok Button
        let okButtonLabelStyle = PowProperty.LabelStyle(font: buttonFont, color: PowColor.Teal.a600)
        let okButtonLabel = PowProperty.LabelContent(text: "SHOW ME", style: okButtonLabelStyle)
        let okButton = PowProperty.ButtonContent(label: okButtonLabel, backgroundColor: .clear, highlightedBackgroundColor:  PowColor.Teal.a600.withAlphaComponent(0.05)) {
            Pow.dismiss()
        }
        
        // Generate the content
        let buttonsBarContent = PowProperty.ButtonBarContent(with: okButton, laterButton, closeButton, separatorColor: PowColor.Gray.light, expandAnimatedly: true)
        
        let alertMessage = PowAlertMessage(simpleMessage: simpleMessage, buttonBarContent: buttonsBarContent)

        // Setup the view itself
        let contentView = PowAlertMessageView(with: alertMessage)
        
        Pow.display(contentView, using: attributes)
    }
    
    // Bumps a custom nib view
    private func showCustomNibView(attributes: PowAttributes) {
        Pow.display(NibExampleView(), using: attributes)
    }
    
    // Sign in form
    private func showSigninForm(attributes: PowAttributes, style: FormStyle) {
        let title = PowProperty.LabelContent(text: "Sign in to your account", style: style.title)
        let textFields = FormFieldPresetFactory.fields(by: [.email, .password], style: style)
        let button = PowProperty.ButtonContent(label: .init(text: "Continue", style: style.buttonTitle), backgroundColor: style.buttonBackground, highlightedBackgroundColor: style.buttonBackground.withAlphaComponent(0.8)) {
            Pow.dismiss()
        }
        let contentView = PowFormMessageView(with: title, textFieldsContent: textFields, buttonContent: button)
        Pow.display(contentView, using: attributes)
    }
    
    // Sign up form
    private func showSignupForm(attributes: PowAttributes, style: FormStyle) {
        let title = PowProperty.LabelContent(text: "Fill your personal details", style: style.title)
        let textFields = FormFieldPresetFactory.fields(by: [.fullName, .mobile, .email, .password], style: style)
        let button = PowProperty.ButtonContent(label: .init(text: "Continue", style: style.buttonTitle), backgroundColor: style.buttonBackground, highlightedBackgroundColor: style.buttonBackground.withAlphaComponent(0.8)) {
            Pow.dismiss()
        }
        let contentView = PowFormMessageView(with: title, textFieldsContent: textFields, buttonContent: button)
        Pow.display(contentView, using: attributes)
    }
}

// MARK: UITableViewDelegate, UITableViewDataSource
extension PresetsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let attributes = dataSource[indexPath.section, indexPath.row].attributes
        switch indexPath.section {
        case 0:
            toastCellSelected(with: attributes, row: indexPath.row)
        case 1:
            noteCellSelected(with: attributes, row: indexPath.row)
        case 2:
            floatCellSelected(with: attributes, row: indexPath.row)
        case 3:
            popupCellSelected(with: attributes, row: indexPath.row)
        case 4:
            formCellSelected(with: attributes, row: indexPath.row)
        case 5:
            customCellSelected(with: attributes, row: indexPath.row)
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PresetTableViewCell.className, for: indexPath) as! PresetTableViewCell
        cell.presetDescription = dataSource[indexPath.section, indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: SelectionHeaderView.className) as! SelectionHeaderView
        header.text = dataSource[section].title
        return header
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataSource.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource[section].data.count
    }
    
    // iOS 9, 10 support
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
}

// MARK: Selection Helpers
extension PresetsViewController {
    
    private func toastCellSelected(with attributes: PowAttributes, row: Int) {
        switch row {
        case 0:
            let title = "Mail Received!"
            let desc = "Daniel sent you a message"
            showNotificationMessage(attributes: attributes, title: title, desc: desc, textColor: .white, imageName: "paper-plane-light")
        case 1:
            showChatNotificationMessage(attributes: attributes)
        case 2:
            let title = "15% Discount!"
            let desc = "Receive your coupon for 15% discount at Swifty Kitty Bakery"
            showNotificationMessage(attributes: attributes, title: title, desc: desc, textColor: .black, imageName: "ic_pizza")
        default:
            break
        }
    }
    
    private func noteCellSelected(with attributes: PowAttributes, row: Int) {
        switch row {
        case 0:
            showNote(attributes: attributes)
        case 1:
            showProcessingNote(attributes: attributes)
        case 2:
            showImageNote(attributes: attributes)
        case 3:
            showStatusBarMessage(attributes: attributes)
        case 4:
            showNote(attributes: attributes)
        default:
            break
        }
    }
    
    private func floatCellSelected(with attributes: PowAttributes, row: Int) {
        let title = "Kofi Shop"
        let desc = "Over two weeks of quality coffee beans concentrated into a single pow kit"
        let image = "ic_coffee_light"
        switch row {
        case 0:
            showNotificationMessage(attributes: attributes, title: title, desc: desc, textColor: .white, imageName: image)
        case 1:
            showNotificationMessage(attributes: attributes, title: title, desc: desc, textColor: .white, imageName: image)
        default:
            break
        }
    }
    
    private func popupCellSelected(with attributes: PowAttributes, row: Int) {
        switch row {
        case 0:
            showDarkAwesomePopupMessage(attributes: attributes)
        case 1:
            showLightAwesomePopupMessage(attributes: attributes)
        case 2:
            showLightAwesomePopupMessage(attributes: attributes)
        case 3:
            showButtonBarMessage(attributes: attributes)
        case 4:
            showAlertView(attributes: attributes)
        default:
            break
        }
    }
    
    private func formCellSelected(with attributes: PowAttributes, row: Int) {
        switch row {
        case 0:
            showSigninForm(attributes: attributes, style: .light)
        case 1:
            showSignupForm(attributes: attributes, style: .light)
        case 2:
            showSignupForm(attributes: attributes, style: .dark)
        default:
            break
        }
    }
    
    private func customCellSelected(with attributes: PowAttributes, row: Int) {
        switch row {
        case 0:
            showCustomNibView(attributes: attributes)
        default:
            break
        }
    }
}
