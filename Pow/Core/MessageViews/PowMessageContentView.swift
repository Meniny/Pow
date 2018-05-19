//
//  PowMessageContentView.swift
//  Pow
//
//  Created by Elias Abel on 4/19/18.
//  Copyright (c) 2018 Meniny Lab. All rights reserved.
//

import UIKit
import PapaLayout

public class PowMessageContentView: UIView {
    
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    
    private var horizontalConstraints: PPAxisConstraints!
    private var topConstraint: NSLayoutConstraint!
    private var bottomConstraint: NSLayoutConstraint!
    private var labelsOffsetConstraint: NSLayoutConstraint!
    
    public var titleContent: PowProperty.LabelContent! {
        didSet {
            titleLabel.labelContent = titleContent
        }
    }
    
    public var subtitleContent: PowProperty.LabelContent! {
        didSet {
            subtitleLabel.labelContent = subtitleContent
        }
    }
    
    public var titleAttributes: PowProperty.LabelStyle! {
        didSet {
            titleLabel.attributes = titleAttributes
        }
    }
    
    public var subtitleAttributes: PowProperty.LabelStyle! {
        didSet {
            subtitleLabel.attributes = subtitleAttributes
        }
    }
    
    public var title: String! {
        didSet {
            titleLabel.text = title
        }
    }
    
    public var subtitle: String! {
        didSet {
            subtitleLabel.text = subtitle
        }
    }
    
    public var verticalMargins: CGFloat = 20 {
        didSet {
            topConstraint.constant = verticalMargins
            bottomConstraint.constant = -verticalMargins
            layoutIfNeeded()
        }
    }
    
    public var horizontalMargins: CGFloat = 20 {
        didSet {
            horizontalConstraints.first.constant = horizontalMargins
            horizontalConstraints.second.constant = -horizontalMargins
            layoutIfNeeded()
        }
    }
    
    public var labelsOffset: CGFloat = 8 {
        didSet {
            labelsOffsetConstraint.constant = labelsOffset
            layoutIfNeeded()
        }
    }
    
    // MARK: Setup
    
    public init() {
        super.init(frame: UIScreen.main.bounds)
        clipsToBounds = true
        setupTitleLabel()
        setupSubtitleLabel()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupTitleLabel() {
        addSubview(titleLabel)
        titleLabel.numberOfLines = 0
        topConstraint = titleLabel.layoutToSuperview(.top, offset: verticalMargins)
        horizontalConstraints = titleLabel.layoutToSuperview(axis: .horizontally, offset: horizontalMargins)
        titleLabel.forceContentWrap(.vertically)
    }
    
    private func setupSubtitleLabel() {
        addSubview(subtitleLabel)
        subtitleLabel.numberOfLines = 0
        labelsOffsetConstraint = subtitleLabel.layout(.top, to: .bottom, of: titleLabel, offset: labelsOffset)
        subtitleLabel.layout(to: .left, of: titleLabel)
        subtitleLabel.layout(to: .right, of: titleLabel)
        bottomConstraint = subtitleLabel.layoutToSuperview(.bottom, offset: -verticalMargins, priority: .must)
        subtitleLabel.forceContentWrap(.vertically)
    }
}
