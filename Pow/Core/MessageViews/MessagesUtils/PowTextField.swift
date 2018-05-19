//
//  PowTextField.swift
//  Pow
//
//  Created by Elias Abel on 5/16/18.
//

import Foundation
import UIKit

public class PowTextField: UIView {
    
    static let totalHeight: CGFloat = 45
    
    public let content: PowProperty.TextFieldContent
    
    public let imageView = UIImageView()
    public let textField = UITextField()
    
    init(with content: PowProperty.TextFieldContent) {
        self.content = content
        super.init(frame: UIScreen.main.bounds)
        setupImageView()
        setupTextField()
        setupSeparatorView()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupImageView() {
        addSubview(imageView)
        imageView.contentMode = .center
        imageView.set(.width, .height, of: PowTextField.totalHeight)
        imageView.layoutToSuperview(.leading)
        imageView.image = content.leadingImage
    }
    
    private func setupTextField() {
        addSubview(textField)
        textField.textFieldContent = content
        textField.set(.height, of: PowTextField.totalHeight)
        textField.layout(.leading, to: .trailing, of: imageView)
        textField.layoutToSuperview(.top, .trailing)
        
        imageView.layout(to: .centerY, of: textField)
    }
    
    private func setupSeparatorView() {
        let separatorView = UIView()
        addSubview(separatorView)
        separatorView.backgroundColor = content.bottomBorderColor
        separatorView.layout(.top, to: .bottom, of: textField)
        separatorView.set(.height, of: 1)
        separatorView.layoutToSuperview(.bottom)
        separatorView.layoutToSuperview(axis: .horizontally, offset: 10)
    }
}
