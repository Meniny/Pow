//
//  PowAccessoryNoteMessageView.swift
//  Pow
//
//  Created by Elias Abel on 5/4/18.
//

import UIKit
import PapaLayout

public class PowAccessoryNoteMessageView: UIView {

    // MARK: Props
    private let contentView = UIView()
    private var noteMessageView: PowNoteMessageView!
    var accessoryView: UIView!

    func setup(with content: PowProperty.LabelContent) {
        clipsToBounds = true
        
        addSubview(contentView)
//        contentView.centerHorizontally().top(0).bottom(0)
        contentView.layoutToSuperview(.centerX, .top, .bottom)
        
        noteMessageView = PowNoteMessageView(with: content)
        noteMessageView.horizontalOffset = 8
        noteMessageView.verticalOffset = 7
        contentView.addSubview(noteMessageView)
//        noteMessageView.top(0).bottom(0).right(0)
        noteMessageView.layoutToSuperview(.top, .bottom, .trailing)
        
        contentView.addSubview(accessoryView)
//        accessoryView.left(0).centerVertically()
        accessoryView.layoutToSuperview(.leading, .centerY)
        accessoryView.layout(.trailing, to: .leading, of: noteMessageView)
//        accessoryView.rightAttribute == noteMessageView.leftAttribute
    }
}
