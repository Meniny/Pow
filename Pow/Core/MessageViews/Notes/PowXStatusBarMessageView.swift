//
//  PowXStatusBarMessageView.swift
//  Pow
//
//  Created by Elias Abel on 4/19/18.
//  Copyright (c) 2018 Meniny Lab. All rights reserved.
//

import UIKit
import PapaLayout
import PapaLayout

public class PowXStatusBarMessageView: UIView {
    
    // MARK: Props
    private let leadingLabel = UILabel()
    private let trailingLabel = UILabel()
    
    // MARK: Setup
    public init(leading: PowProperty.LabelContent, trailing: PowProperty.LabelContent) {
        super.init(frame: UIScreen.main.bounds)
        setup(leading: leading, trailing: trailing)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup(leading: PowProperty.LabelContent, trailing: PowProperty.LabelContent) {
        clipsToBounds = true
        
        set(.height, of: UIApplication.shared.statusBarFrame.maxY)
        
        addSubview(leadingLabel)
        leadingLabel.numberOfLines = 0
        leadingLabel.textAlignment = .center
        leadingLabel.labelContent = leading
        
        leadingLabel.layoutToSuperview(axis: .vertically)
        leadingLabel.layoutToSuperview(.leading)
        leadingLabel.layoutToSuperview(.width, ratio: 0.26)
        
        addSubview(trailingLabel)
        trailingLabel.numberOfLines = 0
        trailingLabel.textAlignment = .center
        trailingLabel.labelContent = trailing
        
        trailingLabel.layoutToSuperview(axis: .vertically)
        trailingLabel.layoutToSuperview(.trailing)
        trailingLabel.layoutToSuperview(.width, ratio: 0.26)
    }
}
