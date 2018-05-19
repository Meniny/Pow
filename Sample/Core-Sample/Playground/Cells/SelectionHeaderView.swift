//
//  SelectionHeaderView.swift
//  Core-Sample
//
//  Created by Elias Abel on 4/26/18.
//  Copyright (c) 2018 Meniny Lab. All rights reserved.
//

import UIKit

class SelectionHeaderView: UITableViewHeaderFooterView {

    var text: String {
        set {
            textLabel?.text = newValue
        }
        get {
            return textLabel?.text ?? ""
        }
    }
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        backgroundView = UIView()
        backgroundView?.backgroundColor = PowColor.BlueGray.c50.withAlphaComponent(0.95)
        textLabel?.font = MainFont.bold.with(size: 17)
        textLabel?.textColor = PowColor.BlueGray.c900
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
