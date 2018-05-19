//
//  PowImageNoteMessageView.swift
//  Pow
//
//  Created by Elias Abel on 5/4/18.
//

import Foundation
import UIKit
import PapaLayout

public class PowImageNoteMessageView: PowAccessoryNoteMessageView {
    
    // MARK: Setup
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public init(with content: PowProperty.LabelContent, imageContent: PowProperty.ImageContent) {
        super.init(frame: UIScreen.main.bounds)
        setup(with: content, imageContent: imageContent)
    }
    
    private func setup(with content: PowProperty.LabelContent, imageContent: PowProperty.ImageContent) {
        let imageView = UIImageView()
        imageView.imageContent = imageContent
        accessoryView = imageView
        super.setup(with: content)
    }
}
