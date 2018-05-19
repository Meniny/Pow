//
//  EntryViewController.swift
//  Pow
//
//  Created by Elias Abel on 4/19/18.
//  Copyright (c) 2018 Meniny Lab. All rights reserved.
//

import UIKit

class PowRootViewController: UIViewController {
    
    // MARK: Props
    private var lastAttributes: PowAttributes!
    private var tapGestureRecognizer: UITapGestureRecognizer!
    
    private let backgroundView = PowBackgroundView()

    // Previous status bar style
    private var previousStatusBarStyle: UIStatusBarStyle = UIApplication.shared.statusBarStyle
    
    private lazy var wrapperView: PowWrapperView = {
        return PowWrapperView()
    }()
    
    private var lastEntry: PowContentView? {
        return view.subviews.last as? PowContentView
    }
    
    private var isResponsive: Bool = false {
        didSet {
            wrapperView.isAbleToReceiveTouches = isResponsive
            PowWindowProvider.shared.powWindow.isAbleToReceiveTouches = isResponsive
        }
    }
    
    // MARK: Lifecycle
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    override public func loadView() {
        view = wrapperView
        view.insertSubview(backgroundView, at: 0)
        backgroundView.isUserInteractionEnabled = false
        backgroundView.fillSuperview()
    }
    
    override public func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        UIApplication.shared.statusBarStyle = previousStatusBarStyle
    }
    
    // MARK: Setup
    func configure(newEntryView: UIView, attributes: PowAttributes) {
        guard checkPriorityPrecedence(for: attributes) else {
            return
        }
        
        removeLastEntry(keepWindow: true)

        lastAttributes = attributes
        
        setStatusBarStyle(by: attributes)
                
        let powContentView = PowContentView(withEntryDelegate: self)
        view.addSubview(powContentView)
        powContentView.setup(with: newEntryView, attributes: attributes)
        
        isResponsive = attributes.screenInteraction.isResponsive
    }
    
    private func setStatusBarStyle(by attributes: PowAttributes) {
        guard let style = attributes.statusBarStyle, style != UIApplication.shared.statusBarStyle else {
            return
        }
        UIApplication.shared.statusBarStyle = style
    }
    
    // Check priority precedence for a given pow
    private func checkPriorityPrecedence(for attributes: PowAttributes) -> Bool {
        guard let lastAttributes = lastAttributes else {
            return true
        }
        return attributes.displayPriority >= lastAttributes.displayPriority
    }

    // Removes last pow - can keep the window 'ON' if necessary
    private func removeLastEntry(keepWindow: Bool) {
        guard let attributes = lastAttributes else {
            return
        }
        if attributes.popBehavior.isOverriden {
            lastEntry?.removePromptly()
        } else {
            popLastEntry()
        }
    }
    
    // Make last pow exit using exitAnimation - animatedly
    func animateOutLastEntry() {
        lastEntry?.animateOut(pushOut: false)
    }
    
    // Pops last pow (using pop animation) - animatedly
    func popLastEntry() {
        lastEntry?.animateOut(pushOut: true)
    }
}

// MARK: UIResponder
extension PowRootViewController {
    
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        switch lastAttributes.screenInteraction.defaultAction {
        case .dismissEntry:
            lastEntry?.animateOut(pushOut: false)
            fallthrough
        default:
            lastAttributes.screenInteraction.customTapActions.forEach { $0() }
        }
    }
}

// MARK: EntryScrollViewDelegate
extension PowRootViewController: EntryContentViewDelegate {
    
    func changeToActive(withAttributes attributes: PowAttributes) {
        changeBackground(to: attributes.screenBackground, duration: attributes.entranceAnimation.totalDuration)
    }
    
    func changeToInactive(withAttributes attributes: PowAttributes) {
        guard PowAttributes.count <= 1 else {
            return
        }
        changeBackground(to: .clear, duration: attributes.exitAnimation.totalDuration)
    }
    
    private func changeBackground(to style: PowAttributes.BackgroundStyle, duration: TimeInterval) {
        DispatchQueue.main.async {
            UIView.animate(withDuration: duration, delay: 0, options: [], animations: {
                self.backgroundView.background = style
            }, completion: nil)
        }
    }
}

