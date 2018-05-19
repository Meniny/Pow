//
//  PowAlertMessageView.swift
//  Pow
//
//  Created by Elias Abel on 5/5/18.
//

import UIKit
import PapaLayout

public class PowAlertMessageView: PowSimpleMessageView {
    
    // MARK: Props
    private var buttonBarView: PowButtonBarView!
    private var buttonsBarCompressedConstraint: NSLayoutConstraint!
    private var buttonsBarExpandedConstraint: NSLayoutConstraint!
    
    // MARK: Setup
    public init(with message: PowAlertMessage) {
        super.init(with: message.simpleMessage)
        setupButtonBarView(with: message.buttonBarContent)
        layoutContent(with: message)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupButtonBarView(with content: PowProperty.ButtonBarContent) {
        buttonBarView = PowButtonBarView(with: content)
        buttonBarView.clipsToBounds = true
        addSubview(buttonBarView)
    }
    
    func layoutContent(with message: PowAlertMessage) {

        switch message.imagePosition {
        case .top:
            messageContentView.verticalMargins = 16
            messageContentView.horizontalMargins = 16
            messageContentView.labelsOffset = 5
            
//            thumbImageView.top(20).centerHorizontally()
            thumbImageView.layoutToSuperview(.top, offset: 20)
            thumbImageView.layoutToSuperview(.centerX)
            
//            messageContentView.topAttribute == thumbImageView.bottomAttribute
//            messageContentView.left(0).right(0)
//            buttonBarView.topAttribute == messageContentView.bottomAttribute
            messageContentView.layout(.top, to: .bottom, of: thumbImageView)
            messageContentView.layoutToSuperview(axis: .horizontally)
            buttonBarView.layout(.top, to: .bottom, of: messageContentView)
        case .left:
            messageContentView.verticalMargins = 0
            messageContentView.horizontalMargins = 0
            messageContentView.labelsOffset = 5
            
//            thumbImageView.top(16).left(16)
            thumbImageView.layoutToSuperview(.top, .left, offset: 16)

//            messageContentView.leftAttribute == thumbImageView.rightAttribute + 12
            messageContentView.layout(.left, to: .right, of: thumbImageView, offset: 12)
//            messageContentView.right(16)
            messageContentView.layoutToSuperview(.right, offset: -16)
//            messageContentView.topAttribute == thumbImageView.topAttribute + 2
            messageContentView.layout(to: .top, of: thumbImageView, offset: 2)
//            buttonBarView.topAttribute == messageContentView.bottomAttribute + 10
            buttonBarView.layout(.top, to: .bottom, of: messageContentView, offset: 10)
        }
        
//        buttonBarView.left(0).right(0).bottom(0)
        buttonBarView.layoutToSuperview(axis: .horizontally)
        buttonBarView.layoutToSuperview(.bottom)
        buttonBarView.alpha = 0

        if !message.buttonBarContent.content.isEmpty {
            if message.buttonBarContent.expandAnimatedly {
                let damping: CGFloat = message.buttonBarContent.content.count <= 2 ? 0.4 : 0.8
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.animateIn(damping: damping)
                }
            } else {
                buttonBarView.alpha = 1
                buttonBarView.expand()
                Pow.layoutIfNeeded()
            }
        }
    }
    
    // MARK: Internal Animation
    private func animateIn(damping: CGFloat) {
        layoutIfNeeded()
        buttonBarView.alpha = 1
        
        UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: damping, initialSpringVelocity: 0, options: [.beginFromCurrentState, .allowUserInteraction, .layoutSubviews], animations: {
            
            // Expand
            self.buttonBarView.expand()
            
            /* NOTE: Calling layoutIfNeeded for the whole view hierarchy.
             Sometimes it's easier to just use frames instead of AutoLayout for
             hierarch complexity considerations. Here the animation influences almost the
             entire view hierarchy. */
            Pow.layoutIfNeeded()
            
        }, completion: nil)
    }
}
