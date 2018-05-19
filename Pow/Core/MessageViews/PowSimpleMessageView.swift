//
//  PowMessageView.swift
//  Pow
//
//  Created by Elias Abel on 5/5/18.
//

import UIKit

public class PowSimpleMessageView: UIView {

    // MARK: Props
    let thumbImageView = UIImageView()
    let messageContentView = PowMessageContentView()
    
    // MARK: Setup
    init(with message: PowSimpleMessage) {
        super.init(frame: UIScreen.main.bounds)
        setupThumbImageView(with: message.image)
        setupMessageContentView(with: message.title, description: message.description)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupThumbImageView(with content: PowProperty.ImageContent) {
        addSubview(thumbImageView)
        thumbImageView.imageContent = content
    }
    
    private func setupMessageContentView(with title: PowProperty.LabelContent, description: PowProperty.LabelContent) {
        messageContentView.titleContent = title
        messageContentView.subtitleContent = description
        addSubview(messageContentView)
    }    
}
