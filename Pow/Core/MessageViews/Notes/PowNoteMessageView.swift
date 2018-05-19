//
//  PowNoteMessageView.swift
//  Pow
//
//  Created by Elias Abel on 4/19/18.
//  Copyright (c) 2018 Meniny Lab. All rights reserved.
//

import UIKit
import PapaLayout
import PapaLayout

public class PowNoteMessageView: UIView {
    
    // MARK: Props
    private let label = UILabel()
    
    private var horizontalConstrainsts: PPAxisConstraints!
    private var verticalConstrainsts: PPAxisConstraints!
    
    public var horizontalOffset: CGFloat = 10 {
        didSet {
            horizontalConstrainsts.first.constant = horizontalOffset
            horizontalConstrainsts.second.constant = -horizontalOffset
            layoutIfNeeded()
        }
    }
    
    public var verticalOffset: CGFloat = 5 {
        didSet {
            verticalConstrainsts.first.constant = verticalOffset
            verticalConstrainsts.second.constant = -verticalOffset
            layoutIfNeeded()
        }
    }
    
    // MARK: Setup
    public init(with content: PowProperty.LabelContent) {
        super.init(frame: UIScreen.main.bounds)
        setup(with: content)
    }

    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup(with content: PowProperty.LabelContent) {
        clipsToBounds = true
        addSubview(label)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.labelContent = content
        horizontalConstrainsts = label.layoutToSuperview(axis: .horizontally, offset: horizontalOffset, priority: .must)
        verticalConstrainsts = label.layoutToSuperview(axis: .vertically, offset: verticalOffset, priority: .must)
    }
}
