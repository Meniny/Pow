//
//  PowNotificationMessageView.swift
//  Pow
//
//  Created by Elias Abel on 4/19/18.
//  Copyright (c) 2018 Meniny Lab. All rights reserved.
//

import UIKit
import PapaLayout

public class PowNotificationMessageView: PowSimpleMessageView {
    
    // MARK: Props
    private let auxLabel = UILabel()
    
    // MARK: Setup
    public init(with message: PowNotificationMessage) {
        super.init(with: message.simpleMessage)
        setupAuxLabel(with: message.auxiliary)
        layoutContent()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupAuxLabel(with content: PowProperty.LabelContent?) {
        if let content = content {
            auxLabel.labelContent = content
        }
        addSubview(auxLabel)
    }
    
    private func layoutContent() {
        
        messageContentView.verticalMargins = 0
        messageContentView.horizontalMargins = 0
        messageContentView.labelsOffset = 5
        
        thumbImageView.layoutToSuperview(.top, .left, offset: 16)

        auxLabel.layoutToSuperview(.right, offset: -16)
        auxLabel.layoutToSuperview(.top, offset: 18)
        auxLabel.forceContentWrap()
        
        messageContentView.layout(.left, to: .right, of: thumbImageView, offset: 12)
        messageContentView.layout(.right, to: .left, of: auxLabel)
        messageContentView.layout(to: .top, of: thumbImageView, offset: 4)
        messageContentView.layoutToSuperview(.bottom, offset: -20)
    }
}
