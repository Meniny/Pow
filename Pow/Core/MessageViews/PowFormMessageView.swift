//
//  PowFormMessageView.swift
//  Pow
//
//  Created by Elias Abel on 5/15/18.
//

import UIKit
import PapaLayout

public class PowFormMessageView: UIView {
    
    private let scrollViewVerticalOffset: CGFloat = 20
    
    // MARK: Props
    public let titleLabel = UILabel()
    public let scrollView = UIScrollView()
    public private(set) var textFieldViews: [PowTextField] = []
    public private(set) var buttonBarView: PowButtonBarView!
    
    // MARK: Setup
    public init(with title: PowProperty.LabelContent, textFieldsContent: [PowProperty.TextFieldContent], buttonContent: PowProperty.ButtonContent) {
        super.init(frame: UIScreen.main.bounds)
        setupScrollView()
        setupTitleLabel(with: title)
        setupTextFields(with: textFieldsContent)
        setupButton(with: buttonContent)
        setupTapGestureRecognizer()
        scrollView.layoutIfNeeded()
//        height(scrollView.contentSize.height + scrollViewVerticalOffset * 2)
        set(.height, of: scrollView.contentSize.height + scrollViewVerticalOffset * 2, priority: .defaultHigh)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupTextFields(with textFieldsContent: [PowProperty.TextFieldContent]) {
        textFieldViews = textFieldsContent.map { content -> PowTextField in
            let textField = PowTextField(with: content)
            scrollView.addSubview(textField)
            return textField
        }
        
//        textFieldViews.first!.topAttribute == titleLabel.bottomAttribute + 20
        textFieldViews.first!.layout(.top, to: .bottom, of: titleLabel, offset: 20)
//        var anys = [Any]()
//        for tv in textFieldViews {
//            anys.append(contentsOf: [|-0-tv-0-|])
//            anys.append(5)
//        }
//        anys.removeLast()
//        stack(vertically: anys)
        textFieldViews.spread(.vertically, offset: 5)
        textFieldViews.layoutToSuperview(axis: .horizontally)
    }
    
    // Setup tap gesture
    private func setupTapGestureRecognizer() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapGestureRecognized))
        tapGestureRecognizer.numberOfTapsRequired = 1
        addGestureRecognizer(tapGestureRecognizer)
    }
    
    private func setupScrollView() {
        addSubview(scrollView)
//        scrollView.left(20).right(20)
//        scrollView.top(scrollViewVerticalOffset).bottom(scrollViewVerticalOffset)
        scrollView.layoutToSuperview(axis: .horizontally, offset: 20)
        scrollView.layoutToSuperview(axis: .vertically, offset: scrollViewVerticalOffset)
        scrollView.layoutToSuperview(.width, .height, offset: -scrollViewVerticalOffset * 2)
    }
    
    private func setupTitleLabel(with title: PowProperty.LabelContent) {
        scrollView.addSubview(titleLabel)
        titleLabel.layoutToSuperview(.top, .width)
        titleLabel.layoutToSuperview(axis: .horizontally)
        titleLabel.forceContentWrap(.vertically)
        titleLabel.labelContent = title
    }
    
    private func setupButton(with buttonContent: PowProperty.ButtonContent) {
        let buttonsBarContent = PowProperty.ButtonBarContent(with: buttonContent, separatorColor: .clear, expandAnimatedly: true)
        buttonBarView = PowButtonBarView(with: buttonsBarContent)
        buttonBarView.clipsToBounds = true
        scrollView.addSubview(buttonBarView)
        buttonBarView.expand()
        buttonBarView.layout(.top, to: .bottom, of: textFieldViews.last!, offset: 20)
        buttonBarView.layoutToSuperview(.centerX)
        buttonBarView.layoutToSuperview(.width, offset: -40)
        buttonBarView.layoutToSuperview(.bottom)
        buttonBarView.layer.cornerRadius = 5
    }
    
    // Tap Gesture
    @objc func tapGestureRecognized() {
        endEditing(true)
    }
}
