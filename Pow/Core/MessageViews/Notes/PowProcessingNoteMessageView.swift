//
//  PowProcessingNoteMessageView.swift
//  Pow
//
//  Created by Elias Abel on 4/20/18.
//  Copyright (c) 2018 Meniny Lab. All rights reserved.
//

import UIKit
import PapaLayout

public class PowProcessingNoteMessageView: PowAccessoryNoteMessageView {
    
    // MARK: Props
    private var activityIndicatorView: UIActivityIndicatorView!
    private var noteMessageView: PowNoteMessageView!
    
    /** Activity indication can be turned off / on */
    public var isProcessing: Bool = true {
        didSet {
            if isProcessing {
                activityIndicatorView.startAnimating()
            } else {
                activityIndicatorView.stopAnimating()
            }
        }
    }
    
    // MARK: Setup
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public init(with content: PowProperty.LabelContent, activityIndicator: UIActivityIndicatorViewStyle) {
        super.init(frame: UIScreen.main.bounds)
        setup(with: content, activityIndicator: activityIndicator)
    }
    
    private func setup(with content: PowProperty.LabelContent, activityIndicator: UIActivityIndicatorViewStyle, setProcessing: Bool = true) {
        activityIndicatorView = UIActivityIndicatorView()
        activityIndicatorView.activityIndicatorViewStyle = activityIndicator
        isProcessing = setProcessing
        accessoryView = activityIndicatorView
        super.setup(with: content)
    }
}
